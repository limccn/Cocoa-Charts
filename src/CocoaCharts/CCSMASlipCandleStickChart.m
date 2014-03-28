//
//  CCSMASlipCandleStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
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

- (void)dealloc {
    [_linesData release];
    [super dealloc];
}

- (void)calcDataValueRange {
    //调用父类
    [super calcDataValueRange];
    
    double maxValue = 0;
    double minValue = NSIntegerMax;
    
    for (NSInteger i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        //获取线条数据
        NSArray *lineDatas = line.data;
        for (NSUInteger j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
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
    if (self.linesData == nil) {
        return;
    }
    
    if ([self.linesData count] == 0) {
        return;
    }
    
    //起始点
    CGFloat lineLength;
    // 起始位置
    CGFloat startX;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //逐条输出MA线
    for (NSUInteger i = 0; i < [self.linesData count]; i++) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        if (line== nil) {
            continue;
        }
        if ([line.data count] == 0) {
            continue;
        }
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, line.color.CGColor);
        //获取线条数据
        NSArray *lineDatas = line.data;
        
        //判断Y轴的位置设置从左往右还是从右往左绘制
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 点线距离
            lineLength = ([self dataQuadrantPaddingWidth:rect] * 1.0 / self.displayNumber) - 1;
            //起始点
            startX = [self dataQuadrantPaddingStartX:rect] + lineLength / 2;
            //遍历并绘制线条
            for (NSUInteger j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CGFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * [self dataQuadrantPaddingHeight:rect] + [self dataQuadrantPaddingStartY:rect]);
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
            lineLength = ([self dataQuadrantPaddingWidth:rect] * 1.0 / self.displayNumber);
            //起始点
            startX = [self dataQuadrantPaddingEndX:rect] - lineLength / 2;
            //遍历并绘制线条
            for (NSUInteger j = 0; j < self.displayNumber; j++) {
                NSUInteger index = self.displayFrom + self.displayNumber - 1 - j;
                CCSLineData *lineData = [lineDatas objectAtIndex:index];
                //获取终点Y坐标
                CGFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * [self dataQuadrantPaddingHeight:rect] + [self dataQuadrantPaddingStartY:rect]);
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
        
        //绘制路径
        CGContextStrokePath(context);
    }
}

@end
