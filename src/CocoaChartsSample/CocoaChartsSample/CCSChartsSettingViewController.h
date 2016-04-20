//
//  CCSChartsSettingViewController.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/4/11.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CCSSampleGroupChartDemoViewController.h"

@interface CCSChartsSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView      *tbSettings;

@property (weak, nonatomic) CCSSampleGroupChartDemoViewController      *ctrlChart;

@end
