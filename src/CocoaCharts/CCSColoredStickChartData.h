//
//  CCSColoredStickChartData.h
//  CocoaChartsSample
//
//  Created by limc on 12/2/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSStickChartData.h"

@interface CCSColoredStickChartData : CCSStickChartData {
    UIColor *_fillColor;
    UIColor *_borderColor;
}

@property(retain, nonatomic) UIColor *fillColor;
@property(retain, nonatomic) UIColor *borderColor;

- (id)initWithHigh:(float)high low:(float)low date:(NSString *)date color:(UIColor *)color;
- (id)initWithHigh:(float)high low:(float)low date:(NSString *)date fill:(UIColor *)fill border:(UIColor *)border;

@end
