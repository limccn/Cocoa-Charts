//
//  CCSBOLLMASlipCandleStickChart.m
//  Cocoa-Charts
//
//  Created by limc on 13-10-27.
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


- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    //去除轴对称属性
    self.bollingerBandAlpha = 0.1;
    self.bollingerBandColor = [UIColor yellowColor];
    self.bollingerBandStyle = CCSBollingerBandStyleLane;
}


- (void)calcDataValueRange {
    if (self.displayNumber <= 0) {
        return;
    }
    //调用父类
    [super calcDataValueRange];

    CCFloat maxValue = 0;
    CCFloat minValue = CCIntMax;

    for (CCInt i = [self.bollingerBandData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.bollingerBandData objectAtIndex:i];
        //获取线条数据
        NSArray *lineDatas = line.data;
        for (CCUInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
            CCSLineData *lineData = [lineDatas objectAtIndex:j];
            
            //忽略不显示值的情况
            if ([self isNoneDisplayValue:lineData.value]) {
                
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

- (void)initAxisY {
    //调用父类的initAxisY方法
    [super initAxisY];
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
        
        if (line != NULL) {
            //设置线条颜色
            CGContextSetStrokeColorWithColor(context, line.color.CGColor);
            //获取线条数据
            NSArray *lineDatas = line.data;
                // 点线距离
                CCFloat lineLength = [self getDataStickWidth];
                //起始点
                startX = super.axisMarginLeft + lineLength / 2;
                CGPoint ptFirst =  CGPointMake(-1, -1);
                //遍历并绘制线条
                for (CCUInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
                    CCSLineData *lineData = [lineDatas objectAtIndex:j];
                    
                    if ([self isNoneDisplayValue:lineData.value]) {
                        //跳过
                    }else{
                        CCFloat valueY = [self computeValueY:lineData.value inRect:rect];
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
    
    if (line1 != NULL && line2 != NULL) {
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);
        //获取线条数据
        NSArray *line1Datas = line1.data;
        NSArray *line2Datas = line2.data;
        
        //判断Y轴的位置设置从左往右还是从右往左绘制
        // 点线距离
        CCFloat lineLength = [self getDataStickWidth];
        //起始点
        startX = super.axisMarginLeft + lineLength / 2;
        //遍历并绘制线条
        for (CCUInt j = self.displayFrom; j < [self getDisplayTo]; j++) {
            CCSLineData *line1Data = [line1Datas objectAtIndex:j];
            CCSLineData *line2Data = [line2Datas objectAtIndex:j];
            
            //获取终点Y坐标
            CCFloat valueY1 = [self computeValueY:line1Data.value inRect:rect];
            CCFloat valueY2 = [self computeValueY:line2Data.value inRect:rect];
            
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
        CGContextClosePath(context);
        CGContextSetAlpha(context, self.bollingerBandAlpha);
        CGContextSetFillColorWithColor(context, self.bollingerBandColor.CGColor);
        CGContextFillPath(context);
        CGContextSetAlpha(context, 1);
    }

}

- (void)drawData:(CGRect)rect {
    //调用父类的绘制方法
    [super drawData:rect];
    
    
    if (self.displayNumber > self.maxDisplayNumberToLine) {
    }else{
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
}

@end
