//
//  CCSStringUtils.h
//  CocoaChartsSample
//
//  Created by limc on 12/27/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (date)

- (NSString *)dateWithFormat:(NSString *)source target:(NSString *)target;

//清空格式
- (NSString *)plainDate;

//20120619095532 ->20120619095532
- (NSString *)yyyyMMddHHmmss;

//20120619095532 ->201206190955
- (NSString *)yyyyMMddHHmm;

//20120619095532 ->20120619
- (NSString *)yyyyMMdd;

//20120619095532 ->0619
- (NSString *)yyMMdd;

//20120619095532 ->0619
- (NSString *)MMdd;

//20120619095532 ->095532
- (NSString *)HHmmss;

//095532 ->0955
- (NSString *)HHmm;

//20120619095532 ->20120619
- (NSString *)yyyyMMddHHmm:(NSString *)split;

//20120619095532 ->20120619
- (NSString *)yyyyMMddHHmmss:(NSString *)split;

// spilt=@"-"  20120619->2012-06-19
- (NSString *)yyyyMMdd:(NSString *)split;

//20120619095532 ->0619
- (NSString *)yyMMdd:(NSString *)split;

// spilt=@"-"  0619->06-19
- (NSString *)MMdd:(NSString *)split;

@end

@interface NSString (cstring)
//查找和替换
- (NSString *)replaceAll:(NSString *)str target:(NSString *)target;

//对应位置插入
- (NSString *)insertAt:(NSString *)str post:(NSUInteger)post;

//字符串查找
- (NSUInteger)indexOf:(NSString *)str;

//尾部位置追加
- (NSString *)append:(NSString *)str;

//头部位置插入
- (NSString *)concate:(NSString *)str;

//对应字符分割
- (NSArray *)split:(NSString *)split;

//去除多余的空白字符
- (NSString *)trim;

//去除多余的特定字符
- (NSString *)trim:(NSString *)trim;

//去除左边多余的空白字符
- (NSString *)trimLeft;

//去除左边多余的特定字符
- (NSString *)trimLeft:(NSString *)trim;

//去除右边多余的空白字符
- (NSString *)trimRight;

//去除右边多余的特定字符
- (NSString *)trimRight:(NSString *)trim;

//取得字符串的左边特定字符数
- (NSString *)left:(NSUInteger)num;

//取得字符串的右边特定字符数
- (NSString *)right:(NSUInteger)num;

//取得字符串的左边右边特定字符数
- (NSString *)left:(NSUInteger)left right:(NSUInteger)right;

//取得字符串的右边左边特定字符数
- (NSString *)right:(NSUInteger)right left:(NSUInteger)left;
@end

@interface NSString (convert)

////nil -> 0
//-(NSString *) nilIsZero;
////nil -> ""
//-(NSString *) nilIsBlank;
////nil -> " "
//-(NSString *) nilIsSpace;
////nil -> replace
//-(NSString *) nilIs:(NSString *)replace;


//"" -> nil
- (NSString *)blankIsNil;

//"" -> " "
- (NSString *)blankIsSpace;

//"" -> 0
- (NSString *)blankIsZero;

//"" -> replace
- (NSString *)blankIs:(NSString *)replace;


//" " -> nil
- (NSString *)spaceIsNil;

//" " -> ""
- (NSString *)spaceIsBlank;

//" " -> 0
- (NSString *)spaceIsZero;

//" " -> replace
- (NSString *)spaceIs:(NSString *)replace;

@end

@interface NSString (decimal)

//123456789.11->123,456,789.11
- (NSString *)decimal;

//0-> -
- (NSString *)zero;

//0->""
- (NSString *)zeroIsBlank;

//0->nil
- (NSString *)zeroIsNil;

//0->" "
- (NSString *)zeroIsSpace;

//0-> -
- (NSString *)zeroIs;

//0-> replace
- (NSString *)zeroIs:(NSString *)replace;

/*
 @"HKD" 返回三位小数点格式化字符
 @"USD" 返回两位小数点格式化字符
 @"JPY" 返回无小数点格式化字符
 */
- (NSString *)currency:(NSString *)code;

// deci=4 123456 ->123,456.0000
- (NSString *)decimal:(NSUInteger)deci;

// 123456 -> +123,456
- (NSString *)decimalWithSign;

// deci=4 123456-> +123,456.0000
- (NSString *)decimalWithSign:(NSUInteger)deci;

//正返回红色 0返回黑 负返回蓝色
- (UIColor *)colorForSign;

// self > value值返回红色 self = value值返回黑色 self < value值返回蓝色
- (UIColor *)colorForCompare:(NSString *)value;

// self > value值返回红色 self = value值返回黑色 self < value值返回蓝色
- (UIColor *)colorForCompareDouble:(double)value;

- (NSString *)normal;

// 123,456,789 -> 123456789
- (NSString *)numberic;

@end
