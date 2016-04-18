//
//  NSString+UserDefault.h
//  CocoaChartsUtils
//
//  Created by zhourr on 12/27/13.
//
//  Copyright (C) 2013 ShangHai Okasan-Huada computer system CO.,LTD. All Rights Reserved.
//  See LICENSE.txt for this file’s licensing information
//

#import <Foundation/Foundation.h>

#define MACD_S                                   @"MACD_S"
#define MACD_L                                   @"MACD_L"
#define MACD_M                                   @"MACD_M"

#define MA1                                      @"MA1"
#define MA2                                      @"MA2"
#define MA3                                      @"MA3"

#define KDJ_N                                    @"KDJ_N"

#define RSI_N1                                   @"RSI_N1"
#define RSI_N2                                   @"RSI_N2"

#define WR_N                                     @"WR_N"

#define CCI_N                                    @"CCI_N"

#define BOLL_N                                   @"BOLL_N"

@interface NSString (UserDefault)

/**
 * NSUserDefaults通用方法（NSData
 */
- (void)setUserDefaultWithData: (NSData *)value;
- (NSData *)getUserDefaultData;

/**
 * NSUserDefaults通用方法（NSString
 */
- (void)setUserDefaultWithString: (NSString *)string;
- (NSString *)getUserDefaultString;

/**
 * NSUserDefaults通用方法（NSObject
 */
- (void)setUserDefaultWithObject: (NSObject *)object;

- (NSObject *)getUserDefaultObject;

@end
