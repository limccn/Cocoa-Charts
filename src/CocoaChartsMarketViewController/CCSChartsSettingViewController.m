//
//  CCSChartsSettingViewController.m
//  Cocoa-Charts
//
//  Created by zhourr on 11-10-24.
//  Copyright 2011 limc.cn All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "CCSChartsSettingViewController.h"

#import "CCSSettingDetailViewController.h"

#import "CCSChartsSettingTableViewCell.h"
#import "CCSSettingResetTableViewCell.h"

#define CELL_BACKGROUND_DAY                         [UIColor whiteColor]
#define CELL_BACKGROUND_NIGHT                       [@"#16181F" str2Color]

#define CELL_TEXT_COLOR_DAY                         [@"#323232" str2Color]
#define CELL_TEXT_COLOR_NIGHT                       [UIColor lightGrayColor]

/** 设置 Cell */
static NSString *SettingCellIdentifier             = @"CCSChartsSettingTableViewCell";
/** 重置 Cell */
static NSString *ResetCellIdentifier               = @"CCSSettingResetTableViewCell";

@interface CCSChartsSettingViewController (){
    BOOL     _isInitialize;
    
    NSArray *_arraySettings;
}

@end

@implementation CCSChartsSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _arraySettings = @[@{@"title":@"",@"IndicatorType":@"MACD"}, @{@"title":@"MACD指标",@"IndicatorType":@"MACD"}, @{@"title":@"MA指标",@"IndicatorType":@"MA"}, @{@"title":@"VMA指标",@"IndicatorType":@"VMA"}, @{@"title":@"KDJ随机指标",@"IndicatorType":@"KDJ"}, @{@"title":@"RSI强弱指标",@"IndicatorType":@"RSI"}, @{@"title":@"WR指标",@"IndicatorType":@"WR"}, @{@"title":@"CCI指标",@"IndicatorType":@"CCI"}, @{@"title":@"BOLL指标",@"IndicatorType":@"BOLL"}];
    
    // 注册 METOEmptyTableViewCell
    UINib *nibSetting = [UINib nibWithNibName:SettingCellIdentifier bundle:nil];
    [self.tbSettings registerNib:nibSetting forCellReuseIdentifier:SettingCellIdentifier];
    
    // 注册 METOEmptyTableViewCell
    UINib *nibReset = [UINib nibWithNibName:ResetCellIdentifier bundle:nil];
    [self.tbSettings registerNib:nibReset forCellReuseIdentifier:ResetCellIdentifier];
    
    _isInitialize = YES;
    
//    self.themeMode = ThemeNightMode;
    [self.view setBackgroundColor: self.themeMode == ThemeDayMode? CONTENT_BACKGROUND_DAY:CONTENT_BACKGROUND_NIGHT];
}

- (void)viewWillAppear:(BOOL)animated{
    [self setTitle:@"设置指标"];
    
    [self initNavigationBar];
    
    // Index path for selected row
    NSIndexPath *selectedRow = [self.tbSettings indexPathForSelectedRow];
    
    // Deselet the row with animation
    [self.tbSettings deselectRowAtIndexPath:selectedRow animated:YES];
    
    // Scroll the selected row to the center
    [self.tbSettings scrollToRowAtIndexPath:selectedRow
                           atScrollPosition:UITableViewScrollPositionMiddle
                                   animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
}

- (void)viewDidLayoutSubviews{
    if (_isInitialize) {
        _isInitialize = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initNavigationBar{
    UIBarButtonItem *backItem = nil;
    
    // 添加返回按钮,文字
    backItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭"
                                                style:UIBarButtonItemStylePlain
                                               target:self
                                               action:@selector(backButtonClick:)];
    
    [backItem setTintColor:[UIColor blueColor]];
    [self.navigationItem setLeftBarButtonItem:backItem];
}

/**
 * 返回按钮点击事件
 */
- (void)backButtonClick:(UIBarButtonItem *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

/*******************************************************************************
 * Implements Of UITableViewDataSource
 *******************************************************************************/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_arraySettings) {
        return [_arraySettings count];
    }else{
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
//    if (indexPath.row == [_arraySettings count] - 1) {
//        cell = [tableView dequeueReusableCellWithIdentifier:ResetCellIdentifier forIndexPath:indexPath];
//        [(CCSSettingResetTableViewCell *)cell setData:@{@"title":_arraySettings[indexPath.row]}];
//    }else{
        cell = [tableView dequeueReusableCellWithIdentifier:SettingCellIdentifier forIndexPath:indexPath];
        
        NSMutableDictionary *dicData = [[NSMutableDictionary alloc] initWithDictionary:_arraySettings[indexPath.row]];
        
        if (indexPath.row == 0) {
            [dicData setObject:@"YES" forKey:@"hidetop"];
            [dicData setObject:@"YES" forKey:@"hidebottom"];
            [dicData setObject:@"0" forKey:@"left"];
        }else if (indexPath.row == 1) {
            [dicData setObject:@"NO" forKey:@"hidetop"];
            [dicData setObject:@"YES" forKey:@"hidebottom"];
            [dicData setObject:@"0" forKey:@"left"];
        }else if (indexPath.row == [_arraySettings count] - 1) {
            [dicData setObject:@"NO" forKey:@"hidetop"];
            [dicData setObject:@"NO" forKey:@"hidebottom"];
            [dicData setObject:@"15" forKey:@"left"];
        }
//        else if (indexPath.row == [_arraySettings count] - 2) {
//            [dicData setObject:@"YES" forKey:@"hidetop"];
//            [dicData setObject:@"YES" forKey:@"hidebottom"];
//            [dicData setObject:@"15" forKey:@"left"];
//        }
        else{
            [dicData setObject:@"NO" forKey:@"hidetop"];
            [dicData setObject:@"YES" forKey:@"hidebottom"];
            [dicData setObject:@"15" forKey:@"left"];
        }
        
        [(CCSChartsSettingTableViewCell *)cell setData:dicData];
        [(CCSChartsSettingTableViewCell *)cell setIndicatorTextColor:self.themeMode == ThemeDayMode? CELL_TEXT_COLOR_DAY:CELL_TEXT_COLOR_NIGHT];
//    }
    
    return cell;
}

/*******************************************************************************
 * Implements Of UITableViewDelegate
 *******************************************************************************/

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [@"" isEqualToString: _arraySettings[indexPath.row]]? 33.0f:44.0f;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:self.themeMode == ThemeDayMode? CELL_BACKGROUND_DAY:CELL_BACKGROUND_NIGHT];
    
    if (indexPath.row == 0 || indexPath.row == [_arraySettings count] - 1 || indexPath.row == [_arraySettings count] - 2) {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }else{
       [cell setSelectionStyle:UITableViewCellSelectionStyleDefault];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return;
    }
    
    NSString *strIndicatorType = _arraySettings[indexPath.row][@"IndicatorType"];
    
    CCSSettingDetailViewController *ctrlSettingDetail = [[CCSSettingDetailViewController alloc] init];
    
    ctrlSettingDetail.ctrlChart = self.ctrlChart;
    ctrlSettingDetail.indicatorType = [@"MACD" isEqualToString: strIndicatorType]?IndicatorMACD:[@"MA" isEqualToString: strIndicatorType]?IndicatorMA:[@"VMA" isEqualToString: strIndicatorType]?IndicatorVMA:[@"KDJ" isEqualToString: strIndicatorType]?IndicatorKDJ:[@"RSI" isEqualToString: strIndicatorType]?IndicatorRSI:[@"WR" isEqualToString: strIndicatorType]?IndicatorWR:[@"CCI" isEqualToString: strIndicatorType]?IndicatorCCI:IndicatorBOLL;
    
    [self.navigationController pushViewController:ctrlSettingDetail animated:YES];
}

@end
