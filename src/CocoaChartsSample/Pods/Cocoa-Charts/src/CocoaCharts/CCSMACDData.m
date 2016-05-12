//
//  CCSMACDData.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-25.
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

#import "CCSMACDData.h"

@implementation CCSMACDData
@synthesize dea = _dea;
@synthesize diff = _diff;
@synthesize macd = _macd;
@synthesize date = _date;


- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithDea:(CCFloat )dea diff:(CCFloat )diff macd:(CCFloat )macd date:(NSString *)date; {
    self = [self init];

    if (self) {
        self.dea = dea;
        self.diff = diff;
        self.macd = macd;
        self.date = date;
    }
    return self;
}

@end
