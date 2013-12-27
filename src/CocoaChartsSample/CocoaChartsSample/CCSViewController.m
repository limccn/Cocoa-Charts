//
//  CCSViewController.m
//  Cocoa-Charts
//
//  Created by limc on 13-05-22.
//  Copyright (c) 2012 limc.cn All rights reserved.
//

#import "CCSViewController.h"
#import "CCSAppDelegate.h"
#import "CCSDetailViewController.h"
#import "CCSGridChartViewController.h"
#import "CCSLineChartViewController.h"
#import "CCSStickChartViewController.h"
#import "CCSMAStickChartViewController.h"
#import "CCSCandleStickChartViewController.h"
#import "CCSMACandleStickChartViewController.h"
#import "CCSPieChartViewController.h"
#import "CCSPizzaChartViewController.h"
#import "CCSSpiderWebChartViewController.h"
#import "CCSMinusStickChartViewController.h"
#import "CCSMACDChartViewController.h"
#import "CCSAreaChartViewController.h"
#import "CCSStackedAreaChartViewController.h"
#import "CCSBandAreaChartViewController.h"
#import "CCSRadarChartViewController.h"
#import "CCSSlipStickChartViewController.h"
#import "CCSColoredStickChartViewController.h"
#import "CCSSlipCandleStickChartViewController.h"
#import "CCSMASlipCandleStickChartViewController.h"
#import "CCSBOLLMASlipCandleStickChartViewController.h"
#import "CCSSlipLineChartViewController.h"
#import "CCSSimpleDemoViewController.h"

@interface CCSViewController ()
{
}

@end

@implementation CCSViewController
@synthesize tableView =_tableView;

- (void) dealloc
{
    [_tableView release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
                                                          style:UITableViewStylePlain];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin
    |UIViewAutoresizingFlexibleTopMargin
    |UIViewAutoresizingFlexibleRightMargin
    |UIViewAutoresizingFlexibleBottomMargin
    |UIViewAutoresizingFlexibleHeight
    |UIViewAutoresizingFlexibleWidth;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Cocoa-Charts v0.2";
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 21;
    }
    
    return 0;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        UILabel* lblTitle = [[UILabel alloc]init];
        lblTitle.backgroundColor = [UIColor grayColor];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"Charts Demo";
        return lblTitle;
    }else if (section == 1) {
        UILabel* lblTitle = [[UILabel alloc]init];
        lblTitle.backgroundColor = [UIColor grayColor];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"Single Chart Demo";
        return lblTitle;
    }else{
        return nil;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 22.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    if(indexPath.section == 0) {
        cell.textLabel.text = @"Simple Demo";
    }else {
        NSUInteger row = indexPath.row;
        //    NSLog(@"%d",row);
        
        if (CCSChartTypeGridChart == row)
        {
            cell.textLabel.text = @"GridChart";
        }
        else if (CCSChartTypeLineChart == row)
        {
            cell.textLabel.text = @"LineChart";
        }
        else if (CCSChartTypeStickChart == row)
        {
            cell.textLabel.text = @"StickChart";
        }
        else if (CCSChartTypeMAStickChart == row)
        {
            cell.textLabel.text = @"MAStickChart";
        }
        else if (CCSChartTypeCandleStickChart == row)
        {
            cell.textLabel.text = @"CandleStickChart";
        }
        else if (CCSChartTypeMACandleStickChart == row)
        {
            cell.textLabel.text = @"MACandleStickChart";
        }
        else if (CCSChartTypePieChart == row)
        {
            cell.textLabel.text = @"PieChart";
        }
        else if (CCSChartTypePizzaChart == row)
        {
            cell.textLabel.text = @"PizzaChart";
        }
        else if (CCSChartTypeSpiderWebChart == row)
        {
            cell.textLabel.text = @"SpiderWebChart";
        }
        else if (CCSChartTypeMinusStickChart == row)
        {
            cell.textLabel.text = @"MinusStickChart";
        }
        else if (CCSChartTypeMACDChart == row)
        {
            cell.textLabel.text = @"MACDChart";
        }
        else if (CCSChartTypeAreaChart == row)
        {
            cell.textLabel.text = @"AreaChart";
        }
        else if (CCSChartTypeStackedAreaChart == row)
        {
            cell.textLabel.text = @"StackedAreaChart";
        }
        else if (CCSChartTypeBandAreaChart == row)
        {
            cell.textLabel.text = @"BandAreaChart";
        }
        else if (CCSChartTypeRadarChart == row)
        {
            cell.textLabel.text = @"RadarChart";
        }
        else if (CCSChartTypeSlipStickChart == row)
        {
            cell.textLabel.text = @"SlipStickChart";
        }
        else if (CCSChartTypeColoredSlipStickChart == row)
        {
            cell.textLabel.text = @"ColoredSlipStickChart";
        }
        else if (CCSChartTypeSlipCandleStickChart == row)
        {
            cell.textLabel.text = @"SlipCandleStickChart";
        }
        else if (CCSChartTypeMASlipCandleStickChart == row)
        {
            cell.textLabel.text = @"MASlipCandleStickChart";
        }
        else if (CCSChartTypeBOLLMASlipCandleStickChart == row)
        {
            cell.textLabel.text = @"BOLLMASlipCandleStickChart";
        }
        else if (CCSChartTypeSlipLineChart == row)
        {
            cell.textLabel.text = @"SlipLineChart";
        }
        else
        {
        }

    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UIViewController *viewController = nil;

    if(indexPath.section == 0) {
        NSUInteger row = indexPath.row;
        if (row == 0) {
            viewController = [[[CCSSimpleDemoViewController alloc]init]autorelease];
        }
    }else if(indexPath.section == 1){
        NSUInteger row = indexPath.row;
        if (CCSChartTypeGridChart == row)
        {
            viewController = [[[CCSGridChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeLineChart == row)
        {
            viewController = [[[CCSLineChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeStickChart == row)
        {
            viewController = [[[CCSStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeMAStickChart == row)
        {
            viewController = [[[CCSMAStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeCandleStickChart == row)
        {
            viewController = [[[CCSCandleStickViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeMACandleStickChart == row)
        {
            viewController = [[[CCSMACandleStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypePieChart == row)
        {
            viewController = [[[CCSPieChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypePizzaChart == row)
        {
            viewController = [[[CCSPizzaChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeSpiderWebChart == row)
        {
            viewController = [[[CCSSpiderWebChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeMinusStickChart == row)
        {
            viewController = [[[CCSMinusStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeMACDChart == row)
        {
            viewController = [[[CCSMACDChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeAreaChart == row)
        {
            viewController = [[[CCSAreaChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeStackedAreaChart == row)
        {
            viewController = [[[CCSStackedAreaChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeBandAreaChart == row)
        {
            viewController = [[[CCSBandAreaChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeRadarChart == row)
        {
            viewController = [[[CCSRadarChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeSlipStickChart == row)
        {
            viewController = [[[CCSSlipStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeColoredSlipStickChart == row)
        {
            viewController = [[[CCSColoredStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeSlipCandleStickChart == row)
        {
            viewController = [[[CCSSlipCandleStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeMASlipCandleStickChart == row)
        {
            viewController = [[[CCSMASlipCandleStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeBOLLMASlipCandleStickChart == row)
        {
            viewController = [[[CCSBOLLMASlipCandleStickChartViewController alloc]init]autorelease];
        }
        else if (CCSChartTypeSlipLineChart == row)
        {
            viewController = [[[CCSSlipLineChartViewController alloc]init]autorelease];
        }
        else
        {
            
        }
    }else {
        return;
    }
    CCSAppDelegate *appDelegate = (CCSAppDelegate*)[UIApplication sharedApplication].delegate;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
        UINavigationController *navigationController = (UINavigationController *)appDelegate.viewController;
        [navigationController pushViewController:viewController animated:YES];
    }else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        UISplitViewController *splitViewController = (UISplitViewController *)appDelegate.viewController;
        UINavigationController *navigationController = [splitViewController.viewControllers objectAtIndex:1];
        [navigationController popToRootViewControllerAnimated:NO];
        [navigationController pushViewController:viewController animated:YES];
    }
}


@end
