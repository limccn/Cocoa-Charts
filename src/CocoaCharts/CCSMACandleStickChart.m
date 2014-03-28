//
//  CCSMACandleStickChart.m
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

#import "CCSMACandleStickChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"


@implementation CCSMACandleStickChart

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
    
    //逐条输出MA线
    for (NSUInteger i = 0; i < [self.linesData count]; i++) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        if (line == nil) {
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
            lineLength = ([self dataQuadrantPaddingWidth:rect] / self.maxSticksNum) - 1;
            //起始点
            startX = [self dataQuadrantPaddingStartX:rect] + lineLength / 2;
            //遍历并绘制线条
            for (NSUInteger j = 0; j < [lineDatas count]; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CGFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * [self dataQuadrantPaddingHeight:rect] + [self dataQuadrantPaddingStartY:rect]);
                //绘制线条路径
                if (j == 0) {
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
            lineLength = ([self dataQuadrantPaddingWidth:rect] * 1.0 / self.maxSticksNum);
            //起始点
            startX = [self dataQuadrantPaddingEndX:rect] - lineLength / 2;
            //遍历并绘制线条
            for (NSInteger j = [lineDatas count] - 1; j >= 0; j--) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CGFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * [self dataQuadrantPaddingHeight:rect] + [self dataQuadrantPaddingStartY:rect]);
                //绘制线条路径
                if (j == [lineDatas count] - 1) {
                    CGContextMoveToPoint(context, startX, valueY);
                } else {
                    //TODO:BUG待修正
                    if (((CCSLineData *) [lineDatas objectAtIndex:j]).value != 0) {
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

@end
