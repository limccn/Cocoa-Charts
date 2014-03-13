//
//  CCSAreaChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/13/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSAreaChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSAreaChart
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

- (void)drawData:(CGRect)rect {

    // 起始位置
    float startX;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);

    if (self.linesData != NULL) {
        //逐条输出MA线
        for (NSUInteger i = 0; i < [self.linesData count]; i++) {
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
