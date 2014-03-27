//
//  CCSSlipStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/21/13.
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
