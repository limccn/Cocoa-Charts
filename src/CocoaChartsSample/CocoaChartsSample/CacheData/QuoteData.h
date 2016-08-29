//
//  QuoteData.h
//  FinanceInfo
//
//  Created by zhourr_ on 16/2/24.
//  Copyright © 2016年 OHS. All rights reserved.
//

@interface QuoteData : RLMObject

/** 简称 */
@property(copy, nonatomic) NSString *shortNM;
/** 股票代码 */
@property(copy, nonatomic) NSString *ticker;
/** 交易所代码 */
@property(copy, nonatomic) NSString *exchangeCD;

/** 涨跌值 */
@property(assign, nonatomic) CGFloat change;
/** 涨跌幅 */
@property(assign, nonatomic) CGFloat changePct;
/** 时间 */
@property(strong, nonatomic) NSDate *dateTime;
/** 高值 */
@property(assign, nonatomic) CGFloat highPrice;
/** 当前价 */
@property(assign, nonatomic) CGFloat lastPrice;
/** 低值 */
@property(assign, nonatomic) CGFloat lowPrice;
/** 开盘价 */
@property(assign, nonatomic) CGFloat openPrice;
/** 昨日收盘价 */
@property(assign, nonatomic) CGFloat prevClosePrice;
/** 成交额 */
@property(assign, nonatomic) CGFloat value;
/** 成交量 */
@property(assign, nonatomic) long volume;

+ (NSString *)dateTime;

@end

RLM_ARRAY_TYPE(QuoteData)