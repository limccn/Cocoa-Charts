//
//  CCSProductData.h
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

@interface CCSProductData : NSObject

/** 商品id */
@property (copy, nonatomic) NSString                       *producID;
/** 商品名 */
@property (copy, nonatomic) NSString                       *productName;
/** 当前价 */
@property (copy, nonatomic) NSString                       *currentPrice;
/** 涨跌 */
@property (copy, nonatomic) NSString                       *changePrice;
/** 涨跌幅 */
@property (copy, nonatomic) NSString                       *changePercent;
/** 买价 */
@property (copy, nonatomic) NSString                       *buyPrice;
/** 卖价 */
@property (copy, nonatomic) NSString                       *sellPrice;
/** 最高 */
@property (copy, nonatomic) NSString                       *highPrice;
/** 最低 */
@property (copy, nonatomic) NSString                       *lowPrice;

@end
