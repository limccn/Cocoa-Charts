//
//  CCSLineData.h
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
 CCSLineData
 
 Entity data which is use for display a single line in LineChart
 
 LineChartの線表示用データです。単線です。
 
 保存线图表示用单个线的对象、多条线的时候请使用相应的数据结构保存数据
 */
@interface CCSLineData : CCSBaseData {
    CCFloat _value;
    NSString *_date;
}

/*!
 Value
 値
 值
 */
@property(assign, nonatomic) CCFloat value;

/*!
 Date
 日付
 日期
 */
@property(strong, nonatomic) NSString *date;


/*!
 @abstract Initialize This Object With Value And Date
 オブジェクトを初期化
 初始化当前对象
 
 @param value Value
 始値
 开盘价
 
 @param date Date
 日付
 日期
 
 @result id Initialized Object
 初期化したオブジェクト
 初期化完成对象
 */
- (id)initWithValue:(CCFloat)value date:(NSString *)date;

@end
