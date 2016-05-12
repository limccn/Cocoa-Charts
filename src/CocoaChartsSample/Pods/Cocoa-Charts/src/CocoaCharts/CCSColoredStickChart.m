//
//  CCSColoredStickChart.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-24.
//  Copyright 2011 limc.cn All rights reserved.
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
    self.coloredStickStyle = CCSColoredStickStyleWithBorder;
}

- (void)drawSticks:(CGRect)rect {
    // 蜡烛棒宽度
    CCFloat stickWidth = [self getDataStickWidth] - 0.5;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 0.5f);

    if (self.stickData != NULL && [self.stickData count] > 0) {

//        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 蜡烛棒起始绘制位置
            CCFloat stickX = self.axisMarginLeft + 1;
            //判断显示为方柱或显示为线条
            for (CCUInt i = self.displayFrom; i < [self getDisplayTo]; i++) {
                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:i];

                CCFloat highY = [self computeValueY:stick.high inRect:rect];
                CCFloat lowY = [self computeValueY:stick.low inRect:rect];


                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 1) {
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
                stickX = stickX + 0.5 + stickWidth;
            }
//        } else {
//            // 蜡烛棒起始绘制位置
//            CCFloat stickX = rect.size.width - self.axisMarginRight - 1 - stickWidth;
//            //判断显示为方柱或显示为线条
//            for (CCUInt i = 0; i < self.displayNumber; i++) {
//                //获取index
//                CCUInt index = [self getDisplayTo] - 1 - i;
//                CCSColoredStickChartData *stick = [self.stickData objectAtIndex:index];
//
//                CCFloat highY = [self computeValueY:stick.high inRect:rect];
//                CCFloat lowY = [self computeValueY:stick.low inRect:rect];
//
//                if (stick.high == 0) {
//                    //没有值的情况下不绘制
//                } else {
//                    //绘制数据，根据宽度判断绘制直线或方柱
//                    if (stickWidth >= 1) {
//                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
//                        CGContextSetFillColorWithColor(context, stick.fillColor.CGColor);
//                        //填充路径
//                        CGContextFillPath(context);
//                        if (self.coloredStickStyle == CCSColoredStickStyleWithBorder) {
//                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
//                            CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
//                            CGContextStrokePath(context);
//                        }
//                    } else {
//                        CGContextMoveToPoint(context, stickX, highY);
//                        CGContextAddLineToPoint(context, stickX, lowY);
//                        CGContextSetStrokeColorWithColor(context, stick.borderColor.CGColor);
//                        //绘制线条
//                        CGContextStrokePath(context);
//                    }
//                }
//                //X位移
//                stickX = stickX - 0.5 - stickWidth;
//            }
//        }

    }
}


@end
