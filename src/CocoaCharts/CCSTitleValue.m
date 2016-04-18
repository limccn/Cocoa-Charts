//
//  CCSTitleValue.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-26.
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

#import "CCSTitleValue.h"


@implementation CCSTitleValue

@synthesize title = _title;
@synthesize value = _value;

- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithTitle:(NSString *)title value:(CCFloat)value {
    self = [self init];

    if (self) {
        self.title = title;
        self.value = value;
    }
    return self;
}

@end
