//
//  CCSMarketDetailHorizontalViewController.m
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

#import "CCSMarketDetailHorizontalViewController.h"

@interface CCSMarketDetailHorizontalViewController (){
}

@end

@implementation CCSMarketDetailHorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.groupChart setOrientationType:GroupChartHorizontalType];
    [self.lblProductName setText:self.productData.productName];
    
    // 旋转90度
    [self.view setTransform:CGAffineTransformMakeRotation(90 *M_PI / 180.0)];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.title = @"Simple Horizontal Demo";
    self.navigationController.navigationBar.hidden = YES;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.flag = YES;
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        
        [self prefersStatusBarHidden];
        
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
        
    }
    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationLandscapeRight;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.ctrlLast) {
        [self.ctrlLast setDisplayType:self.displayType];
    }
    
    self.navigationController.navigationBar.hidden = NO;
    
    AppDelegate *app = [[UIApplication sharedApplication] delegate];
    app.flag = NO;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
//    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
//        SEL selector = NSSelectorFromString(@"setOrientation:");
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:selector]];
//        [invocation setSelector:selector];
//        [invocation setTarget:[UIDevice currentDevice]];
//        int val = UIInterfaceOrientationPortrait;
//        [invocation setArgument:&val atIndex:2];
//        [invocation invoke];
//    }
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeTouchUpInside:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)initValue{
    [super initValue];
}

- (void)initView{
    [super initView];
    [self.segTopChartType setSelectedSegmentIndex:self.displayType == DisplayHandicapType?0:self.displayType == DisplayTickType?1:self.displayType == Display2DaysType?2:self.displayType == Display2DaysType?3:self.displayType == DisplayDetailType?4:self.displayType == DisplayDayKLineType?5:self.displayType == DisplayWeekKLineType?6:self.displayType == DisplayMonthKLineType?7:self.displayType == Display1MinKLineType?8:self.displayType == Display5MinKLineType?9:self.displayType == Display15MinKLineType?10:self.displayType == Display30MinKLineType?11:self.displayType == Display1HourKLineType?12:self.displayType == Display2HourKLineType?13:14];
}

- (void)initHandicap{
    if (self.vHandicap) {
        return;
    }
    
    self.vHandicap = [[UIView alloc] init];
    [self.vHandicap setFrame:CGRectMake([self.groupChart frame].origin.x, [self.groupChart frame].origin.y, [self.groupChart frame].size.width, [self.groupChart frame].size.height)];
    
    if (self.displayType != DisplayHandicapType) {
        [self.vHandicap setHidden:YES];
    }
    
    [self.view addSubview:self.vHandicap];
    
    CGFloat handicapHeight = 11.0f;
    
    NSMutableArray *arrhandicapsLeftValue = [[NSMutableArray alloc] init];
    NSMutableArray *arrhandicapsRightValue = [[NSMutableArray alloc] init];
    
    CGFloat marginLeft = 30.0f;
    CGFloat marginRight = 60.0f;
    
    for (int i=0; i<4; i++) {
        UIView *vHandicapContainer = [[UIView alloc] init];
        [vHandicapContainer setFrame:CGRectMake(0.0f, handicapHeight, self.vHandicap.frame.size.width, 44.0f)];
        [self.vHandicap addSubview:vHandicapContainer];
        
        UIView *vHandicapLeftContainer = [[UIView alloc] init];
        [vHandicapLeftContainer setFrame:CGRectMake(0.0f, 0.0f, vHandicapContainer.frame.size.width/2.0f, vHandicapContainer.frame.size.height)];
        [vHandicapContainer addSubview:vHandicapLeftContainer];
        
        UILabel *lblLeftLeftLabel = [[UILabel alloc] init];
        [lblLeftLeftLabel setFrame:CGRectMake(marginLeft, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblLeftLeftLabel setTextAlignment:NSTextAlignmentCenter];
        [lblLeftLeftLabel setTextColor:[UIColor lightGrayColor]];
        [lblLeftLeftLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftLeftLabel];
        
        UILabel *lblLeftLeftValue = [[UILabel alloc] init];
        [lblLeftLeftValue setFrame:CGRectMake(marginLeft + lblLeftLeftLabel.frame.size.width, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblLeftLeftValue setTextAlignment:NSTextAlignmentCenter];
        [lblLeftLeftValue setTextColor:[UIColor lightGrayColor]];
        [lblLeftLeftValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftLeftValue];
        
        [arrhandicapsLeftValue addObject:lblLeftLeftValue];
        
        UILabel *lblLeftRightLabel = [[UILabel alloc] init];
        [lblLeftRightLabel setFrame:CGRectMake(vHandicapLeftContainer.frame.size.width - marginRight - lblLeftLeftLabel.frame.size.width - lblLeftLeftValue.frame.size.width, 0.0f, lblLeftLeftLabel.frame.size.width, vHandicapLeftContainer.frame.size.height)];
        [lblLeftRightLabel setTextAlignment:NSTextAlignmentCenter];
        [lblLeftRightLabel setTextColor:[UIColor lightGrayColor]];
        [lblLeftRightLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftRightLabel];
        
        UILabel *lblLeftRightValue = [[UILabel alloc] init];
        [lblLeftRightValue setFrame:CGRectMake(marginLeft + lblLeftRightLabel.frame.size.width + lblLeftRightLabel.frame.origin.x, 0.0f, lblLeftLeftValue.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblLeftRightValue setTextAlignment:NSTextAlignmentCenter];
        [lblLeftRightValue setTextColor:[UIColor lightGrayColor]];
        [lblLeftRightValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapLeftContainer addSubview:lblLeftRightValue];
        
        [arrhandicapsRightValue addObject:lblLeftRightValue];
        
        UIView *vHandicapRightContainer = [[UIView alloc] init];
        [vHandicapRightContainer setFrame:CGRectMake(vHandicapLeftContainer.frame.size.width, 0.0f, vHandicapContainer.frame.size.width/2.0f, vHandicapContainer.frame.size.height)];
        [vHandicapContainer addSubview:vHandicapRightContainer];
        
        UILabel *lblRightLeftLabel = [[UILabel alloc] init];
        [lblRightLeftLabel setFrame:CGRectMake(marginLeft, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblRightLeftLabel setTextAlignment:NSTextAlignmentCenter];
        [lblRightLeftLabel setTextColor:[UIColor lightGrayColor]];
        [lblRightLeftLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightLeftLabel];
        
        UILabel *lblRightLeftValue = [[UILabel alloc] init];
        [lblRightLeftValue setFrame:CGRectMake(marginLeft + lblLeftLeftLabel.frame.size.width, 0.0f, 50.0f, vHandicapLeftContainer.frame.size.height)];
        [lblRightLeftValue setTextAlignment:NSTextAlignmentCenter];
        [lblRightLeftValue setTextColor:[UIColor lightGrayColor]];
        [lblRightLeftValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightLeftValue];
        
        [arrhandicapsLeftValue addObject:lblRightLeftValue];
        
        UILabel *lblRightRightLabel = [[UILabel alloc] init];
        [lblRightRightLabel setFrame:CGRectMake(vHandicapLeftContainer.frame.size.width - marginRight - lblLeftLeftLabel.frame.size.width - lblLeftLeftValue.frame.size.width, 0.0f, lblLeftLeftLabel.frame.size.width, vHandicapLeftContainer.frame.size.height)];
        [lblRightRightLabel setTextAlignment:NSTextAlignmentCenter];
        [lblRightRightLabel setTextColor:[UIColor lightGrayColor]];
        [lblRightRightLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightRightLabel];
        
        UILabel *lblRightRightValue = [[UILabel alloc] init];
        [lblRightRightValue setFrame:CGRectMake(marginLeft + lblLeftRightLabel.frame.size.width + lblLeftRightLabel.frame.origin.x, 0.0f, lblLeftLeftValue.frame.size.width, vHandicapContainer.frame.size.height)];
        [lblRightRightValue setTextAlignment:NSTextAlignmentCenter];
        [lblRightRightValue setTextColor:[UIColor lightGrayColor]];
        [lblRightRightValue setFont:[UIFont systemFontOfSize:14.0f]];
        [vHandicapRightContainer addSubview:lblRightRightValue];
        
        [arrhandicapsRightValue addObject:lblLeftRightValue];
        
        switch (i) {
            case 0:
                [lblLeftLeftLabel setText:@"卖价:"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"卖量:"];
                [lblLeftRightValue setText:@"2"];
                [lblRightLeftLabel setText:@"最高:"];
                [lblRightLeftValue setText:@"3559"];
                [lblRightRightLabel setText:@"最低:"];
                [lblRightRightValue setText:@"3559"];
                
                self.lblHandicapSellPrice = lblLeftLeftValue;
                self.lblHandicapSellCount = lblLeftRightValue;
                self.lblHandicapHighPrice = lblRightLeftValue;
                self.lblHandicapLowPrice = lblRightRightValue;
                break;
            case 1:
                [lblLeftLeftLabel setText:@"买价:"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"买量:"];
                [lblLeftRightValue setText:@"1"];
                [lblRightLeftLabel setText:@"开盘:"];
                [lblRightLeftValue setText:@"3559"];
                [lblRightRightLabel setText:@"总量:"];
                [lblRightRightValue setText:@"3559"];
                
                self.lblHandicapBuyPrice = lblLeftLeftValue;
                self.lblHandicapBuyCount = lblLeftRightValue;
                self.lblHandicapOpenPrice = lblRightLeftValue;
                self.lblHandicapOpenSumCount = lblRightRightValue;
                break;
            case 2:
                [lblLeftLeftLabel setText:@"最新:"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"涨跌:"];
                [lblLeftRightValue setText:@"11"];
                [lblRightLeftLabel setText:@"昨收:"];
                [lblRightLeftValue setText:@"3559"];
                [lblRightRightLabel setText:@"总额:"];
                [lblRightRightValue setText:@"3559"];
                
                self.lblHandicapCurrentPrice = lblLeftLeftValue;
                self.lblHandicapChangePrice = lblLeftRightValue;
                self.lblHandicapClosePrice = lblRightLeftValue;
                self.lblHandicapCloseSumCount = lblRightRightValue;
                break;
            case 3:
                [lblLeftLeftLabel setText:@"昨结:"];
                [lblLeftLeftValue setText:@"3559"];
                [lblLeftRightLabel setText:@"持货:"];
                [lblLeftRightValue setText:@"3559"];
                
                self.lblYesterdayClosePrice = lblLeftLeftValue;
                self.lblYesterdayCloseSumCount = lblLeftRightValue;
                break;
            default:
                break;
        }
        
        handicapHeight += vHandicapContainer.frame.size.height;
    }
}

- (void)horizontal:(UIButton *) sender{
}

- (void)updateTime{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    [self.lblTime setText:currentDateStr];
}

@end
