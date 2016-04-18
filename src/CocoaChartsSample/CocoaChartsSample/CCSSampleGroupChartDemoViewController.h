//
//  CCSSampleGroupChartDemoViewController.h
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/3/28.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCSGroupChart.h"

@interface CCSSampleGroupChartDemoViewController : UIViewController<CCSChartDelegate>

@property (weak, nonatomic) IBOutlet UISegmentedControl      *segTopChartType;
@property (weak, nonatomic) IBOutlet CCSGroupChart           *groupChart;

@end
