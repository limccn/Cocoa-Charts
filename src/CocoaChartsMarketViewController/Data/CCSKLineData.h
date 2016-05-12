//
//  CCSKLineData.h
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

@interface CCSKLineData : NSObject

/** 是否最后一根 */
@property (assign, nonatomic) BOOL                          endFlag;

/** 开盘价 */
@property (copy, nonatomic) NSString                       *openPrice;
/** 高值 */
@property (copy, nonatomic) NSString                       *highPrice;
/** 低值 */
@property (copy, nonatomic) NSString                       *lowPrice;
/** 收盘价 */
@property (copy, nonatomic) NSString                       *closePrice;
/** 成交量 */
@property (copy, nonatomic) NSString                       *tradeCount;
/** 日期 */
@property (copy, nonatomic) NSString                       *date;
/** 当前价 */
@property (copy, nonatomic) NSString                       *currentPrice;
/** 涨跌幅 */
@property (copy, nonatomic) NSString                       *changePercent;

@end
