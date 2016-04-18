//
//  CCSMASlipCandleStickChart.m
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

#import "CCSMASlipCandleStickChart.h"
#import "CCSLineData.h"
#import "CCSTitledLine.h"

@implementation CCSMASlipCandleStickChart

@synthesize linesData = _linesData;

- (void)initProperty {

    [super initProperty];
    //初始化颜色
    self.linesData = nil;
}

- (void)calcDataValueRange {
    if (self.displayNumber <= 0) {
        return;
    }
    //调用父类
    [super calcDataValueRange];
    
    CCFloat maxValue = 0;
    CCFloat minValue = CCIntMax;
    
    for (CCInt i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
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

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
}

//- (void)drawData:(CGRect)rect {
//    //调用父类的绘制方法
//    [super drawData:rect];
//
//    
//}
-(void) drawData:(CGRect)rect{
    [super drawData:rect];
    if (self.displayNumber > self.maxDisplayNumberToLine) {
    }else{
        //在K线图上增加均线
        [self drawLinesData:rect];
    }
}


- (void)drawLinesData:(CGRect)rect {
    //起始点
    CCFloat lineLength;
    // 起始位置
    CCFloat startX;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);

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
                    // 点线距离
                    lineLength = [self getDataStickWidth];
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
                }
                //绘制路径
                CGContextStrokePath(context);
            }
        }
    }
}

@end
