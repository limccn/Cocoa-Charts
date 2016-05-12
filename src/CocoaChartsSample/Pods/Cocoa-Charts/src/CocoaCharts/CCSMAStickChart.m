//
//  CCSMAStickChart.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-26.
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

#import "CCSMAStickChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"


@implementation CCSMAStickChart

@synthesize linesData = _linesData;

- (void)initProperty {

    [super initProperty];
    //初始化颜色
    self.linesData = nil;
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
                        lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) * 1.0 / self.maxSticksNum) - 1;
                        //起始点
                        startX = super.axisMarginLeft + lineLength / 2;
                        //遍历并绘制线条
                        for (CCUInt j = 0; j < [lineDatas count]; j++) {
                            CCSLineData *lineData = [lineDatas objectAtIndex:j];
                            //获取终点Y坐标
                            CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
                        lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) * 1.0 / self.maxSticksNum) + 0.5;
                        //起始点
                        startX = rect.size.width - self.axisMarginRight - lineLength / 2;
                        //遍历并绘制线条
                        for (CCInt j = [lineDatas count] - 1; j >= 0; j--) {
                            CCSLineData *lineData = [lineDatas objectAtIndex:j];
                            //获取终点Y坐标
                            CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}

@end
