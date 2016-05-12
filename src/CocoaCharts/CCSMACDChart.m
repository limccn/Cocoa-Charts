//
//  CCSMACDChart.m
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
        //绘制路径
        CGContextStrokePath(context);


        //绘制diff曲线
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, self.diffLineColor.CGColor);

        //起始点
        startX = super.axisMarginLeft + lineLength / 2;
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

- (void)initAxisY {
    if (self.autoCalcLatitudeTitle == NO) {
        return;
    }
    //计算取值范围
    if ([self autoCalcRange]) {
        [self calcValueRange];
    }

    if (self.maxValue == 0. && self.minValue == 0.) {
        self.latitudeTitles = nil;
        return;
    }
    
    NSMutableArray *TitleY = [[NSMutableArray alloc] init];
    CCFloat average = (self.maxValue - self.minValue) / self.latitudeNum;
    
    //处理刻度
    for (CCUInt i = 0; i < self.latitudeNum; i++) {
        CCFloat degree =  self.minValue + i * average;
        NSString *value = [self formatAxisYDegree:degree];
        [TitleY addObject:value];
    }
    
    CCFloat degree =  self.maxValue;
    NSString *value = [self formatAxisYDegree:degree];
    [TitleY addObject:value];
    
    self.latitudeTitles = TitleY;
}

-(NSString*) formatAxisYDegree:(CCFloat)value {
    //数据
    CCFloat displayValue = value/ self.axisCalc;
    return [NSString stringWithFormat:@"%-.2f", displayValue];
}

@end
