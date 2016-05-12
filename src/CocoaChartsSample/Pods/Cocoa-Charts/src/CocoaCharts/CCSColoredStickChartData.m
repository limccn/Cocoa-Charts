//
//  CCSColoredStickChartData.m
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

#import "CCSColoredStickChartData.h"

@implementation CCSColoredStickChartData
@synthesize borderColor = _borderColor;
@synthesize fillColor = _fillColor;


- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithHigh:(CCFloat)high low:(CCFloat)low date:(NSString *)date color:(UIColor *)color {
    self = [self init];

    if (self) {
        self.high = high;
        self.low = low;
        self.date = date;
        self.fillColor = color;
        self.borderColor = color;
    }
    return self;
}

- (id)initWithHigh:(CCFloat)high low:(CCFloat)low date:(NSString *)date fill:(UIColor *)fill border:(UIColor *)border {
    self = [self init];

    if (self) {
        self.high = high;
        self.low = low;
        self.date = date;
        self.fillColor = fill;
        self.borderColor = border;
    }
    return self;
}


@end
