//
//  CCSBOLLMASlipCandleStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/3/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
    self.bollingerBandStyle = CCSBollingerBandStyleLane;
}


- (void)calcDataValueRange {
    //调用父类
    [super calcDataValueRange];

    double maxValue = 0;
    double minValue = NSIntegerMax;

    for (NSInteger i = [self.bollingerBandData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.bollingerBandData objectAtIndex:i];

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

- (void)drawBandBorder:(CGRect)rect{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    
    float startX;
    float lastY = 0;
    
    //逐条输出MA线
    for (NSInteger i = [self.bollingerBandData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.bollingerBandData objectAtIndex:i];
        
        if (line != NULL) {
            //设置线条颜色
            CGContextSetStrokeColorWithColor(context, line.color.CGColor);
            //获取线条数据
            NSArray *lineDatas = line.data;
            //判断Y轴的位置设置从左往右还是从右往左绘制
            if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
                //TODO:自左向右绘图未对应
                // 点线距离
                float lineLength = ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / self.displayNumber);
                //起始点
                startX = super.axisMarginLeft + lineLength / 2;
                //遍历并绘制线条
                for (NSUInteger j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                    CCSLineData *lineData = [lineDatas objectAtIndex:j];
                    //获取终点Y坐标
                    float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
                    
                    
                    lastY = valueY;
                    //X位移
                    startX = startX + lineLength;
                }
            } else {
                
                // 点线距离
                float lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
                //起始点
                startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft - lineLength / 2;
                
                //判断点的多少
                if ([lineDatas count] == 0) {
                    //0根则返回
                    return;
                } else if ([lineDatas count] == 1) {
                    //1根则绘制一条直线
                    CCSLineData *lineData = [lineDatas objectAtIndex:0];
                    //获取终点Y坐标
                    float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                    
                    CGContextMoveToPoint(context, startX, valueY);
                    CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
                    
                } else {
                    //遍历并绘制线条
                    for (NSUInteger j = 0; j < self.displayNumber; j++) {
                        NSUInteger index = self.displayFrom + self.displayNumber - 1 - j;
                        CCSLineData *lineData = [lineDatas objectAtIndex:index];
                        //获取终点Y坐标
                        float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
                        
                        lastY = valueY;
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

- (void)drawBandFill:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    
    float startX;
    float lastY = 0;
    float lastX = 0;
    
    CCSTitledLine *line1 = [self.bollingerBandData objectAtIndex:0];
    CCSTitledLine *line2 = [self.bollingerBandData objectAtIndex:1];
    
    if (line1 != NULL && line2 != NULL) {
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        //获取线条数据
        NSArray *line1Datas = line1.data;
        NSArray *line2Datas = line2.data;
        
        //判断Y轴的位置设置从左往右还是从右往左绘制
        if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
            //TODO:自左向右绘图未对应
            // 点线距离
            float lineLength = ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / self.displayNumber);
            //起始点
            startX = super.axisMarginLeft + lineLength / 2;
            //遍历并绘制线条
            for (NSUInteger j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                CCSLineData *line1Data = [line1Datas objectAtIndex:j];
                CCSLineData *line2Data = [line2Datas objectAtIndex:j];
                
                //获取终点Y坐标
                float valueY1 = ((1 - (line1Data.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                float valueY2 = ((1 - (line2Data.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                
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
            float lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
            //起始点
            startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft - lineLength / 2;
            
            //判断点的多少
            if ([line1Datas count] == 0 || [line2Datas count] == 0) {
                return;
            } else if ([line1Datas count] == 1 || [line2Datas count] == 1) {
                return;
            } else {
                //遍历并绘制线条
                for (NSUInteger j = 0; j < self.displayNumber; j++) {
                    NSUInteger index = self.displayFrom + self.displayNumber - 1 - j;
                    CCSLineData *line1Data = [line1Datas objectAtIndex:index];
                    CCSLineData *line2Data = [line2Datas objectAtIndex:index];
                    
                    //获取终点Y坐标
                    float valueY1 = ((1 - (line1Data.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                    float valueY2 = ((1 - (line2Data.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                    //绘制线条路径
                    if (index == self.displayFrom + self.displayNumber - 1) {
                        CGContextMoveToPoint(context, startX, valueY1);
                        CGContextAddLineToPoint(context, startX, valueY2);
                        CGContextMoveToPoint(context, startX, valueY1);
                        //                            } else if (j == self.displayFrom) {
                        //                                CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
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

}

- (void)drawData:(CGRect)rect {
    //调用父类的绘制方法
    [super drawData:rect];

    if (self.bollingerBandData != NULL) {
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
}

@end
