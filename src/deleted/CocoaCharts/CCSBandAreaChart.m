//
//  CCSBandAreaChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/14/13.
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

#import "CCSBandAreaChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSBandAreaChart
@synthesize areaAlpha = _areaAlpha;
@synthesize bandColor = _bandColor;

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
    self.areaAlpha = 0.5;
    self.bandColor = [UIColor yellowColor];
    self.lineAlignType = CCSLineAlignTypeJustify;
}

- (void)drawData:(CGRect)rect {
    
    if (self.linesData == nil) {
        return;
    }
    // 起始位置
    CCFloat startX;
    CCFloat lastY = 0;
    CCFloat lastX = 0;
    
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //逐条输出MA线
    for (CCInt i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        if (line == nil) {
            continue;
        }
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, line.color.CGColor);
        //获取线条数据
        NSArray *lineDatas = line.data;
        //判断Y轴的位置设置从左往右还是从右往左绘制
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            //TODO:自左向右绘图未对应
            // 点线距离
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / ([line.data count] - 1));
            //起始点
            startX = [self dataQuadrantPaddingStartX:rect];
            //遍历并绘制线条
            for (CCUInt j = 0; j < [lineDatas count]; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CCFloat valueY =  [self calcValueY:lineData.value inRect:rect];

                //绘制线条路径
                if (j == 0) {
                    CGContextMoveToPoint(context, startX, valueY);
                } else {
                    CGContextAddLineToPoint(context, startX, valueY);
                }
                lastY = valueY;
                //X位移
                startX = startX + lineLength;
            }
        } else {
            
            // 点线距离
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / ([line.data count] - 1));
            //起始点
            startX = [self dataQuadrantPaddingEndX:rect];
            
            //判断点的多少
            if ([lineDatas count] == 0) {
                //0根则返回
                return;
            } else if ([lineDatas count] == 1) {
                //1根则绘制一条直线
                CCSLineData *lineData = [lineDatas objectAtIndex:0];
                //获取终点Y坐标
                CCFloat valueY =  [self calcValueY:lineData.value inRect:rect];

                
                CGContextMoveToPoint(context, startX, valueY);
                CGContextAddLineToPoint(context, [self dataQuadrantPaddingStartX:rect], valueY);
                
            } else {
                //遍历并绘制线条
                for (CCInt j = [lineDatas count] - 1; j >= 0; j--) {
                    CCSLineData *lineData = [lineDatas objectAtIndex:j];
                    //获取终点Y坐标
                    CCFloat valueY =  [self calcValueY:lineData.value inRect:rect];

                    //绘制线条路径
                    if (j == [lineDatas count] - 1) {
                        CGContextMoveToPoint(context, startX, valueY);
                    } else if (j == 0) {
                        CGContextAddLineToPoint(context, [self dataQuadrantPaddingStartX:rect], valueY);
                    } else {
                        CGContextAddLineToPoint(context, startX, valueY);
                    }
                    
                    lastY = valueY;
                    //X位移
                    startX = startX - lineLength;
                }
            }
            //绘制路径
            CGContextStrokePath(context);
        }
    }
    
    CCSTitledLine *line1 = [self.linesData objectAtIndex:0];
    CCSTitledLine *line2 = [self.linesData objectAtIndex:1];
    
    
    if (line1 == nil || line2 == nil) {
        return;
    }
    
    //获取线条数据
    NSArray *line1Datas = line1.data;
    NSArray *line2Datas = line2.data;
    
    //判断Y轴的位置设置从左往右还是从右往左绘制
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        //TODO:自左向右绘图未对应
        // 点线距离
        CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / ([line1.data count] - 1));
        //起始点
        startX = [self dataQuadrantPaddingStartX:rect];
        //遍历并绘制线条
        for (CCUInt j = 0; j < ([line1.data count] - 1); j++) {
            CCSLineData *line1Data = [line1Datas objectAtIndex:j];
            CCSLineData *line2Data = [line2Datas objectAtIndex:j];
            
            //获取终点Y坐标
            CCFloat valueY1 = [self calcValueY:line1Data.value inRect:rect];
            CCFloat valueY2 = [self calcValueY:line2Data.value inRect:rect];
            
            //绘制线条路径
            if (j == 0) {
                CGContextMoveToPoint(context, startX, valueY1);
                CGContextAddLineToPoint(context, startX, valueY2);
                CGContextMoveToPoint(context, startX, valueY1);
            } else {
                CGContextAddLineToPoint(context, startX, valueY1);
                CGContextAddLineToPoint(context, startX, valueY2);
                CGContextAddLineToPoint(context, lastX, lastY);
                
                CGContextClosePath(context);
                CGContextMoveToPoint(context, startX, valueY1);
            }
            lastX = startX;
            lastY = valueY2;
            //X位移
            startX = startX + lineLength;
        }
    } else {
        // 点线距离
        CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / ([line1.data count] - 1));
        //起始点
        startX = [self dataQuadrantPaddingEndX:rect];
        
        //判断点的多少
        if ([line1Datas count] == 0 || [line2Datas count] == 0) {
            return;
        } else if ([line1Datas count] == 1 || [line2Datas count] == 1) {
            return;
        } else {
            //遍历并绘制线条
            for (CCUInt j = 0; j < [line1.data count]; j++) {
                CCUInt index = [line1.data count] - 1 - j;
                CCSLineData *line1Data = [line1Datas objectAtIndex:index];
                CCSLineData *line2Data = [line2Datas objectAtIndex:index];
                
                //获取终点Y坐标
                CCFloat valueY1 = [self calcValueY:line1Data.value inRect:rect];
                CCFloat valueY2 = [self calcValueY:line2Data.value inRect:rect];
                //绘制线条路径
                if (index == [line1.data count] - 1) {
                    CGContextMoveToPoint(context, startX, valueY1);
                    CGContextAddLineToPoint(context, startX, valueY2);
                    CGContextMoveToPoint(context, startX, valueY1);
                } else {
                    CGContextAddLineToPoint(context, startX, valueY1);
                    CGContextAddLineToPoint(context, startX, valueY2);
                    CGContextAddLineToPoint(context, lastX, lastY);
                    
                    CGContextClosePath(context);
                    CGContextMoveToPoint(context, startX, valueY1);
                }
                
                lastX = startX;
                lastY = valueY2;
                //X位移
                startX = startX - lineLength;
            }
        }
    }

    CGContextClosePath(context);
    CGContextSetAlpha(context, self.areaAlpha);
    CGContextSetFillColorWithColor(context, self.bandColor.CGColor);
    CGContextFillPath(context);
    
}


@end
