//
//  CCSStickChartData.h
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

#import <Foundation/Foundation.h>
#import "CCSBaseData.h"

/*!
 CCSStickChartData
 
 Entity data which is use for display a stick in CCSStickChart
 
 CCSStickChartのスティック表示用データです、高安値を格納用オブジェクトです。
 
 CCSStickChart保存柱条表示用的高低值的实体对象
 */
@interface CCSStickChartData : CCSBaseData {
    CCFloat _high;
    CCFloat _low;
    NSString *_date;
}

/*!
 High Value
 高値
 最高价
 */
@property(assign, nonatomic) CCFloat high;

/*!
 Low Value
 低値
 最低价
 */
@property(assign, nonatomic) CCFloat low;

/*!
 Date
 日付
 日期
 */
@property(copy, nonatomic) NSString *date;

/*!
 @abstract Initialize This Object With H/L And Date
 オブジェクトを初期化
 初始化当前对象
 
 @param high High Value
 高値
 最高价
 
 @param low Low Value
 低値
 最低价
 
 @param date Date
 日付
 日期
 
 @result id Initialized Object
 初期化したオブジェクト
 初期化完成对象
 
 */
- (id)initWithHigh:(CCFloat)high low:(CCFloat)low date:(NSString *)date;

@end
