//
//  NSString+UIColor.h
//  OWIN
//
//  Created by zhourr_ on 16/2/17.
//  Copyright © 2016年 OHS. All rights reserved.
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
