//
//  CCSAreaChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-27.
//  Copyright 2011 limc.cn All rights reserved.
//

#import "CCSLineChart.h"

@interface CCSAreaChart : CCSLineChart {
    CCFloat _areaAlpha;
}

@property(assign, nonatomic) CCFloat areaAlpha;

@end
