//
//  CCSStringUtils.m
//  CocoaChartsSample
//
//  Created by limc on 12/27/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSStringUtils.h"

@implementation NSString (date)

- (NSString *)dateWithFormat:(NSString *)source target:(NSString *)target {
    NSDateFormatter *sourceDateFormatter = [[NSDateFormatter alloc] init];
    [sourceDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    sourceDateFormatter.dateFormat = source;
    NSDateFormatter *targetDateFormatter = [[NSDateFormatter alloc] init];
    [targetDateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    targetDateFormatter.dateFormat = target;
    NSString *str = [targetDateFormatter stringFromDate:[sourceDateFormatter dateFromString:self]];

    if (str == nil) {
        return @"";
    } else {
        return str;
    }
}

- (NSString *)plainDate {
    NSString *str = [self stringByReplacingOccurrencesOfString:@"/" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@":" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"年" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"月" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"日" withString:@""];
    return str;
}

- (NSString *)yyyyMMddHHmmss {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyyMMddHHmmss"];
}

- (NSString *)yyyyMMddHHmm {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyyMMddHHmm"];
}

- (NSString *)yyyyMMdd {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:@"yyyyMMdd"];
}

- (NSString *)yyMMdd {
    return [[self plainDate] dateWithFormat:@"yyyyMMdd" target:@"yyMMdd"];
}

- (NSString *)MMdd {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:@"MMdd"];
}

- (NSString *)HHmmss {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:@"HHmmss"];
}

- (NSString *)HHmm {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:@"HHmm"];
}

- (NSString *)yyyyMMddHHmm:(NSString *)split {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmm" target:[NSString stringWithFormat:@"yyyy%@MM%@dd HH:mm", split, split]];
}

- (NSString *)yyyyMMddHHmmss:(NSString *)split {
    return [[self plainDate] dateWithFormat:@"yyyyMMddHHmmss" target:[NSString stringWithFormat:@"yyyy%@MM%@dd HH:mm:ss", split, split]];
}

- (NSString *)yyyyMMdd:(NSString *)split {
    return [[self plainDate] dateWithFormat:@"yyyyMMdd" target:[NSString stringWithFormat:@"yyyy%@MM%@dd", split, split]];
}

- (NSString *)yyMMdd:(NSString *)split {
    return [[self plainDate] dateWithFormat:@"yyyyMMdd" target:[NSString stringWithFormat:@"yy%@MM%@dd", split, split]];
}

- (NSString *)MMdd:(NSString *)split {
    return [[self plainDate] dateWithFormat:@"MMdd" target:[NSString stringWithFormat:@"MM%@dd", split]];
}

@end

@implementation NSString (cstring)
//查找和替换
- (NSString *)replaceAll:(NSString *)search target:(NSString *)target {
    NSString *str = [self stringByReplacingOccurrencesOfString:search withString:target];
    return str;
}

//对应位置插入
- (NSString *)insertAt:(NSString *)str post:(NSUInteger)post {
    NSString *str1 = [self substringToIndex:post];
    NSString *str2 = [self substringFromIndex:post];
    return [[str1 stringByAppendingString:str] stringByAppendingString:str2];
}

- (NSUInteger)indexOf:(NSString *)str {
    if (str == nil) {
        return NSNotFound;
    }

    if ([str isEqualToString:@""]) {
        return NSNotFound;
    }

    return [self rangeOfString:str].location;
}

//尾部位置追加
- (NSString *)append:(NSString *)str {
    return [self stringByAppendingString:str];
}

//头部位置插入
- (NSString *)concate:(NSString *)str {
    return [str stringByAppendingString:self];
}

//对应字符分割
- (NSArray *)split:(NSString *)split {
    return [self componentsSeparatedByString:split];
}

//去除多余的空白字符
- (NSString *)trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

//去除多余的特定字符
- (NSString *)trim:(NSString *)trim {
    NSString *str = self;
    str = [str trimLeft:trim];
    str = [str trimRight:trim];
    return str;
}

//去除左边多余的空白字符
- (NSString *)trimLeft {
    return [self trimLeft:@" "];
}

//去除左边多余的特定字符
- (NSString *)trimLeft:(NSString *)trim {
    NSString *str = self;
    while ([str hasPrefix:trim]) {
        str = [str substringFromIndex:[trim length]];
    }
    return str;
}

//去除右边多余的空白字符
- (NSString *)trimRight {
    return [self trimRight:@" "];
}

//去除右边多余的特定字符
- (NSString *)trimRight:(NSString *)trim {
    NSString *str = self;
    while ([str hasSuffix:trim]) {
        str = [str substringToIndex:([str length] - [trim length])];
    }
    return str;
}

//取得字符串的左边特定字符数
- (NSString *)left:(NSUInteger)num {
    //TODO:判断Index
    return [self substringToIndex:num];
}

//取得字符串的右边特定字符数
- (NSString *)right:(NSUInteger)num {
    //TODO:判断Index
    return [self substringFromIndex:([self length] - num)];
}

//取得字符串的右边特定字符数
- (NSString *)left:(NSUInteger)left right:(NSUInteger)right {
    return [[self left:left] right:right];
}

- (NSString *)right:(NSUInteger)right left:(NSUInteger)left {
    return [[self right:right] left:left];
}
@end

@implementation NSString (convert)

//-(NSString *) nilIsZero
//{
//    return [self nilIs:@"0"];
//}
//
//-(NSString *) nilIsBlank
//{
//    return [self nilIs:@""];
//}
//
//-(NSString *) nilIsSpace
//{
//    return [self nilIs:@" "];
//}
//
//-(NSString *) nilIs:(NSString *)replace
//{
//    if (self == nil)
//    {
//        return replace;
//    }else {
//        return self;
//    }
//}

//"" -> nil
- (NSString *)blankIsNil {
    return [self blankIs:nil];
}

//"" -> " "
- (NSString *)blankIsSpace {
    return [self blankIs:@" "];
}

//"" -> 0
- (NSString *)blankIsZero {
    return [self blankIs:@"0"];
}

//"" -> replace
- (NSString *)blankIs:(NSString *)replace {
    if ([self isEqualToString:@""]) {
        return replace;
    } else {
        return self;
    }
}


//" " -> nil
- (NSString *)spaceIsNil {
    return [self spaceIs:nil];
}

//" " -> ""
- (NSString *)spaceIsBlank {
    return [self spaceIs:@""];
}

//" " -> 0
- (NSString *)spaceIsZero {
    return [self spaceIs:@"0"];
}

//" " -> replace
- (NSString *)spaceIs:(NSString *)replace {
    if ([self isEqualToString:@" "]) {
        return replace;
    } else {
        return self;
    }
}

@end

@implementation NSString (decimal)

- (NSString *)decimal; {
    //定义格式化串
    NSNumberFormatter *decimalformatter = [[NSNumberFormatter alloc] init];
    decimalformatter.numberStyle = NSNumberFormatterDecimalStyle;

    return [decimalformatter stringFromNumber:[NSNumber numberWithDouble:[[self numberic] doubleValue]]];
}


- (NSString *)zero {
    return [self zeroIs:@"-"];
}

- (NSString *)zeroIsBlank {
    return [self zeroIs:@""];
}

- (NSString *)zeroIsNil {
    return [self zeroIs:nil];
}

- (NSString *)zeroIsSpace {
    return [self zeroIs:@" "];
}

- (NSString *)zeroIs {
    return [self zeroIs:@"-"];
}

- (NSString *)zeroIs:(NSString *)replace {
    //如果当期值不是0
    if ([[self numberic] doubleValue] == 0) {
        return replace;
    } else {
        return self;
    }
}

- (NSString *)numberic; {
    //字符串还原
    NSString *str = [self stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (str.length > 1 && [str floatValue] == 0.0 && [[str substringToIndex:1] isEqualToString:@"-"]) {
        str = [str substringToIndex:1];
    }
    str = [str stringByReplacingOccurrencesOfString:@"," withString:@""];
    return str;
}

- (NSString *)decimal:(NSUInteger)deci {
    NSMutableString *ms = [[NSMutableString alloc] init];
    [ms appendString:@"###,###,###,##0"];
    if (deci != 0) {
        [ms appendString:@"."];
    }
    for (int i = 0; i < deci; i++) {
        [ms appendString:@"0"];
    }

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:ms];
    return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[[self numberic] doubleValue]]];
}

- (NSString *)currency:(NSString *)code {
    if ([code isEqualToString:@"HKD"]) {
        return [self decimal:3];
    } else if ([code isEqualToString:@"USD"]) {
        return [self decimal:2];
    } else if ([code isEqualToString:@"JPY"]) {
        return [self decimal:0];
    } else {
        return self;
    }
}

- (NSString *)normal; {
    //字符串还原
    return [self numberic];
}

- (NSString *)decimalWithSign {
    NSString *str = [self decimal];

    if ([[str numberic] doubleValue] > 0) {
        return [NSString stringWithFormat:@"+%@", str];
    } else {
        return str;
    }
}

- (NSString *)decimalWithSign:(NSUInteger)deci {
    NSString *str = [self decimal:deci];
    if ([[str numberic] doubleValue] > 0) {
        return [NSString stringWithFormat:@"+%@", str];
    } else {
        return str;
    }
}

- (UIColor *)colorForSign {
    if ([[self numberic] doubleValue] > 0) {
        return [UIColor redColor];
    } else if ([[self numberic] doubleValue] == 0) {
        return [UIColor blackColor];
    } else if ([[self numberic] doubleValue] < 0) {
        return [UIColor blueColor];
    } else {
        return nil;
    }
}

- (UIColor *)colorForCompare:(NSString *)value {
    if ([[self numberic] doubleValue] > [[value numberic] doubleValue]) {
        return [UIColor redColor];
    } else if ([[self numberic] doubleValue] == [[value numberic] doubleValue]) {
        return [UIColor blackColor];
    } else if ([[self numberic] doubleValue] < [[value numberic] doubleValue]) {
        return [UIColor blueColor];
    } else {
        return nil;
    }
}

- (UIColor *)colorForCompareDouble:(double)value {
    if ([[self numberic] doubleValue] > value) {
        return [UIColor redColor];
    } else if ([[self numberic] doubleValue] == value) {
        return [UIColor blackColor];
    } else if ([[self numberic] doubleValue] < value) {
        return [UIColor blueColor];
    } else {
        return nil;
    }
}

@end
