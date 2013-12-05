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

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawData:(CGRect)rect {
    // 蜡烛棒宽度
    float stickWidth = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 3;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 1.0f);

    if (self.stickData != NULL && [self.stickData count] > 0) {

        if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
            // 蜡烛棒起始绘制位置
            float stickX = self.axisMarginLeft + 1;
            //判断显示为方柱或显示为线条
            for (NSUInteger i = self.displayFrom; i < self.displayFrom + self.displayNumber; i++) {
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:i];

                float highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                float lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        CGContextSetFillColorWithColor(context, stick.fillColor.CGColor);
                        //填充路径
                        CGContextFillPath(context);

                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                        CGContextStrokePath(context);
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
                stickX = stickX + 3 + stickWidth;
            }
        } else {
            // 蜡烛棒起始绘制位置
            float stickX = rect.size.width - self.axisMarginRight - 1 - stickWidth;
            //判断显示为方柱或显示为线条
            for (NSUInteger i = 0; i < self.displayNumber; i++) {
                //获取index
                NSUInteger index = self.displayFrom + self.displayNumber - 1 - i;
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:index];

                float highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                float lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        CGContextSetFillColorWithColor(context, stick.fillColor.CGColor);
                        //填充路径
                        CGContextFillPath(context);
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                        CGContextStrokePath(context);
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
                        CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
                        //绘制线条
                        CGContextStrokePath(context);
                    }
                }
                //X位移
                stickX = stickX - 3 - stickWidth;
            }
        }

    }
}


@end
