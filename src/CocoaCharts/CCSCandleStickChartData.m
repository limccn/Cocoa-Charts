//
//  CandleStickData.m
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

#import "CCSCandleStickChartData.h"

@implementation CCSCandleStickChartData

@synthesize open = _open;
@synthesize high = _high;
@synthesize low = _low;
@synthesize close = _close;
@synthesize change = _change;
@synthesize date = _date;

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithOpen:(CCFloat)open high:(CCFloat)high low:(CCFloat)low close:(CCFloat)close date:(NSString *)date {
    self = [self init];

    if (self) {
        self.open = open;
        self.high = high;
        self.low = low;
        self.close = close;
        self.date = date;
    }
    return self;
}


@end
