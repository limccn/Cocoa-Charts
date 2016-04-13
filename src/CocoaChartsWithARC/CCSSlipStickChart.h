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
    CCInt _displayNumber;
    CCInt _displayFrom;
    CCInt _minDisplayNumber;
    CCInt _maxDisplayNumber;
//    CCUInt _zoomBaseLine;
    CCInt _maxDisplayNumberToLine;
    
}

@property(assign, nonatomic, setter = setDisplayNumber:) CCInt displayNumber;
@property(assign, nonatomic, setter = setDisplayFrom:) CCInt displayFrom;
@property(assign, nonatomic) CCInt minDisplayNumber;
@property(assign, nonatomic) CCInt maxDisplayNumber;

//@property(assign, nonatomic) CCUInt zoomBaseLine;
@property(assign, nonatomic) CCInt maxDisplayNumberToLine;

-(CCInt) getDataDisplayNumber;
-(CCInt) getDisplayTo;
-(CGFloat) getStickWidth;
-(CGFloat) getDataStickWidth;


@end
