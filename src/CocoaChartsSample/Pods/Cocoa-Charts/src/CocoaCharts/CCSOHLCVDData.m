//
//  CCSOHLCVDData.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-25.
//  Copyright 2011 zhourr All rights reserved.
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

#import "CCSOHLCVDData.h"

@implementation CCSOHLCVDData

- (id)init{
    self = [super init];
    
    if (self) {
        self.date = @"00000000000000";
    }
    return self;
}

@end
