//
//  CCSSlipStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/21/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSStickChart.h"

typedef enum {
    CCSStickZoomBaseLineCenter,
    CCSStickZoomBaseLineLeft,
    CCSStickZoomBaseLineRight
} CCSStickZoomBaseLine;


@interface CCSSlipStickChart : CCSStickChart {
    NSUInteger _displayNumber;
    NSUInteger _displayFrom;
    NSUInteger _minDisplayNumber;
    NSUInteger _zoomBaseLine;
}

@property(assign, nonatomic, setter = setDisplayNumber:) NSUInteger displayNumber;
@property(assign, nonatomic, setter = setDisplayFrom:) NSUInteger displayFrom;
@property(assign, nonatomic) NSUInteger minDisplayNumber;

@property(assign, nonatomic) NSUInteger zoomBaseLine;

@end
