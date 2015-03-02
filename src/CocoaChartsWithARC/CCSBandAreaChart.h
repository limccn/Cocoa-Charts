//
//  CCSBandAreaChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/14/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSLineChart.h"

@interface CCSBandAreaChart : CCSLineChart {
    CCFloat _areaAlpha;
}

@property(assign, nonatomic) CCFloat areaAlpha;

@end
