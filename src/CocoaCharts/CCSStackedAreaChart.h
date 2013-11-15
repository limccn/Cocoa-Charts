//
//  CCSStackedAreaChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/14/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSLineChart.h"

@interface CCSStackedAreaChart : CCSLineChart {
    CGFloat _areaAlpha;
}

@property(assign, nonatomic) CGFloat areaAlpha;

@end
