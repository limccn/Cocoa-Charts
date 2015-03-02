//
//  CCSBOLLMASlipCandleStickChart.m
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

#import "CCSBOLLMASlipCandleStickChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSBOLLMASlipCandleStickChart
@synthesize bollingerBandData = _bollingerBandData;
@synthesize bollingerBandColor = _bollingerBandColor;
@synthesize bollingerBandAlpha = _bollingerBandAlpha;
@synthesize bollingerBandStyle = _bollingerBandStyle;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)dealloc {
    [_bollingerBandData release];
    [_bollingerBandColor release];
    [super dealloc];
}

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    //去除轴对称属性
    self.bollingerBandAlpha = 0.1;
    self.bollingerBandColor = [UIColor yellowColor];
    self.bollingerBandStyle = CCSBollingerBandStyleBand;
}


- (void)calcDataValueRange {
    //调用父类
    [super calcDataValueRange];
    
    CCFloat maxValue = 0;
    CCFloat minValue = CCIntMax;
    
    for (CCInt i = [self.bollingerBandData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.bollingerBandData objectAtIndex:i];
        
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

- (void)drawBandBorder:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CCFloat startX;
    
    //逐条输出MA线
    for (CCInt i = [self.bollingerBandData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.bollingerBandData objectAtIndex:i];
        
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
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
            //起始点
            startX = [self dataQuadrantPaddingStartX:rect] + lineLength / 2;
            //遍历并绘制线条
            for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CCFloat valueY = [self calcValueY:lineData.value inRect:rect];
                //绘制线条路径
                if (j == self.displayFrom) {
                    CGContextMoveToPoint(context, startX, valueY);
                } else {
                    if (((CCSLineData *) [lineDatas objectAtIndex:j - 1]).value != 0) {
                        CGContextAddLineToPoint(context, startX, valueY);
                    } else {
                        CGContextMoveToPoint(context, startX, valueY);
                        CGContextAddLineToPoint(context, startX, valueY);
                    }
                }
                
                //X位移
                startX = startX + lineLength;
            }
        } else {
            
            // 点线距离
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
            //起始点
            startX = [self dataQuadrantPaddingEndX:rect] - lineLength / 2;
            
            //判断点的多少
            if ([lineDatas count] == 0) {
                //0根则返回
                return;
            } else if ([lineDatas count] == 1) {
                //1根则绘制一条直线
                CCSLineData *lineData = [lineDatas objectAtIndex:0];
                //获取终点Y坐标
                CCFloat valueY = [self calcValueY:lineData.value inRect:rect];
                
                CGContextMoveToPoint(context, startX, valueY);
                CGContextAddLineToPoint(context, [self dataQuadrantPaddingStartX:rect], valueY);
                
            } else {
                //遍历并绘制线条
                for (CCUInt j = 0; j < self.displayNumber; j++) {
                    CCUInt index = self.displayFrom + self.displayNumber - 1 - j;
                    CCSLineData *lineData = [lineDatas objectAtIndex:index];
                    //获取终点Y坐标
                    CCFloat valueY = [self calcValueY:lineData.value inRect:rect];
                    //绘制线条路径
                    if (index == self.displayFrom + self.displayNumber - 1) {
                        CGContextMoveToPoint(context, startX, valueY);
                    } else {
                        if (lineData.value != 0) {
                            CGContextAddLineToPoint(context, startX, valueY);
                        } else {
                            CGContextMoveToPoint(context, startX, valueY);
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

- (void)drawBandFill:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    
    CCFloat startX;
    CCFloat lastY = 0;
    CCFloat lastX = 0;
    
    CCSTitledLine *line1 = [self.bollingerBandData objectAtIndex:0];
    CCSTitledLine *line2 = [self.bollingerBandData objectAtIndex:1];
    
    if (line1 == nil || line2 == nil) {
        return;
    }
    //设置线条颜色
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
    //获取线条数据
    NSArray *line1Datas = line1.data;
    NSArray *line2Datas = line2.data;
    
    //判断Y轴的位置设置从左往右还是从右往左绘制
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        //TODO:自左向右绘图未对应
        // 点线距离
        CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
        //起始点
        startX = [self dataQuadrantPaddingStartX:rect] + lineLength / 2;
        //遍历并绘制线条
        for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
            CCSLineData *line1Data = [line1Datas objectAtIndex:j];
            CCSLineData *line2Data = [line2Datas objectAtIndex:j];
            
            //获取终点Y坐标
            CCFloat valueY1 = [self calcValueY:line1Data.value inRect:rect];
            CCFloat valueY2 = [self calcValueY:line2Data.value inRect:rect];
            
            //绘制线条路径
            if (j == self.displayFrom) {
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
        CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
        //起始点
        startX = [self dataQuadrantPaddingEndX:rect] - lineLength / 2;
        
        //判断点的多少
        if ([line1Datas count] == 0 || [line2Datas count] == 0) {
            return;
        } else if ([line1Datas count] == 1 || [line2Datas count] == 1) {
            return;
        } else {
            //遍历并绘制线条
            for (CCUInt j = 0; j < self.displayNumber; j++) {
                CCUInt index = self.displayFrom + self.displayNumber - 1 - j;
                CCSLineData *line1Data = [line1Datas objectAtIndex:index];
                CCSLineData *line2Data = [line2Datas objectAtIndex:index];
                
                //获取终点Y坐标
                CCFloat valueY1 = [self calcValueY:line1Data.value inRect:rect];
                CCFloat valueY2 = [self calcValueY:line2Data.value inRect:rect];
                //绘制线条路径
                if (index == self.displayFrom + self.displayNumber - 1) {
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
    CGContextSetAlpha(context, self.bollingerBandAlpha);
    CGContextSetFillColorWithColor(context, self.bollingerBandColor.CGColor);
    CGContextFillPath(context);
    
}

- (void)drawData:(CGRect)rect {
    //调用父类的绘制方法
    [super drawData:rect];
    
    if (self.bollingerBandData == nil) {
        return;
    }
    
    if (self.bollingerBandStyle == CCSBollingerBandStyleNone) {
        // Do Nothing
    }
    else if (self.bollingerBandStyle == CCSBollingerBandStyleBand) {
        [self drawBandBorder:rect];
        [self drawBandFill:rect];
    }
    else if (self.bollingerBandStyle == CCSBollingerBandStyleLane) {
        [self drawBandBorder:rect];
    }
    else if (self.bollingerBandStyle == CCSBollingerBandStyleNoBorder) {
        [self drawBandFill:rect];
    }else {
        // Do Nothing
    }
}

@end
