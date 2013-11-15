//
//  CCSAreaChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/13/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSLineChart.h"

@interface CCSAreaChart : CCSLineChart {
    CGFloat _areaAlpha;
}

@property(assign, nonatomic) CGFloat areaAlpha;

@end
