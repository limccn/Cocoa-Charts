//
//  CCSMinusStickChart.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-25.
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

#import "CCSMinusStickChart.h"
#import "CCSStickChartData.h"

@implementation CCSMinusStickChart

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    //去除轴对称属性
    self.axisMarginTop = 0;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)calcValueRange {
    if (self.stickData != NULL && [self.stickData count] > 0) {

        CCFloat maxValue = 0;
        CCFloat minValue = 0;

        CCSStickChartData *first = [self.stickData objectAtIndex:0];
        //第一个stick为停盘的情况
        maxValue = first.high;

        //判断显示为方柱或显示为线条
        for (CCUInt i = 0; i < [self.stickData count]; i++) {
            CCSStickChartData *stick = [self.stickData objectAtIndex:i];
            if (fabs(stick.high) > maxValue) {
                maxValue = fabs(stick.high);
            } else if (fabs(stick.low) > maxValue) {
                maxValue = fabs(stick.low);
            }
        }

        //范围调整
        if (maxValue < 10) {
            self.maxValue = (CCInt) (maxValue + 1);
        } else {
            self.maxValue = (CCInt) (maxValue + (maxValue - minValue) * 0.1);
        }
    } else {
        self.maxValue = 0;
    }
    //修正最大值
    CCInt rate = (self.maxValue) / (self.latitudeNum);
    NSString *strRate = [NSString stringWithFormat:@"%ld", rate];
    CCFloat first = [[strRate substringToIndex:1] intValue] + 1.0f;
    if (first > 0 && strRate.length > 1) {
        CCFloat second = [[[strRate substringToIndex:2] substringFromIndex:1] intValue];
        if (second < 5) {
            first = first - 0.5;
        }
        rate = first * pow(10, strRate.length - 1);
    } else {
        rate = 1;
    }
    //等分轴修正
    if (self.latitudeNum > 0 && (CCInt) (self.maxValue) % (self.latitudeNum * rate) != 0) {
        //最大值加上轴差
        self.maxValue = (CCInt) self.maxValue + (self.latitudeNum * rate) - ((CCInt) (self.maxValue) % (self.latitudeNum * rate));
    }
    //反向计算最小值
    self.minValue = 0 - self.maxValue;
}

- (void)drawData:(CGRect)rect {
    // 蜡烛棒宽度
    CCFloat stickWidth = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.maxSticksNum) - 1;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.stickBorderColor.CGColor);
    CGContextSetFillColorWithColor(context, self.stickFillColor.CGColor);

    if (self.stickData != NULL && [self.stickData count] > 0) {

        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 蜡烛棒起始绘制位置
            CCFloat stickX = self.axisMarginLeft + 1;
            //判断显示为方柱或显示为线条
            for (CCUInt i = 0; i < [self.stickData count]; i++) {
                CCSStickChartData *stick = [self.stickData objectAtIndex:i];

                CCFloat highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                CCFloat lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        //填充路径
                        CGContextFillPath(context);
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
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
            for (CCInt i = [self.stickData count] - 1; i >= 0; i--) {
                CCSStickChartData *stick = [self.stickData objectAtIndex:i];

                CCFloat highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                CCFloat lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        //填充路径
                        CGContextFillPath(context);
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
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
