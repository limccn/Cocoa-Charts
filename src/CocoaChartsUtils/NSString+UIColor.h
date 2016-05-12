//
//  NSString+UIColor.h
//  CocoaChartsUtils
//
//  Created by zhourr on 12/27/13.
//
//  Copyright (C) 2013 ShangHai Okasan-Huada computer system CO.,LTD. All Rights Reserved.
//  See LICENSE.txt for this file’s licensing information
//

#import <Foundation/Foundation.h>

@interface NSString (UIColor)

/**
 * 将16进制rgb转换为uicolor,暂时不支持透明度
 */
- (UIColor *)str2Color;

/**
 * 将16进制rgb转换为uicolor
 * alpha 透明度
 */
- (UIColor *)str2ColorWithAlpha:(float)alpha;

@end
