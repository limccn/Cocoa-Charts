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
    CCUInt _displayNumber;
    CCUInt _displayFrom;
    CCUInt _minDisplayNumber;
    CCUInt _zoomBaseLine;
}

@property(assign, nonatomic, setter = setDisplayNumber:) CCUInt displayNumber;
@property(assign, nonatomic, setter = setDisplayFrom:) CCUInt displayFrom;
@property(assign, nonatomic) CCUInt minDisplayNumber;

@property(assign, nonatomic) CCUInt zoomBaseLine;

@end
