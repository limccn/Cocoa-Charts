//
//  CCSSlipStickChart.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-24.
//  Copyright 2011 limc.cn All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
    
    CCFloat _widthForStickDrawAsLine;
    UIColor *_colorForStickDrawAsLine;
    
}

@property(assign, nonatomic, setter = setDisplayNumber:) CCInt displayNumber;
@property(assign, nonatomic, setter = setDisplayFrom:) CCInt displayFrom;
@property(assign, nonatomic) CCInt minDisplayNumber;
@property(assign, nonatomic) CCInt maxDisplayNumber;

//@property(assign, nonatomic) CCUInt zoomBaseLine;

@property(assign, nonatomic) CCInt maxDisplayNumberToLine;
@property(assign, nonatomic) CCFloat widthForStickDrawAsLine;
@property(strong, nonatomic) UIColor *colorForStickDrawAsLine;


-(CCInt) getDataDisplayNumber;
-(CCInt) getDisplayTo;
-(CCFloat) getStickWidth;
-(CCFloat) getDataStickWidth;

@end
