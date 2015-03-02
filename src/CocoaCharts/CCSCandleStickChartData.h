//
//  CandleStickData.h
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

#import <Foundation/Foundation.h>
#import "CCSBaseData.h"

/*!
 CCSCandleStickChartData 
 
 Entity data which is use for display a candleStick in CCSCandleStickChart
 use OHLC(Open,High,Low,Close) four values for a candle
 
 CCSCandleStickChartのロウソク線表示用データです、四本値を格納用オブジェクトです。

 保存蜡烛线表示用的OHLC四个值的实体对象
 */
@interface CCSCandleStickChartData : CCSBaseData {
    CCFloat _open;
    CCFloat _high;
    CCFloat _low;
    CCFloat _close;
    CCFloat _change;
    NSString *_date;
}

/*!
 Open Value
 始値
 开盘价
 */
@property(assign, nonatomic) CCFloat open;

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
 Close Value
 終値
 收盘价
 */
@property(assign, nonatomic) CCFloat close;

/*!
 Change
 変動値
 涨跌数
 */
@property(assign, nonatomic) CCFloat change;

/*!
 Date
 日付
 日期
 */
@property(copy, nonatomic) NSString *date;


/*!
 @abstract Initialize This Object With OHLC And Date
 四本値でオブジェクトを初期化
 初始化当前对象
 
 @param open Open Value
 始値
 开盘价
 
 @param high High Value
 高値
 最高价
 
 @param low Low Value
 低値
 最低价
 
 @param close Close Value
 終値
 收盘价
 
 @param date Date
 日付
 日期
 @result id Initialized Object
 初期化したオブジェクト
 初期化完成对象
 
 */
- (id)initWithOpen:(CCFloat)open high:(CCFloat)high low:(CCFloat)low close:(CCFloat)close date:(NSString *)date;

@end
