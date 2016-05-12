//
//  CCSOHLCVDData.h
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

#import <Foundation/Foundation.h>
#import "CCSBaseData.h"


@interface CCSOHLCVDData : CCSBaseData

@property(assign, nonatomic) BOOL    endFlag;

@property(assign, nonatomic) CCFloat open;
@property(assign, nonatomic) CCFloat high;
@property(assign, nonatomic) CCFloat low;
@property(assign, nonatomic) CCFloat close;
@property(assign, nonatomic) CCFloat vol;
@property(copy, nonatomic) NSString *date;
@property(assign, nonatomic) CCFloat current;
@property(assign, nonatomic) CCFloat change;
@property(assign, nonatomic) CCFloat preclose;

//@property(copy, nonatomic) NSString *open;
//@property(copy, nonatomic) NSString *high;
//@property(copy, nonatomic) NSString *low;
//@property(copy, nonatomic) NSString *close;
//@property(copy, nonatomic) NSString *vol;
//@property(copy, nonatomic) NSString *date;
//@property(copy, nonatomic) NSString *current;
//@property(copy, nonatomic) NSString *change;
//@property(copy, nonatomic) NSString *preclose;

@end
