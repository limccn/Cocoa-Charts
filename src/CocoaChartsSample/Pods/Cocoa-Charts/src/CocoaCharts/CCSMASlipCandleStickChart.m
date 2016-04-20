//
//  CCSMASlipCandleStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSMASlipCandleStickChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@implementation CCSMASlipCandleStickChart

@synthesize linesData = _linesData;

- (void)initProperty {

    [super initProperty];
    //初始化颜色
    self.linesData = nil;
}

- (void)calcDataValueRange {
    //调用父类
    [super calcDataValueRange];
    
    CCFloat maxValue = 0;
    CCFloat minValue = CCIntMax;
    
    for (CCInt i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        //获取线条数据
        NSArray *lineDatas = line.data;
        for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
            CCSLineData *lineData = [lineDatas objectAtIndex:j];
            
            //忽略值为0的情况
            if (lineData.value == 0) {
                
            }else {
                if (lineData.value < minValue) {
                    minValue = lineData.value;
                }
                
                if (lineData.value > maxValue) {
                    maxValue = lineData.value;
                }
            }
        }
        
    }
    
    if (self.minValue > minValue) {
        self.minValue = minValue;
    }
    
    if (self.maxValue < maxValue) {
        self.maxValue = maxValue;
    }
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

- (void)drawData:(CGRect)rect {
    //调用父类的绘制方法
    [super drawData:rect];

    //在K线图上增加均线
    [self drawLinesData:rect];
}

- (void)drawLinesData:(CGRect)rect {
    //起始点
    CCFloat lineLength;
    // 起始位置
    CCFloat startX;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);

    if (self.linesData != NULL) {
        //逐条输出MA线
        for (CCUInt i = 0; i < [self.linesData count]; i++) {
            CCSTitledLine *line = [self.linesData objectAtIndex:i];
            if (line != NULL) {
                //设置线条颜色
                CGContextSetStrokeColorWithColor(context, line.color.CGColor);
                //获取线条数据
                NSArray *lineDatas = line.data;
                if ([line.data count] > 0) {

                    //判断Y轴的位置设置从左往右还是从右往左绘制
                    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
                        // 点线距离
                        lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) * 1.0 / self.displayNumber) - 1;
                        //起始点
                        startX = super.axisMarginLeft + lineLength / 2;
                        //遍历并绘制线条
                        for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                            CCSLineData *lineData = [lineDatas objectAtIndex:j];
                            //获取终点Y坐标
                            CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                            //绘制线条路径
                            if (j == self.displayFrom) {
                                CGContextMoveToPoint(context, startX, valueY);
                            } else {
                                if (((CCSLineData *) [lineDatas objectAtIndex:j - 1]).value != 0) {
                                    CGContextAddLineToPoint(context, startX, valueY);
                                } else {
                                    CGContextMoveToPoint(context, startX - lineLength / 2, valueY);
                                    CGContextAddLineToPoint(context, startX, valueY);
                                }
                            }

                            //X位移
                            startX = startX + 1 + lineLength;
                        }
                    } else {
                        // 点线距离
                        lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) * 1.0 / self.displayNumber);
                        //起始点
                        startX = rect.size.width - self.axisMarginRight - lineLength / 2;
                        //遍历并绘制线条
                        for (CCUInt j = 0; j < self.displayNumber; j++) {
                            CCUInt index = self.displayFrom + self.displayNumber - 1 - j;
                            CCSLineData *lineData = [lineDatas objectAtIndex:index];
                            //获取终点Y坐标
                            CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                            //绘制线条路径
                            if (index == self.displayFrom + self.displayNumber - 1) {
                                CGContextMoveToPoint(context, startX, valueY);
                            } else {
                                //TODO:BUG待修正
                                if (((CCSLineData *) [lineDatas objectAtIndex:index]).value != 0) {
                                    CGContextAddLineToPoint(context, startX, valueY);
                                } else {
                                    CGContextMoveToPoint(context, startX - lineLength / 2, valueY);
                                    CGContextAddLineToPoint(context, startX, valueY);
                                }
                            }
                            //X位移
                            startX = startX - lineLength;
                        }
                    }
                }

                //绘制路径
                CGContextStrokePath(context);
            }
        }
    }
}

@end
