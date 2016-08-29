//
//  CCSStockListViewController.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/6/22.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSStockListViewController.h"

#import "CCSAppDelegate.h"

#import "CCSSampleGroupChartDemoViewController.h"

typedef enum {
    StockRankUp                         = 0,
    StockRankDown                       = 1
} StockRankType;

@interface CCSStockListViewController (){
    NSArray                                         *_stocksUp;
    NSArray                                         *_stocksDown;
}

@end

@implementation CCSStockListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"股票列表"];
    
    self.scalePrice = 2;
    
    [self loadStocksWithRankType: StockRankUp];
//    [self loadStocksWithRankType: StockRankDown];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Deselet the row with animation
    [self.tbStocks deselectRowAtIndexPath:[self.tbStocks indexPathForSelectedRow] animated:YES];
    // Scroll the selected row to the center
    [self.tbStocks scrollToRowAtIndexPath:[self.tbStocks indexPathForSelectedRow]
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*******************************************************************************
 * Implements Of UITableViewDataSource
 *******************************************************************************/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return IIF(_stocksUp, _stocksUp.count, 0);
    }else{
        return IIF(_stocksDown, _stocksDown.count, 0);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        UILabel *lblTitle = [[UILabel alloc] init];
        lblTitle.backgroundColor = [UIColor grayColor];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"涨幅";
        return lblTitle;
    } else if (section == 1) {
        UILabel *lblTitle = [[UILabel alloc] init];
        lblTitle.backgroundColor = [UIColor grayColor];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"跌幅";
        return lblTitle;
    } else {
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    NSArray *stocks = IIF(indexPath.section == 0, _stocksUp, _stocksDown);
    
    cell.textLabel.text = stocks[indexPath.row][@"secShortName"];
    
    CGFloat changeValue = [stocks[indexPath.row][@"change"] doubleValue];
    CGFloat percent = changeValue/[stocks[indexPath.row][@"prevClosePrice"] doubleValue]*100;
    if (changeValue > 0) {
        [cell.detailTextLabel setTextColor: LINE_COLORS[0]];
        [cell.detailTextLabel setText: [NSString stringWithFormat:@"%@(%@)", [[CGFloatToNSString(changeValue) decimal: self.scalePrice] concate:@"+"], [[[CGFloatToNSString(percent) decimal: self.scalePrice] concate:@"+"] append:@"%"]]];
    }else{
        [cell.detailTextLabel setTextColor: LINE_COLORS[1]];
        [cell.detailTextLabel setText: [NSString stringWithFormat:@"%@(%@)", [CGFloatToNSString(changeValue) decimal: self.scalePrice], [[CGFloatToNSString(percent) decimal: self.scalePrice] append:@"%"]]];
    }

    return cell;
}

/*******************************************************************************
 * Implements Of UITableViewDelegate
 *******************************************************************************/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CCSSampleGroupChartDemoViewController *ctrlSampleGroup = [[CCSSampleGroupChartDemoViewController alloc] init];
    NSArray *stocks = IIF(indexPath.section == 0, _stocksUp, _stocksDown);
    ctrlSampleGroup.productCode = stocks[indexPath.row][@"secID"];
    ctrlSampleGroup.scalePrice = self.scalePrice;
    
    [ctrlSampleGroup setTitle:stocks[indexPath.row][@"secShortName"]];
    
    CCSAppDelegate *appDelegate = (CCSAppDelegate *) [UIApplication sharedApplication].delegate;
    UINavigationController *navigationController = (UINavigationController *) appDelegate.viewController;
    [navigationController pushViewController:ctrlSampleGroup animated:YES];
}

/*******************************************************************************
 * Private Methods
 *******************************************************************************/

/**
 * 加载股票数据
 */
- (void)loadStocksWithRankType:(StockRankType) rankType{
    CCSWMCloudRequest *request = [[CCSWMCloudRequest alloc] initWithUrl: @"equity/getEqu.json"];

    NSMutableDictionary *dicParameters = [[NSMutableDictionary alloc] init];
    [dicParameters setObject:@"A" forKey:@"equTypeCD"];
    [dicParameters setObject:@"000001,000002,000003,000004,000005,000006" forKey:@"ticker"];
    
    [request setParameters: dicParameters];
    
    __weak __typeof__(self) weakSelf = self;
    [request getWithTag:RequestTagStockList success:^(AFHTTPRequestSerializer *operation, id responseObject) {
        if (rankType == StockRankUp) {
            _stocksUp = PARSE_JSON_DATA(responseObject)[@"data"];
        }else{
            _stocksDown = PARSE_JSON_DATA(responseObject)[@"data"];
        }
        [weakSelf.tbStocks reloadData];
    } failure:^(AFHTTPRequestSerializer *operation, id failure) {
    }];
}

@end
