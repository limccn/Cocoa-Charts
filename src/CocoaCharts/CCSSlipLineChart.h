//
//  CCSSlipLineChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/6/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSLineChart.h"

typedef enum {
    CCSLineZoomBaseLineCenter,
    CCSLineZoomBaseLineLeft,
    CCSLineZoomBaseLineRight
} CCSLineZoomBaseLine;

@interface CCSSlipLineChart : CCSLineChart  {
    NSUInteger _displayNumber;
    NSUInteger _displayFrom;
    NSUInteger _minDisplayNumber;
    NSUInteger _zoomBaseLine;
}

@property(assign, nonatomic) NSUInteger displayNumber;
@property(assign, nonatomic) NSUInteger displayFrom;
@property(assign, nonatomic) NSUInteger minDisplayNumber;
@property(assign, nonatomic) NSUInteger zoomBaseLine;

@end
