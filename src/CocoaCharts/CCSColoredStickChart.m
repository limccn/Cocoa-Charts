//
//  CCSColoredStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/2/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
    self.coloredStickStyle = CCSColoredStickStyleNoBorder;
}

- (void)drawData:(CGRect)rect {
    if (self.stickData == nil) {
        return;
    }
    if([self.stickData count] == 0){
        return;
    }
    // 蜡烛棒宽度
    CGFloat stickWidth = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber) - 1;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 1.0f);


        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 蜡烛棒起始绘制位置
            CGFloat stickX = [self dataQuadrantPaddingStartX:rect] + 1;
            //判断显示为方柱或显示为线条
            for (NSUInteger i = self.displayFrom; i < self.displayFrom + self.displayNumber; i++) {
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:i];

                CGFloat highY = [self calcValueY:stick.high inRect:rect];
                CGFloat lowY = [self calcValueY:stick.low inRect:rect];

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
            CGFloat stickX = [self dataQuadrantPaddingEndX:rect] - 1 - stickWidth;
            //判断显示为方柱或显示为线条
            for (NSUInteger i = 0; i < self.displayNumber; i++) {
                //获取index
                NSUInteger index = self.displayFrom + self.displayNumber - 1 - i;
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:index];

                CGFloat highY = [self calcValueY:stick.high inRect:rect];
                CGFloat lowY = [self calcValueY:stick.low inRect:rect];
                
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


@end
