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
    CCUInt _displayNumber;
    CCUInt _displayFrom;
    CCUInt _minDisplayNumber;
    CCUInt _zoomBaseLine;
    
    CCFloat _noneDisplayValue;
}

@property(assign, nonatomic) CCUInt displayNumber;
@property(assign, nonatomic) CCUInt displayFrom;
@property(assign, nonatomic) CCUInt minDisplayNumber;
@property(assign, nonatomic) CCUInt zoomBaseLine;

@property(assign, nonatomic) CCFloat noneDisplayValue;

@end
