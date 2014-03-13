//
//  CCSCandleStickChart.m
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

#import "CCSCandleStickChart.h"
#import "CCSCandleStickChartData.h"


@implementation CCSCandleStickChart

//@synthesize stickData;

@synthesize positiveStickBorderColor = _positiveStickBorderColor;
@synthesize positiveStickFillColor = _positiveStickFillColor;
@synthesize negativeStickBorderColor = _negativeStickBorderColor;
@synthesize negativeStickFillColor = _negativeStickFillColor;
@synthesize crossStarColor = _crossStarColor;
@synthesize candleStickStyle = _candleStickStyle;


- (void)initProperty {

    [super initProperty];
    //初始化颜色
    self.positiveStickBorderColor = [UIColor redColor];
    self.positiveStickFillColor = [UIColor redColor];
    self.negativeStickBorderColor = [UIColor blueColor];
    self.negativeStickFillColor = [UIColor blueColor];
    self.crossStarColor = [UIColor blackColor];

    self.candleStickStyle = CCSCandleStickStyleStandard;
}


- (void)calcValueRange {
    if (self.stickData != NULL && [self.stickData count] > 0) {

        double maxValue = 0;
        double minValue = NSIntegerMax;

        CCSCandleStickChartData *first = [self.stickData objectAtIndex:0];

        //第一个stick为停盘的情况
        if (first.high == 0 && first.low == 0) {

        } else {
            //max取最小，min取最大
            maxValue = first.high;
            minValue = first.low;
        }

        //判断显示为方柱或显示为线条
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            for (NSUInteger i = 0; i < self.maxSticksNum; i++) {
                CCSCandleStickChartData *stick = [self.stickData objectAtIndex:i];
                if (stick.open == 0 && stick.high == 0 && stick.low == 0) {
                    //停盘期间计算收盘价
                    if (stick.close > 0) {
                        if (stick.close < minValue) {
                            minValue = stick.close;
                        }

                        if (stick.close > maxValue) {
                            maxValue = stick.close;
                        }
                    }
                } else {
                    if (stick.low < minValue) {
                        minValue = stick.low;
                    }

                    if (stick.high > maxValue) {
                        maxValue = stick.high;
                    }
                }
            }
        } else {
            for (NSInteger i = [self.stickData count] - 1; i > [self.stickData count] - self.maxSticksNum; i--) {
                CCSCandleStickChartData *stick = [self.stickData objectAtIndex:i];
                if (stick.open == 0 && stick.high == 0 && stick.low == 0) {
                    //停盘期间计算收盘价
                    if (stick.close > 0) {
                        if (stick.close < minValue) {
                            minValue = stick.close;
                        }

                        if (stick.close > maxValue) {
                            maxValue = stick.close;
                        }
                    }
                } else {
                    if (stick.low < minValue) {
                        minValue = stick.low;
                    }

                    if (stick.high > maxValue) {
                        maxValue = stick.high;
                    }
                }
            }
        }

        if ((long) maxValue > (long) minValue) {
            if (((long) maxValue - (long) minValue) < 10 && minValue > 1) {
                self.maxValue = (long) (maxValue + 1);
                self.minValue = (long) (minValue - 1);
            } else {
                self.maxValue = (long) (maxValue + (maxValue - minValue) * 0.1);
                self.minValue = (long) (minValue - (maxValue - minValue) * 0.1);
                if (self.minValue < 0) {
                    self.minValue = 0;
                }
            }
        } else if ((long) maxValue == (long) minValue) {
            if (maxValue <= 10 && maxValue > 1) {
                self.maxValue = maxValue + 1;
                self.minValue = minValue - 1;
            } else if (maxValue <= 100 && maxValue > 10) {
                self.maxValue = maxValue + 10;
                self.minValue = minValue - 10;
            } else if (maxValue <= 1000 && maxValue > 100) {
                self.maxValue = maxValue + 100;
                self.minValue = minValue - 100;
            } else if (maxValue <= 10000 && maxValue > 1000) {
                self.maxValue = maxValue + 1000;
                self.minValue = minValue - 1000;
            } else if (maxValue <= 100000 && maxValue > 10000) {
                self.maxValue = maxValue + 10000;
                self.minValue = minValue - 10000;
            } else if (maxValue <= 1000000 && maxValue > 100000) {
                self.maxValue = maxValue + 100000;
                self.minValue = minValue - 100000;
            } else if (maxValue <= 10000000 && maxValue > 1000000) {
                self.maxValue = maxValue + 1000000;
                self.minValue = minValue - 1000000;
            } else if (maxValue <= 100000000 && maxValue > 10000000) {
                self.maxValue = maxValue + 10000000;
                self.minValue = minValue - 10000000;
            }
        } else {
            self.maxValue = 0;
            self.minValue = 0;
        }
    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }

    int rate = 1;

    if (self.maxValue < 3000) {
        rate = 1;
    } else if (self.maxValue >= 3000 && self.maxValue < 5000) {
        rate = 5;
    } else if (self.maxValue >= 5000 && self.maxValue < 30000) {
        rate = 10;
    } else if (self.maxValue >= 30000 && self.maxValue < 50000) {
        rate = 50;
    } else if (self.maxValue >= 50000 && self.maxValue < 300000) {
        rate = 100;
    } else if (self.maxValue >= 300000 && self.maxValue < 500000) {
        rate = 500;
    } else if (self.maxValue >= 500000 && self.maxValue < 3000000) {
        rate = 1000;
    } else if (self.maxValue >= 3000000 && self.maxValue < 5000000) {
        rate = 5000;
    } else if (self.maxValue >= 5000000 && self.maxValue < 30000000) {
        rate = 10000;
    } else if (self.maxValue >= 30000000 && self.maxValue < 50000000) {
        rate = 50000;
    } else {
        rate = 100000;
    }

    //等分轴修正
    if (self.latitudeNum > 0 && rate > 1 && (long) (self.minValue) % rate != 0) {
        //最大值加上轴差
        self.minValue = (long) self.minValue - ((long) (self.minValue) % rate);
    }
    //等分轴修正
    if (self.latitudeNum > 0 && (long) (self.maxValue - self.minValue) % (self.latitudeNum * rate) != 0) {
        //最大值加上轴差
        self.maxValue = (long) self.maxValue + (self.latitudeNum * rate) - ((long) (self.maxValue - self.minValue) % (self.latitudeNum * rate));
    }
}

- (void)initAxisX {
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.stickData != NULL && [self.stickData count] > 0) {
        float average = 1.0 * self.maxSticksNum / self.longitudeNum;
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            CCSCandleStickChartData *chartdata = nil;
            //处理刻度
            for (NSUInteger i = 0; i < self.longitudeNum; i++) {
                NSUInteger index = (NSUInteger) floor(i * average);
                if (index > self.maxSticksNum - 1) {
                    index = self.maxSticksNum - 1;
                }
                chartdata = [self.stickData objectAtIndex:index];
                //追加标题
                [TitleX addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
            }
            chartdata = [self.stickData objectAtIndex:self.maxSticksNum - 1];
            //追加标题
            [TitleX addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
        } else {
            CCSCandleStickChartData *chartdata = nil;
            //处理刻度
            for (NSUInteger i = 0; i < self.longitudeNum; i++) {
                NSUInteger index = [self.stickData count] - self.maxSticksNum + (NSUInteger) floor(i * average);
                if (index > [self.stickData count] - 1) {
                    index = [self.stickData count] - 1;
                }
                chartdata = [self.stickData objectAtIndex:index];
                //追加标题
                [TitleX addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
            }
            chartdata = [self.stickData objectAtIndex:[self.stickData count] - 1];
            //追加标题
            [TitleX addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
        }

    }
    self.longitudeTitles = TitleX;
}


- (void)initAxisY {
    //调用父类的initAxisY方法
    [super initAxisY];
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)drawData:(CGRect)rect {
    // 蜡烛棒宽度
    float stickWidth = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.maxSticksNum) - 1;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);

    if (self.stickData != NULL && [self.stickData count] > 0) {
        //判断Y轴的位置设置从左往右还是从右往左绘制
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 蜡烛棒起始绘制位置
            float stickX = self.axisMarginLeft + 1;
            for (NSUInteger i = 0; i < [self.stickData count]; i++) {
                CCSCandleStickChartData *data = [self.stickData objectAtIndex:i];
                float openY = ((1 - (data.open - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);
                float highY = ((1 - (data.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);
                float lowY = ((1 - (data.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);
                float closeY = ((1 - (data.close - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                // 处理和生产K线中的阴线和阳线
                if (data.open == 0 && data.high == 0 && data.low == 0) {
                    //停盘的情况，什么都不绘制
                } else if (data.open < data.close) {
                    //阳线
                    //根据宽度判断是否绘制立柱
                    CGContextSetStrokeColorWithColor(context, self.positiveStickBorderColor.CGColor);
                    CGContextSetFillColorWithColor(context, self.positiveStickFillColor.CGColor);

                    if (self.candleStickStyle == CCSCandleStickStyleStandard) {
                        if (stickWidth >= 2) {
                            CGContextAddRect(context, CGRectMake(stickX, closeY, stickWidth, openY - closeY));
                            CGContextFillPath(context);
                        }
                        //绘制上下影线
                        CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                        CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                        CGContextStrokePath(context);

                    } else if (self.candleStickStyle == CCSCandleStickStyleBar) {
                        //绘制上下影线
                        CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                        CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                        CGContextMoveToPoint(context, stickX + stickWidth / 2, openY);
                        CGContextAddLineToPoint(context, stickX, openY);

                        CGContextMoveToPoint(context, stickX + stickWidth / 2, closeY);
                        CGContextAddLineToPoint(context, stickX + stickWidth, closeY);

                        CGContextStrokePath(context);
                    } else if (self.candleStickStyle == CCSCandleStickStyleLine) {

                    }

                } else if (data.open > data.close) {
                    //阴线
                    //根据宽度判断是否绘制立柱
                    CGContextSetStrokeColorWithColor(context, self.negativeStickBorderColor.CGColor);
                    CGContextSetFillColorWithColor(context, self.negativeStickBorderColor.CGColor);

                    if (self.candleStickStyle == CCSCandleStickStyleStandard) {
                        if (stickWidth >= 2) {
                            CGContextAddRect(context, CGRectMake(stickX, openY, stickWidth, closeY - openY));
                            CGContextFillPath(context);
                        }

                        //绘制上下影线
                        CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                        CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                        CGContextStrokePath(context);

                    } else if (self.candleStickStyle == CCSCandleStickStyleBar) {
                        //绘制上下影线
                        CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                        CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                        CGContextMoveToPoint(context, stickX + stickWidth / 2, openY);
                        CGContextAddLineToPoint(context, stickX, openY);

                        CGContextMoveToPoint(context, stickX + stickWidth / 2, closeY);
                        CGContextAddLineToPoint(context, stickX + stickWidth, closeY);

                        CGContextStrokePath(context);
                    } else if (self.candleStickStyle == CCSCandleStickStyleLine) {

                    }
                } else {
                    //十字线
                    //根据宽度判断是否绘制横线
                    CGContextSetStrokeColorWithColor(context, self.crossStarColor.CGColor);
                    CGContextSetFillColorWithColor(context, self.crossStarColor.CGColor);
                    if (stickWidth >= 2) {
                        CGContextMoveToPoint(context, stickX, closeY);
                        CGContextAddLineToPoint(context, stickX + stickWidth, openY);
                    }
                    //绘制上下影线
                    CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                    CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                    CGContextStrokePath(context);
                }

                //X位移
                stickX = stickX + 1 + stickWidth;
            }
        } else {
            // 蜡烛棒起始绘制位置
            float stickX = rect.size.width - self.axisMarginRight - 1 - stickWidth;
            for (NSInteger i = [self.stickData count] - 1; i >= 0; i--) {
                CCSCandleStickChartData *data = [self.stickData objectAtIndex:i];
                float openY = ((1 - (data.open - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);
                float highY = ((1 - (data.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);
                float lowY = ((1 - (data.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);
                float closeY = ((1 - (data.close - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                // 处理和生产K线中的阴线和阳线
                if (data.open == 0 && data.high == 0 && data.low == 0) {
                    //停盘的情况，什么都不绘制
                } else if (data.open < data.close) {
                    //阳线
                    //根据宽度判断是否绘制立柱
                    CGContextSetStrokeColorWithColor(context, self.positiveStickBorderColor.CGColor);
                    CGContextSetFillColorWithColor(context, self.positiveStickFillColor.CGColor);
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, closeY, stickWidth, openY - closeY));
                        CGContextFillPath(context);
                    }
                    //绘制上下影线
                    CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                    CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                    CGContextStrokePath(context);

                } else if (data.open > data.close) {
                    //阴线
                    //根据宽度判断是否绘制立柱
                    CGContextSetStrokeColorWithColor(context, self.negativeStickBorderColor.CGColor);
                    CGContextSetFillColorWithColor(context, self.negativeStickBorderColor.CGColor);
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, openY, stickWidth, closeY - openY));
                        CGContextFillPath(context);
                    }
                    //绘制上下影线
                    CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                    CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                    CGContextStrokePath(context);
                } else {
                    //十字线
                    //根据宽度判断是否绘制横线
                    CGContextSetStrokeColorWithColor(context, self.crossStarColor.CGColor);
                    CGContextSetFillColorWithColor(context, self.crossStarColor.CGColor);
                    if (stickWidth >= 2) {
                        CGContextMoveToPoint(context, stickX, closeY);
                        CGContextAddLineToPoint(context, stickX + stickWidth, openY);
                    }
                    //绘制上下影线
                    CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                    CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);

                    CGContextStrokePath(context);
                }

                //X位移
                stickX = stickX - 1 - stickWidth;
            }
        }
    }
}

@end
