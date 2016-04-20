//
//  CCSMACDChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSMACDChart.h"
#import "CCSMACDData.h"

@implementation CCSMACDChart

@synthesize macdDisplayType = _macdDisplayType;
@synthesize positiveStickStrokeColor = _positiveStickStrokeColor;
@synthesize negativeStickStrokeColor = _negativeStickStrokeColor;
@synthesize positiveStickFillColor = _positiveStickFillColor;
@synthesize negativeStickFillColor = _negativeStickFillColor;
@synthesize macdLineColor = _macdLineColor;
@synthesize deaLineColor = _deaLineColor;
@synthesize diffLineColor = _diffLineColor;


- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    //去除轴对称属性
    self.axisMarginTop = 0;
    self.axisCalc = 1;

    //初始化颜色
    self.positiveStickStrokeColor = [UIColor redColor];
    self.negativeStickStrokeColor = [UIColor greenColor];
    self.positiveStickFillColor = [UIColor clearColor];
    self.negativeStickFillColor = [UIColor greenColor];
    self.macdLineColor = [UIColor blueColor];
    self.deaLineColor = [UIColor yellowColor];
    self.diffLineColor = [UIColor cyanColor];
    
    self.macdDisplayType = CCSMACDChartDisplayTypeStick;
    
    self.displayCrossXOnTouch = NO;
    self.displayCrossYOnTouch = NO;

}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)calcValueRange {
    if (self.displayNumber <= 0) {
        return;
    }
    if (self.stickData != NULL && [self.stickData count] > 0) {

        CCFloat maxValue = 0;
        CCFloat minValue = 0;

//        CCSMACDData *first = [self.stickData objectAtIndex:self.displayFrom];
//        maxValue = MAX(first.dea, MAX(first.diff, first.macd));
//        minValue = MIN(first.dea, MIN(first.diff, first.macd));

        //判断显示为方柱或显示为线条
        for (CCUInt i = self.displayFrom; i < [self getDisplayTo]; i++) {
            CCSMACDData *stick = [self.stickData objectAtIndex:i];
            if ([self isNoneDisplayValue:stick.dea] && stick.dea == stick.diff) {
                //pass
            }else{
                maxValue = MAX(maxValue, MAX(stick.dea, MAX(stick.diff, stick.macd)));
                minValue = MIN(minValue, MIN(stick.dea, MIN(stick.diff, stick.macd)));
            }
        }

        self.maxValue = MAX(fabs(maxValue),fabs(minValue));
        self.minValue = -MAX(fabs(maxValue),fabs(minValue));

    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }
    
    if(self.maxValue < self.minValue){
        self.minValue = 0;
        self.maxValue = 0;
    }
}

-(void) drawData:(CGRect)rect{
//    [super drawData:rect];
    //绘制数据
    [self drawSticks:rect];
    
    //在K线图上增加均线
    [self drawLinesData:rect];
}

- (void)drawSticks:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);

    if (self.stickData != NULL && [self.stickData count] > 0) {

//        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            // 蜡烛棒宽度
            CCFloat stickWidth = [self getDataStickWidth] - 0.5;
            
            // 蜡烛棒起始绘制位置
            CCFloat stickX = self.axisMarginLeft + 1;
            //判断显示为方柱或显示为线条
            for (CCUInt i = self.displayFrom; i < [self getDisplayTo]; i++) {
                CCSMACDData *stick = [self.stickData objectAtIndex:i];

                CCFloat highY = [self computeValueY:stick.macd inRect:rect];
                CCFloat lowY = [self computeValueY:0 inRect:rect];

                if ([self isNoneDisplayValue:stick.macd]) {
                    //没有值的情况下不绘制
                } else {

                    //柱状线颜色设定
                    if (stick.macd > 0) {
                        CGContextSetStrokeColorWithColor(context, self.positiveStickStrokeColor.CGColor);
                        CGContextSetFillColorWithColor(context, self.positiveStickFillColor.CGColor);
                    } else {
                        CGContextSetStrokeColorWithColor(context, self.negativeStickStrokeColor.CGColor);
                        CGContextSetFillColorWithColor(context, self.negativeStickFillColor.CGColor);
                    }

                    if (self.macdDisplayType == CCSMACDChartDisplayTypeStick) {
                        //绘制数据，根据宽度判断绘制直线或方柱
                        if (stickWidth >= 2) {
                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                            //填充路径
                            CGContextStrokePath(context);
                            
                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                            //填充路径
                            CGContextFillPath(context);
                        } else {
                            CGContextMoveToPoint(context, stickX, highY);
                            CGContextAddLineToPoint(context, stickX, lowY);
                            //绘制线条
                            CGContextStrokePath(context);
                        }
                    } else if (self.macdDisplayType == CCSMACDChartDisplayTypeLineStick) {
                        CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                        CGContextAddLineToPoint(context, stickX + stickWidth / 2, lowY);
                        //绘制线条
                        CGContextStrokePath(context);
                    } else {
                        //绘制线条
                        if (i == self.displayFrom) {
                            CGContextMoveToPoint(context, stickX + stickWidth / 2, highY);
                        } else if (i == [self getDisplayTo] - 1) {
                            CGContextAddLineToPoint(context, stickX + stickWidth / 2, highY);
                            CGContextSetStrokeColorWithColor(context, self.macdLineColor.CGColor);
                            CGContextStrokePath(context);
                        } else {
                            CGContextAddLineToPoint(context, stickX + stickWidth / 2, highY);
                        }
                    }
                }

                //X位移
                stickX = stickX + 0.5 + stickWidth;
            }
//        } else {
//            CCFloat stickWidth = [self getDataStickWidth] - 0.5;
//            // 蜡烛棒起始绘制位置
//            CCFloat stickX = rect.size.width - self.axisMarginRight - 1 - stickWidth;
//            //判断显示为方柱或显示为线条
//            for (CCUInt i = 0; i < self.displayNumber; i++) {
//                CCUInt index = [self getDisplayTo] - 1 - i;
//                CCSMACDData *stick = [self.stickData objectAtIndex:index];
//
//                CCFloat highY = [self computeValueY:stick.macd inRect:rect];
//                CCFloat lowY = [self computeValueY:0 inRect:rect];
//                
//
//                if ([self isNoneDisplayValue:stick.macd]) {
//                    //没有值的情况下不绘制
//                } else {
//
//                    //柱状线颜色设定
//                    if (stick.macd > 0) {
//                        CGContextSetStrokeColorWithColor(context, self.positiveStickStrokeColor.CGColor);
//                        CGContextSetFillColorWithColor(context, self.positiveStickFillColor.CGColor);
//                    } else {
//                        CGContextSetStrokeColorWithColor(context, self.negativeStickStrokeColor.CGColor);
//                        CGContextSetFillColorWithColor(context, self.negativeStickFillColor.CGColor);
//                    }
//
//                    if (self.macdDisplayType == CCSMACDChartDisplayTypeStick) {
//                        //绘制数据，根据宽度判断绘制直线或方柱
//                        if (stickWidth >= 1) {
//                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
//                            //填充路径
//                            CGContextStrokePath(context);
//                            
//                            CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
//                            //填充路径
//                            CGContextFillPath(context);
//                        } else {
//                            CGContextMoveToPoint(context, stickX, highY);
//                            CGContextAddLineToPoint(context, stickX, lowY);
//                            //绘制线条
//                            CGContextStrokePath(context);
//                        }
//                    } else if (self.macdDisplayType == CCSMACDChartDisplayTypeLineStick) {
//                        CGContextMoveToPoint(context, stickX - stickWidth / 2, highY);
//                        CGContextAddLineToPoint(context, stickX - stickWidth / 2, lowY);
//                        //绘制线条
//                        CGContextStrokePath(context);
//                    } else {
//                        //绘制线条
//                        if (index == [self getDisplayTo] - 1) {
//                            CGContextMoveToPoint(context, stickX - stickWidth / 2, highY);
//                        } else if (index == 0) {
//                            CGContextAddLineToPoint(context, stickX - stickWidth / 2, highY);
//                            CGContextSetStrokeColorWithColor(context, self.macdLineColor.CGColor);
//                            CGContextStrokePath(context);
//                        } else {
//                            CGContextAddLineToPoint(context, stickX - stickWidth / 2, highY);
//                        }
//                    }
//
//                }
//                //X位移
//                stickX = stickX - 0.5 - stickWidth;
//            }
//        }
    }
}

- (void)drawLinesData:(CGRect)rect {

    // 起始位置
    CCFloat startX;
//    CCFloat lastY = 0;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);

    if (self.stickData != NULL) {
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, self.deaLineColor.CGColor);
        
        // 点线距离
        CCFloat lineLength;
        CGPoint ptFirst;
        
        lineLength = [self getDataStickWidth];

        //起始点
        startX = super.axisMarginLeft + lineLength / 2;

//        //判断点的多少
//        if ([self.stickData count] == 0) {
//            //0根则返回
//            return;
//        } else if ([self.stickData count] == 1) {
//            //1根则绘制一条直线
//            CCSMACDData *lineData = [self.stickData objectAtIndex:0];
//            //获取终点Y坐标
//            CCFloat valueY  = [self computeValueY:lineData.dea inRect:rect];
//
//            CGContextMoveToPoint(context, startX, valueY);
//            CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
//
//        } else {
//            //遍历并绘制线条
//            for (CCInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
//                CCSMACDData *lineData = [self.stickData objectAtIndex:j];
//                CCFloat valueY  = [self computeValueY:lineData.dea inRect:rect];
//                
//                if (lineData.dea == lineData.diff && lineData.dea == 0) {
//                }else{
//                    //绘制线条路径
//                    if (j == self.displayFrom || j == 0) {
//                        if (lineData.dea == 0) {
//                            //DO NOTHING
//                        }else{
//                            CGContextMoveToPoint(context, startX, valueY);
//                            lastY = valueY;
//                        }
//                    }else {
//                        CCSMACDData *preLineData = [self.stickData objectAtIndex:j - 1];
//                        if (lineData.dea == 0) {
//                            CGContextMoveToPoint(context, startX, lastY);
//                        } else {
//                            if (preLineData.dea == 0) {
//                                CGContextMoveToPoint(context, startX, valueY);
//                                CGContextAddLineToPoint(context, startX, valueY);
//                                lastY = valueY;
//                            }else {
//                                CGContextAddLineToPoint(context, startX, valueY);
//                                lastY = valueY;
//                            }
//                        }
//                    }
//                }
//                //X位移
//                startX = startX + lineLength;
//            }
        
            ptFirst =  CGPointMake(-1, -1);
            //遍历并绘制线条
            for (CCUInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
                CCSMACDData *lineData = [self.stickData objectAtIndex:j];
                
                if ([self isNoneDisplayValue:lineData.dea] && lineData.dea == lineData.diff ) {
                    //跳过
                }else{
                    CCFloat valueY = [self computeValueY:lineData.dea inRect:rect];
                    if (j > self.displayFrom && ptFirst.x > 0 && ptFirst.y >0) {
                        CGContextMoveToPoint(context, ptFirst.x, ptFirst.y);
                        CGContextAddLineToPoint(context, startX, valueY);
                    }
                    
                    ptFirst =  CGPointMake(startX, valueY);
                }
                //X位移
                startX = startX + lineLength;
            }
//        }
        //绘制路径
        CGContextStrokePath(context);


        //绘制diff曲线
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, self.diffLineColor.CGColor);

        //起始点
        //startX = self.axisMarginLeft + 1;
        //起始点
        startX = super.axisMarginLeft + lineLength / 2;

//        //判断点的多少
//        if ([self.stickData count] == 0) {
//            //0根则返回
//            return;
//        } else if ([self.stickData count] == 1) {
//            //1根则绘制一条直线
//            CCSMACDData *lineData = [self.stickData objectAtIndex:0];
//            //获取终点Y坐标
//            CCFloat valueY  = [self computeValueY:lineData.diff inRect:rect];
//
//
//            CGContextMoveToPoint(context, startX, valueY);
//            CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
//
//        } else {
//            //遍历并绘制线条
//            for (CCInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
//                CCSMACDData *lineData = [self.stickData objectAtIndex:j];
//                CCFloat valueY  = [self computeValueY:lineData.diff inRect:rect];
//
//                if (lineData.dea == lineData.diff && lineData.dea == 0) {
//                }else{
////                    //绘制线条路径
////                    if (j == self.displayFrom || j == 0) {
////                        if (lineData.diff == 0) {
////                            //DO NOTHING
////                        }else{
////                            CGContextMoveToPoint(context, startX, valueY);
////                            lastY = valueY;
////                        }
////                    }else {
////                        CCSMACDData *preLineData = [self.stickData objectAtIndex:j - 1];
////                        if (lineData.diff == 0) {
////                            CGContextMoveToPoint(context, startX, lastY);
////                        } else {
////                            if (preLineData.diff == 0) {
////                                CGContextMoveToPoint(context, startX, valueY);
////                                CGContextAddLineToPoint(context, startX, valueY);
////                                lastY = valueY;
////                            }else {
////                                CGContextAddLineToPoint(context, startX, valueY);
////                                lastY = valueY;
////                            }
////                        }
////                    }
//                    
//                    
//                }
//                //X位移
//                startX = startX + lineLength;
//            }
        
            ptFirst =  CGPointMake(-1, -1);
            //遍历并绘制线条
            for (CCUInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
                CCSMACDData *lineData = [self.stickData objectAtIndex:j];
                
                if ([self isNoneDisplayValue:lineData.diff] && lineData.dea == lineData.diff ) {
                    //跳过
                }else{
                    CCFloat valueY = [self computeValueY:lineData.diff inRect:rect];
                    if (j > self.displayFrom && ptFirst.x > 0 && ptFirst.y >0) {
                        CGContextMoveToPoint(context, ptFirst.x, ptFirst.y);
                        CGContextAddLineToPoint(context, startX, valueY);
                    }
                    
                    ptFirst =  CGPointMake(startX, valueY);
                }
                //X位移
                startX = startX + lineLength;
            }
        //绘制路径
        CGContextStrokePath(context);
    }
}

@end
