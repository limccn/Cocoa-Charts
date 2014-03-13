//
//  CCSBandAreaChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/14/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSBandAreaChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSBandAreaChart
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
}

- (void)drawData:(CGRect)rect {

    // 起始位置
    float startX;
    float lastY = 0;
    float lastX = 0;


    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);

    if (self.linesData != NULL) {
        //逐条输出MA线
        for (NSInteger i = [self.linesData count] - 1; i >= 0; i--) {
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
                    float lineLength = ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / ([line.data count] - 1));
                    //起始点
                    startX = super.axisMarginLeft;
                    //遍历并绘制线条
                    for (NSUInteger j = 0; j < [lineDatas count]; j++) {
                        CCSLineData *lineData = [lineDatas objectAtIndex:j];
                        //获取终点Y坐标
                        float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
                    float lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([line.data count] - 1));
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
                        float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);

                        CGContextMoveToPoint(context, startX, valueY);
                        CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);

                    } else {
                        //遍历并绘制线条
                        for (NSInteger j = [lineDatas count] - 1; j >= 0; j--) {
                            CCSLineData *lineData = [lineDatas objectAtIndex:j];
                            //获取终点Y坐标
                            float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                            //绘制线条路径
                            if (j == [lineDatas count] - 1) {
                                CGContextMoveToPoint(context, startX, valueY);
                            } else if (j == 0) {
                                CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
                            } else {
                                CGContextAddLineToPoint(context, startX, valueY);
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

        CCSTitledLine *line1 = [self.linesData objectAtIndex:0];
        CCSTitledLine *line2 = [self.linesData objectAtIndex:1];


        if (line1 != NULL && line2 != NULL) {
            //设置线条颜色
            CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
            //获取线条数据
            NSArray *line1Datas = line1.data;
            NSArray *line2Datas = line2.data;

            //判断Y轴的位置设置从左往右还是从右往左绘制
            if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
                //TODO:自左向右绘图未对应
                // 点线距离
                float lineLength = ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / ([line1.data count] - 1));
                //起始点
                startX = super.axisMarginLeft;
                //遍历并绘制线条
                for (NSUInteger j = 0; j < [line1Datas count]; j++) {
                    CCSLineData *line1Data = [line1Datas objectAtIndex:j];
                    CCSLineData *line2Data = [line2Datas objectAtIndex:j];

                    //获取终点Y坐标
                    float valueY1 = ((1 - (line1Data.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                    float valueY2 = ((1 - (line2Data.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);

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

//                    // 点线距离
//                    float lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([line.data count]-1));
//                    //起始点
//                    startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft;
//                    
//                    //判断点的多少
//                    if ([lineDatas count] == 0) {
//                        //0根则返回
//                        return;
//                    } else if ([lineDatas count] == 1) {
//                        //1根则绘制一条直线
//                        CCSLineData *lineData = [lineDatas objectAtIndex:0];
//                        //获取终点Y坐标
//                        float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
//                        
//                        CGContextMoveToPoint(context, startX, valueY);
//                        CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
//                        
//                    } else {
//                        //遍历并绘制线条
//                        for (NSInteger j = [lineDatas count] - 1; j >= 0; j--) {
//                            CCSLineData *lineData = [lineDatas objectAtIndex:j];
//                            //获取终点Y坐标
//                            float valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
//                            //绘制线条路径
//                            if (j == [lineDatas count] - 1) {
//                                CGContextMoveToPoint(context, startX, valueY);
//                            } else if (j == 0) {
//                                CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
//                            } else {
//                                CGContextAddLineToPoint(context, startX, valueY);
//                            }
//                            
//                            lastY = valueY;
//                            //X位移
//                            startX = startX - lineLength;
//                        }
//                    }
            }
            CGContextClosePath(context);
            CGContextSetAlpha(context, self.areaAlpha);
            CGContextSetFillColorWithColor(context, [UIColor yellowColor].CGColor);
            CGContextFillPath(context);

        }

    }
}

@end
