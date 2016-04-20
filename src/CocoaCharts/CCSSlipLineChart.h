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
    CCInt _displayNumber;
    CCInt _displayFrom;
    CCInt _minDisplayNumber;
    CCInt _maxDisplayNumber;
//    CCUInt _zoomBaseLine;
    
//    CCFloat _noneDisplayValue;
}

@property(assign, nonatomic) CCInt displayNumber;
@property(assign, nonatomic) CCInt displayFrom;
@property(assign, nonatomic) CCInt minDisplayNumber;
@property(assign, nonatomic) CCInt maxDisplayNumber;
//@property(assign, nonatomic) CCUInt zoomBaseLine;
//@property(assign, nonatomic) CCFloat noneDisplayValue;

-(CCInt) getDataDisplayNumber;
-(CCInt) getDisplayTo;
-(CGFloat) getStickWidth;
-(CGFloat) getDataStickWidth;


@end
