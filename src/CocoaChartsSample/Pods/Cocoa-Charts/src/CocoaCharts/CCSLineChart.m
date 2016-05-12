//
//  CCSLineChart.m
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

#import "CCSLineChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSLineChart

@synthesize linesData = _linesData;
@synthesize selectedIndex = _selectedIndex;
@synthesize lineWidth = _lineWidth;
@synthesize maxValue = _maxValue;
@synthesize minValue = _minValue;
@synthesize axisCalc = _axisCalc;
@synthesize autoCalcRange = _autoCalcRange;
@synthesize balanceRange = _balanceRange;
@synthesize lineAlignType = _lineAlignType;

- (void)initProperty {

    [super initProperty];

    self.maxValue = CCIntMin;
    self.minValue = CCIntMax;
    self.selectedIndex = 0;
    self.lineWidth = 1.0f;
    self.axisCalc = 1;
    self.lineAlignType = CCSLineAlignTypeJustify;

    self.linesData = nil;
    self.autoCalcRange = YES;
    self.balanceRange = NO;
    
    self.displayCrossXOnTouch = NO;
    self.displayCrossYOnTouch = NO;
}


- (void)calcDataValueRange
{
    CCFloat maxValue = 0;
    CCFloat minValue = CCIntMax;
    //逐条输出MA线
    for (CCUInt i = 0; i < [self.linesData count]; i++) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        if (line != NULL && [line.data count] > 0) {
            //判断显示为方柱或显示为线条
            for (CCUInt j = 0; j < [line.data count]; j++) {
                CCSLineData *lineData = [line.data objectAtIndex:j];
                if (lineData.value < minValue) {
                    minValue = lineData.value;
                }
                
                if (lineData.value > maxValue) {
                    maxValue = lineData.value;
                }
                
            }
        }
    }
    
    self.maxValue = maxValue;
    self.minValue = minValue;
}

- (void)calcValueRangePaddingZero
{
    CCFloat maxValue = self.maxValue;
    CCFloat minValue = self.minValue;
    
    if ((CCInt) maxValue > (CCInt) minValue) {
        if ((maxValue - minValue) < 10. && minValue > 1.) {
            self.maxValue = (CCInt) (maxValue + 1);
            self.minValue = (CCInt) (minValue - 1);
        } else {
            self.maxValue = (CCInt) (maxValue + (maxValue - minValue) * 0.1);
            self.minValue = (CCInt) (minValue - (maxValue - minValue) * 0.1);
            
            if (self.minValue < 0) {
                self.minValue = 0;
            }
        }
    } else if ((CCInt) maxValue == (CCInt) minValue) {
        if (maxValue <= 10 && maxValue > 1) {
            self.maxValue = maxValue + 1;
            self.minValue = minValue - 1;
        } else if (maxValue <= 100 && maxValue > 10) {
            self.maxValue = maxValue + 10;
            self.minValue = minValue - 10;
        } else if (maxValue <= 1000 && maxValue > 100) {
            self.maxValue = maxValue + 100;
            self.minValue = minValue - 100;
        } else if (maxValue <= 10000 && maxValue > 1000) {
            self.maxValue = maxValue + 1000;
            self.minValue = minValue - 1000;
        } else if (maxValue <= 100000 && maxValue > 10000) {
            self.maxValue = maxValue + 10000;
            self.minValue = minValue - 10000;
        } else if (maxValue <= 1000000 && maxValue > 100000) {
            self.maxValue = maxValue + 100000;
            self.minValue = minValue - 100000;
        } else if (maxValue <= 10000000 && maxValue > 1000000) {
            self.maxValue = maxValue + 1000000;
            self.minValue = minValue - 1000000;
        } else if (maxValue <= 100000000 && maxValue > 10000000) {
            self.maxValue = maxValue + 10000000;
            self.minValue = minValue - 10000000;
        }
    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }
}

- (void)calcValueRangeFormatForAxis
{
    CCInt rate = 1;
    
    if (self.maxValue < 3000) {
        rate = 1;
    } else if (self.maxValue >= 3000 && self.maxValue < 5000) {
        rate = 5;
    } else if (self.maxValue >= 5000 && self.maxValue < 30000) {
        rate = 10;
    } else if (self.maxValue >= 30000 && self.maxValue < 50000) {
        rate = 50;
    } else if (self.maxValue >= 50000 && self.maxValue < 300000) {
        rate = 100;
    } else if (self.maxValue >= 300000 && self.maxValue < 500000) {
        rate = 500;
    } else if (self.maxValue >= 500000 && self.maxValue < 3000000) {
        rate = 1000;
    } else if (self.maxValue >= 3000000 && self.maxValue < 5000000) {
        rate = 5000;
    } else if (self.maxValue >= 5000000 && self.maxValue < 30000000) {
        rate = 10000;
    } else if (self.maxValue >= 30000000 && self.maxValue < 50000000) {
        rate = 50000;
    } else {
        rate = 100000;
    }
    
    //等分轴修正
    if (self.latitudeNum > 0 && rate > 1 && (CCInt) (self.minValue) % rate != 0) {
        //最大值加上轴差
        self.minValue = (CCInt) self.minValue - ((CCInt) (self.minValue) % rate);
    }
    //等分轴修正
    if (self.latitudeNum > 0 && (CCInt) (self.maxValue - self.minValue) % (self.latitudeNum * rate) != 0) {
        //最大值加上轴差
        self.maxValue = (CCInt) self.maxValue + (self.latitudeNum * rate) - ((CCInt) (self.maxValue - self.minValue) % (self.latitudeNum * rate));
    }
}

- (void) calcBalanceRange{
    self.maxValue = MAX(fabs(self.maxValue),fabs(self.minValue));
    self.minValue = -MAX(fabs(self.maxValue),fabs(self.minValue));
}

- (void)calcValueRange {
    if (self.linesData != NULL && [self.linesData count] > 0) {
        [self calcDataValueRange];
        [self calcValueRangePaddingZero];
    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }
    
    [self calcValueRangeFormatForAxis];
    
    if (self.balanceRange) {
        [self calcBalanceRange];
    }
}

-(void) drawData:(CGRect)rect{
    [super drawData:rect];
    //绘制数据
    [self drawLines:rect];
}

- (void)drawRect:(CGRect)rect {

    //初始化XY轴
    [self initAxisY];
    [self initAxisX];

    [super drawRect:rect];

}

- (void)drawLines:(CGRect)rect {

    // 起始位置
    CCFloat startX = 0;
    CCFloat lastY = 0;
    CCFloat lineLength = 0;

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //linesData为空
    if (self.linesData == NULL){
        return;
    }

    //逐条输出
    for (CCUInt i = 0; i < [self.linesData count]; i++) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        //line为空
        if (line == NULL) {
            continue;
        }
        
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, line.color.CGColor);
        //获取线条数据
        NSArray *lineDatas = line.data;
        
        //判断Y轴的位置设置从左往右还是从右往左绘制
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            
            if (self.lineAlignType == CCSLineAlignTypeCenter) {
                // 点线距离
                lineLength= ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / [line.data count]);
                //起始点
                startX = super.axisMarginLeft + lineLength / 2;
            }else if (self.lineAlignType == CCSLineAlignTypeJustify) {
                // 点线距离
                lineLength= ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / ([line.data count] - 1));
                //起始点
                startX = super.axisMarginLeft + self.axisMarginRight;
            }
            
            
            //遍历并绘制线条
            for (CCUInt j = 0; j < [lineDatas count]; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                //绘制线条路径
                if (j == 0) {
                    CGContextMoveToPoint(context, startX, valueY);
                    lastY = valueY;
                } else {
                    if (lineData.value == 0) {
                        CGContextMoveToPoint(context, startX, lastY);
                    } else {
                        CGContextAddLineToPoint(context, startX, valueY);
                        lastY = valueY;
                    }
                }
                //X位移
                startX = startX + lineLength;
            }
        } else {
            
            if (self.lineAlignType == CCSLineAlignTypeCenter) {
                // 点线距离
                lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / [line.data count] - 1);
                //起始点
                startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft - lineLength / 2;
            }else if (self.lineAlignType == CCSLineAlignTypeJustify) {
                // 点线距离
                lineLength= ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / [line.data count]);
                //起始点
                startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft;
            }

            //判断点的多少
            if ([lineDatas count] == 0) {
                //0根则返回
                return;
            } else if ([lineDatas count] == 1) {
                //1根则绘制一条直线
                CCSLineData *lineData = [lineDatas objectAtIndex:0];
                //获取终点Y坐标
                CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);

                CGContextMoveToPoint(context, startX, valueY);
                CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);

            } else {
                //遍历并绘制线条
                for (CCInt j = [lineDatas count] - 1; j >= 0; j--) {
                    CCSLineData *lineData = [lineDatas objectAtIndex:j];
                    //获取终点Y坐标
                    CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
                    //绘制线条路径
                    if (j == [lineDatas count] - 1) {
                        CGContextMoveToPoint(context, startX, valueY);
                        lastY = valueY;
                    } else if (j == 0) {
                        if (lineData.value == 0) {
                            CGContextAddLineToPoint(context, self.axisMarginLeft, lastY);
                        } else {
                            CGContextAddLineToPoint(context, self.axisMarginLeft, valueY);
                            lastY = valueY;
                        }
                    } else {
                        if (lineData.value == 0) {
                            CGContextMoveToPoint(context, startX, lastY);
                        } else {
                            CGContextAddLineToPoint(context, startX, valueY);
                            lastY = valueY;
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

- (void)drawLongitudeLines:(CGRect)rect {
    if (self.lineAlignType == CCSLineAlignTypeJustify) {
        [super drawLongitudeLines:rect];
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.longitudeFontColor.CGColor);
    
    if (self.displayLongitude == NO) {
        return;
    }
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    //设置线条为点线
    if (self.dashLongitude) {
        CGFloat lengths[] = {3.0, 3.0};
        CGContextSetLineDash(context, 0.0, lengths, 2);
    }
    CCFloat postOffset;
    CCFloat offset;
    
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count]);
        offset = self.axisMarginLeft + self.axisMarginRight + postOffset / 2;
    }
    else {
        postOffset = (rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count]);
        offset = self.axisMarginLeft;
    }
    
    for (CCUInt i = 0; i < [self.longitudeTitles count]; i++) {
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            CGContextMoveToPoint(context, offset + i * postOffset, 0);
            CGContextAddLineToPoint(context, offset + i * postOffset, rect.size.height - self.axisMarginBottom);
        } else {
            CGContextMoveToPoint(context, offset + i * postOffset, self.axisMarginTop);
            CGContextAddLineToPoint(context, offset + i * postOffset, rect.size.height);
        }
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawXAxisTitles:(CGRect)rect {
    if (self.lineAlignType == CCSLineAlignTypeJustify) {
        [super drawXAxisTitles:rect];
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.longitudeFontColor.CGColor);
    
    if (self.displayLongitude == NO) {
        return;
    }
    
    if (self.displayLongitudeTitle == NO) {
        return;
    }
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CCFloat postOffset;
    CCFloat offset;
    
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count]);
        offset = self.axisMarginLeft + self.axisMarginRight + postOffset / 2;
    } else {
        postOffset = (rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count]);
        offset = self.axisMarginLeft;
    }
    
    for (CCUInt i = 0; i < [self.longitudeTitles count]; i++) {
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:i];
            //调整X轴坐标位置
            
            CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, rect.size.height - self.axisMarginBottom, postOffset, self.longitudeFontSize);
            UIFont *textFont= self.longitudeFont; //设置字体
            NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
            textStyle.alignment=NSTextAlignmentCenter;
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            //绘制字体
            [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
            
        } else {
            NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:i];
            
            //调整X轴坐标位置
            CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, 0, postOffset, self.longitudeFontSize);
            UIFont *textFont= self.longitudeFont; //设置字体
            NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
            textStyle.alignment=NSTextAlignmentCenter;
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            //绘制字体
            [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
        }
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
    CCFloat average = (CCUInt) ((self.maxValue - self.minValue) / self.latitudeNum);
    //处理刻度
    for (CCUInt i = 0; i < self.latitudeNum; i++) {
        if (self.axisCalc == 1) {
            CCUInt degree = floor(self.minValue + i * average) / self.axisCalc;
            NSString *value = [[NSNumber numberWithInteger:degree]stringValue];
            [TitleY addObject:value];
        } else {
            NSString *value = [NSString stringWithFormat:@"%-.2f", floor(self.minValue + i * average) / self.axisCalc];
            [TitleY addObject:value];
        }
    }
    //处理最大值
    if (self.axisCalc == 1) {
        CCUInt degree = (CCInt) (self.maxValue) / self.axisCalc;
        NSString *value = [[NSNumber numberWithInteger:degree]stringValue];
        [TitleY addObject:value];
    }
    else {
        NSString *value = [NSString stringWithFormat:@"%-.2f", (self.maxValue) / self.axisCalc];
        [TitleY addObject:value];
    }

    self.latitudeTitles = TitleY;
}


- (void)initAxisX {
    if (self.autoCalcLongitudeTitle == NO) {
        return;
    }
    
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.linesData != NULL && [self.linesData count] > 0) {
        //以第1条线作为X轴的标示
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if ([line.data count] > 0) {
            CCFloat average = [line.data count] / self.longitudeNum;
            //处理刻度
            for (CCUInt i = 0; i < self.longitudeNum; i++) {
                CCUInt index = (CCUInt) floor(i * average);
                if (index >= [line.data count] - 1) {
                    index = [line.data count] - 1;
                }
                CCSLineData *lineData = [line.data objectAtIndex:index];
                //追加标题
                [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
            }
            CCSLineData *lineData = [line.data objectAtIndex:[line.data count] - 1];
            //追加标题
            [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
        }
    }
    self.longitudeTitles = TitleX;
}

- (NSString *)calcAxisXGraduate:(CGRect)rect {
    CCFloat value = [self touchPointAxisXValue:rect];
    NSString *result = @"";
    if (self.linesData != NULL) {
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if (line != NULL && [line.data count] > 0) {
            if (value >= 1) {
                result = ((CCSLineData *) [line.data objectAtIndex:[line.data count] - 1]).date;
            } else if (value <= 0) {
                result = ((CCSLineData *) [line.data objectAtIndex:0]).date;
            } else {
                CCUInt index = (CCUInt) round([line.data count] * value);

                if (index < [line.data count]) {
                    self.displayCrossXOnTouch = YES;
                    self.displayCrossYOnTouch = YES;
                    result = ((CCSLineData *) [line.data objectAtIndex:index]).date;
                } else {
                    self.displayCrossXOnTouch = NO;
                    self.displayCrossYOnTouch = NO;
                }
            }
        }
    }
    return result;
}

- (NSString *)calcAxisYGraduate:(CGRect)rect {
    CCFloat value = [self touchPointAxisYValue:rect];
    if (self.maxValue == 0. && self.minValue == 0.) {
        return @"";
    }
    if (self.axisCalc == 1) {
        CCInt degree = (value * (self.maxValue - self.minValue) + self.minValue) / self.axisCalc;
        return [[NSNumber numberWithInteger:degree]stringValue];
    } else {
        return [NSString stringWithFormat:@"%-.2f", (value * (self.maxValue - self.minValue) + self.minValue) / self.axisCalc];
    }
}

- (void) setLinesData:(NSArray *)linesData
{
    _linesData = linesData;
    
    self.maxValue = CCIntMin;
    self.minValue = CCIntMax;
}

-(void) calcSelectedIndex{
     // noop
}

-(void) bindSelectedIndex{
    // noop
}

- (void)setSelectedPointAddReDraw:(CGPoint)point {
    point.y = 1;
    self.singleTouchPoint = point;
    [self calcSelectedIndex];
    
    [self setNeedsDisplay];
}


- (void) setSingleTouchPoint:(CGPoint) point
{
    _singleTouchPoint = point;
    // 计算选中Index
    [self calcSelectedIndex];
    // 绑定选中index
    [self bindSelectedIndex];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //父类的点击事件
    [super touchesBegan:touches withEvent:event];
    //计算选中的索引
    [self calcSelectedIndex];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesMoved:touches withEvent:event];
    //计算选中的索引
    [self calcSelectedIndex];
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        // noop
    } else if ([allTouches count] == 2) {
        // noop
    } else {
        // noop
    }
    
}

-(CCFloat) computeValueY:(CCFloat)value inRect:(CGRect)rect{
    return (1 - (value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom - 2 * self.axisMarginTop) + self.axisMarginTop;
}

@end
