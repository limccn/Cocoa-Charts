//
//  CCSStackedAreaChart.m
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

#import "CCSStackedAreaChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSStackedAreaChart
@synthesize areaAlpha = _areaAlpha;

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
    //去除轴对称属性
    self.areaAlpha = 0.2;
    self.lineAlignType = CCSLineAlignTypeJustify;
}

- (void)calcValueRange {
    if (self.linesData != NULL && [self.linesData count] > 0) {
        CCFloat maxValue = 0;
        CCFloat minValue = CCIntMax;

        for (CCUInt i = 0; i < [self.linesData count]; i++) {
            CCSTitledLine *line = [self.linesData objectAtIndex:i];
            if (line != NULL && [line.data count] > 0) {
                //判断显示为方柱或显示为线条
                for (CCUInt j = 0; j < [line.data count]; j++) {

                    CCSLineData *lineData = [line.data objectAtIndex:j];
                    CCFloat sumValue = lineData.value;
                    for (CCUInt k = 0; k < i; k++) {
                        CCSTitledLine *preLine = [self.linesData objectAtIndex:k];
                        if (preLine != NULL) {
                            CCSLineData *lineDataForSum = [preLine.data objectAtIndex:j];
                            sumValue = sumValue + lineDataForSum.value;
                        }
                    }

                    if (sumValue < minValue) {
                        minValue = sumValue;
                    }

                    if (sumValue > maxValue) {
                        maxValue = sumValue;
                    }

                }
            }
        }

        if ((CCInt) maxValue > (CCInt) minValue) {
            if ((maxValue - minValue) < 10. && minValue > 1.) {
                self.maxValue = (CCInt) (maxValue + 1);
                self.minValue = (CCInt) (minValue - 1);
            } else {
                self.maxValue = (CCInt) (maxValue + (maxValue - minValue) * 0.1);
                self.minValue = (CCInt) (minValue - (maxValue - minValue) * 0.1);

                if (self.minValue < 0) {
                    self.minValue = 0;
                }
            }
        } else if ((CCInt) maxValue == (CCInt) minValue) {
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

    CCInt rate;

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
    if (self.latitudeNum > 0 && rate > 1 && (CCInt) (self.minValue) % rate != 0) {
        //最大值加上轴差
        self.minValue = (CCInt) self.minValue - ((CCInt) (self.minValue) % rate);
    }
    //等分轴修正
    if (self.latitudeNum > 0 && (CCInt) (self.maxValue - self.minValue) % (self.latitudeNum * rate) != 0) {
        //最大值加上轴差
        self.maxValue = (CCInt) self.maxValue + (self.latitudeNum * rate) - ((CCInt) (self.maxValue - self.minValue) % (self.latitudeNum * rate));
    }
}

- (void)drawData:(CGRect)rect {

    // 起始位置
    CCFloat startX;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);

    if (self.linesData != NULL) {
        //逐条输出MA线
        for (CCInt i = [self.linesData count] - 1; i >= 0; i--) {
            CCSTitledLine *line = [self.linesData objectAtIndex:i];

            if (line != NULL) {
                //设置线条颜色
                CGContextSetStrokeColorWithColor(context, line.color.CGColor);
                //获取线条数据
                NSArray *lineDatas = line.data;
                //判断Y轴的位置设置从左往右还是从右往左绘制
                if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
                    //TODO:自左向右绘图未对应
                    // 点线距离
                    CCFloat lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / ([line.data count] - 1));
                    //起始点
                    startX = super.axisMarginLeft;
                    //遍历并绘制线条
                    for (CCUInt j = 0; j < [lineDatas count]; j++) {
                        CCSLineData *lineData = [lineDatas objectAtIndex:j];
                        //计算Stack的数据和
                        CCFloat sumValue = lineData.value;
                        for (CCUInt k = 0; k < i; k++) {
                            CCSTitledLine *preLine = [self.linesData objectAtIndex:k];
                            if (preLine != NULL) {
                                CCSLineData *lineDataForSum = [preLine.data objectAtIndex:j];
                                sumValue = sumValue + lineDataForSum.value;
                            }
                        }
                        //获取终点Y坐标
                        CCFloat valueY = ((1 - (sumValue - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                        //绘制线条路径
                        if (j == 0) {
                            CGContextMoveToPoint(context, startX, valueY);
                        } else {
                            CGContextAddLineToPoint(context, startX, valueY);
                        }
                        //X位移
                        startX = startX + lineLength;
                    }
                } else {

                    // 点线距离
                    CCFloat lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([line.data count] - 1));
                    //起始点
                    startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft;

                    //判断点的多少
                    if ([lineDatas count] == 0) {
                        //0根则返回
                        return;
                    } else if ([lineDatas count] == 1) {
                        //1根则绘制一条直线
                        CCSLineData *lineData = [lineDatas objectAtIndex:0];
                        //获取终点Y坐标
                        CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);

                        CGContextMoveToPoint(context, startX, valueY);
                        CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);

                    } else {
                        //遍历并绘制线条
                        for (CCInt j = [lineDatas count] - 1; j >= 0; j--) {
                            CCSLineData *lineData = [lineDatas objectAtIndex:j];
                            //获取终点Y坐标
                            CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                            //绘制线条路径
                            if (j == [lineDatas count] - 1) {
                                CGContextMoveToPoint(context, startX, valueY);
                            } else if (j == 0) {
                                CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
                            } else {
                                CGContextAddLineToPoint(context, startX, valueY);
                            }
                            //X位移
                            startX = startX - lineLength;
                        }
                    }
                }

                //备份路径
                CGPathRef path = CGContextCopyPath(context);

                //绘制路径
                CGContextStrokePath(context);

                CGContextAddPath(context, path);
                CGContextAddLineToPoint(context, rect.size.width - self.axisMarginRight, rect.size.height - self.axisMarginBottom - self.axisMarginTop);
                CGContextAddLineToPoint(context, self.axisMarginLeft + self.axisMarginRight, rect.size.height - self.axisMarginBottom - self.axisMarginTop);

                CGContextClosePath(context);
                CGContextSetAlpha(context, self.areaAlpha);
                CGContextSetFillColorWithColor(context, line.color.CGColor);
                CGContextFillPath(context);

                CGPathRelease(path);

                path = nil;
            }
        }
    }
}

@end
