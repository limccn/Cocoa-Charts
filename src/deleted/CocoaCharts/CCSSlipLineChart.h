//
//  CCSSlipLineChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/6/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
