//
//  CCSColoredStickChartData.h
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

#import "CCSStickChartData.h"

@interface CCSColoredStickChartData : CCSStickChartData {
    UIColor *_fillColor;
    UIColor *_borderColor;
}

@property(strong, nonatomic) UIColor *fillColor;
@property(strong, nonatomic) UIColor *borderColor;

- (id)initWithHigh:(CCFloat)high low:(CCFloat)low date:(NSString *)date color:(UIColor *)color;

- (id)initWithHigh:(CCFloat)high low:(CCFloat)low date:(NSString *)date fill:(UIColor *)fill border:(UIColor *)border;

@end
