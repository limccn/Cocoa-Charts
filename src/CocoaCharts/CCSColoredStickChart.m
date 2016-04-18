//
//  CCSColoredStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/2/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSColoredStickChart.h"
#import "CCSColoredStickChartData.h"

@implementation CCSColoredStickChart
@synthesize coloredStickStyle = _coloredStickStyle;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    self.coloredStickStyle = CCSColoredStickStyleWithBorder;
}

- (void)drawData:(CGRect)rect {
    // 蜡烛棒宽度
    CCFloat stickWidth = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 1;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 0.5f);

    if (self.stickData != NULL && [self.stickData count] > 0) {

        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 蜡烛棒起始绘制位置
            CCFloat stickX = self.axisMarginLeft + 1;
            //判断显示为方柱或显示为线条
            for (CCUInt i = self.displayFrom; i < self.displayFrom + self.displayNumber; i++) {
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:i];

                CCFloat highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                CCFloat lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        CGContextSetFillColorWithColor(context, stick.fillColor.CGColor);
                        //填充路径
                        CGContextFillPath(context);
                        if (self.coloredStickStyle == CCSColoredStickStyleWithBorder) {
                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                            CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                            CGContextStrokePath(context);
                        }
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
                        //修改颜色
                        CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                        //绘制线条
                        CGContextStrokePath(context);
                    }
                }

                //X位移
                stickX = stickX + 1 + stickWidth;
            }
        } else {
            // 蜡烛棒起始绘制位置
            CCFloat stickX = rect.size.width - self.axisMarginRight - 1 - stickWidth;
            //判断显示为方柱或显示为线条
            for (CCUInt i = 0; i < self.displayNumber; i++) {
                //获取index
                CCUInt index = self.displayFrom + self.displayNumber - 1 - i;
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:index];

                CCFloat highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                CCFloat lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        CGContextSetFillColorWithColor(context, stick.fillColor.CGColor);
                        //填充路径
                        CGContextFillPath(context);
                        if (self.coloredStickStyle == CCSColoredStickStyleWithBorder) {
                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                            CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                            CGContextStrokePath(context);
                        }
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
                        CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                        //绘制线条
                        CGContextStrokePath(context);
                    }
                }
                //X位移
                stickX = stickX - 1 - stickWidth;
            }
        }

    }
}


@end
