//
//  CCSSampleGroupChartHorizontalViewController.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/5/6.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSampleGroupChartHorizontalViewController.h"

@interface CCSSampleGroupChartHorizontalViewController ()

@end

@implementation CCSSampleGroupChartHorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.groupChart setOrientationType: GroupChartHorizontalType];
    
    // 旋转90度
    [self.view setTransform:CGAffineTransformMakeRotation(90 *M_PI / 180.0)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
