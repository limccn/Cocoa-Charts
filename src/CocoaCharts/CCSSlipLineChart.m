//
//  CCSSlipLineChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/6/13.
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

#import "CCSSlipLineChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@interface CCSSlipLineChart () {
    CCFloat _startDistance1;
    CCFloat _minDistance1;
    CCInt _flag;
    CCFloat _firstX;
}
@end

@implementation CCSSlipLineChart
@synthesize displayNumber = _displayNumber;
@synthesize displayFrom = _displayFrom;
@synthesize minDisplayNumber = _minDisplayNumber;
@synthesize zoomBaseLine = _zoomBaseLine;
@synthesize noneDisplayValue = _noneDisplayValue;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _startDistance1 = 0;
        _minDistance1 = 8;
        _flag = 1;
        _firstX = 0;
    }
    return self;
}

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    
    self.displayFrom = 0;
    self.displayNumber = 10;
    self.minDisplayNumber = 20;
    self.zoomBaseLine = CCSLineZoomBaseLineCenter;
    self.noneDisplayValue = 0;
}


- (void)calcValueRange {
    //调用父类
    //[super calcDataValueRange];
    
    CCFloat maxValue = -CCIntMax;
    CCFloat minValue = CCIntMax;
    
    for (NSInteger i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        //获取线条数据
        NSArray *lineDatas = line.data;
        for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
            CCSLineData *lineData = [lineDatas objectAtIndex:j];
            
            //忽略不显示值的情况
            if (lineData.value - self.noneDisplayValue == 0) {
                
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
    
    //初始化XY轴
    [self initAxisY];
    [self initAxisX];
    
    
    [super drawRect:rect];
    
    //绘制数据
    [self drawData:rect];
}

- (void)drawData:(CGRect)rect {
    if (self.linesData == nil) {
        return;
    }
    
    if ([self.linesData count] == 0) {
        return;
    }
    // 起始位置
    CCFloat lineLength;
    CCFloat startX;
    CCFloat lastY = 0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //逐条输出MA线
    for (CCUInt i = 0; i < [self.linesData count]; i++) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        if (line== nil) {
            continue;
        }
        if ([line.data count] == 0) {
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
                lineLength= ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
                //起始点
                startX = [self dataQuadrantPaddingStartX:rect] + lineLength / 2;
            }else if (self.lineAlignType == CCSLineAlignTypeJustify) {
                // 点线距离
                lineLength= ([self dataQuadrantPaddingWidth:rect] / (self.displayNumber - 1));
                //起始点
                startX = [self dataQuadrantPaddingStartX:rect];
            }
            
            //遍历并绘制线条
            for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CCFloat valueY = [self calcValueY:lineData.value inRect:rect];
                //绘制线条路径
                if (j == self.displayFrom) {
                    CGContextMoveToPoint(context, startX, valueY);
                    lastY = valueY;
                } else {
                    if (lineData.value - self.noneDisplayValue == 0) {
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
                lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
                //起始点
                startX = [self dataQuadrantPaddingEndX:rect] - lineLength / 2;
            }else if (self.lineAlignType == CCSLineAlignTypeJustify) {
                // 点线距离
                lineLength= ([self dataQuadrantPaddingWidth:rect] / (self.displayNumber - 1));
                //起始点
                startX = [self dataQuadrantPaddingEndX:rect];
            }
            
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
                        lastY = valueY;
                    } else {
                        if (lineData.value - self.noneDisplayValue == 0) {
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
    if (self.displayLongitude == NO) {
        return;
    }
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.longitudeFontColor.CGColor);
    
    //设置线条为点线
    if (self.dashLongitude) {
        CGFloat lengths[] = {3.0, 3.0};
        CGContextSetLineDash(context, 0.0, lengths, 2);
    }
    
    CCFloat postOffset,offset;
    CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
    if (self.lineAlignType == CCSLineAlignTypeCenter) {
        postOffset= ([self dataQuadrantPaddingWidth:rect] - lineLength) / ([self.longitudeTitles count] - 1);
        offset = [self dataQuadrantPaddingStartX:rect] + lineLength/2;
    }else{
        postOffset= [self dataQuadrantPaddingWidth:rect] / ([self.longitudeTitles count] - 1);
        offset = [self dataQuadrantPaddingStartX:rect];
    }
    
    for (CCUInt i = 0; i < [self.longitudeTitles count]; i++) {
        CGContextMoveToPoint(context, offset + i * postOffset, [self dataQuadrantStartY:rect]);
        CGContextAddLineToPoint(context, offset + i * postOffset, [self dataQuadrantEndY:rect]);
    }
    
    CGContextStrokePath(context);
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawXAxisTitles:(CGRect)rect {
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
    
    CCFloat postOffset,offset;
    CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / self.displayNumber);
    if (self.lineAlignType == CCSLineAlignTypeCenter) {
        postOffset= ([self dataQuadrantPaddingWidth:rect] - lineLength) / ([self.longitudeTitles count] - 1);
        offset = [self dataQuadrantPaddingStartX:rect] + lineLength/2;
    }else{
        postOffset= [self dataQuadrantPaddingWidth:rect] / ([self.longitudeTitles count] - 1);
        offset = [self dataQuadrantPaddingStartX:rect];
    }
    
    for (CCUInt i = 0; i < [self.longitudeTitles count]; i++) {
        CCFloat startY;
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            startY = [self dataQuadrantEndY:rect] + [self axisWidth];
        }else{
            startY = [self borderWidth];
        }
        
        NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:i];
        
        //调整X轴坐标位置
        //调整X轴坐标位置
        if (i == 0) {
            //            [str drawInRect:CGRectMake([self dataQuadrantPaddingStartX:rect], startY, postOffset, self.longitudeFontSize)
            //                   withFont:self.longitudeFont
            //              lineBreakMode:NSLineBreakByWordWrapping
            //                  alignment:NSTextAlignmentLeft];
            
            CGRect textRect= CGRectMake([self dataQuadrantPaddingStartX:rect], startY, postOffset, self.longitudeFontSize);
            UIFont *textFont= self.longitudeFont; //设置字体
            NSMutableParagraphStyle *textStyle=[[[NSMutableParagraphStyle alloc]init]autorelease];//段落样式
            textStyle.alignment=NSTextAlignmentLeft;
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            //绘制字体
            [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
            
        } else if (i == [self.longitudeTitles count] - 1) {
            if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
                //                [str drawInRect:CGRectMake(rect.size.width - postOffset, startY, postOffset, self.longitudeFontSize)
                //                       withFont:self.longitudeFont
                //                  lineBreakMode:NSLineBreakByWordWrapping
                //                      alignment:NSTextAlignmentRight];
                
                CGRect textRect= CGRectMake(rect.size.width - postOffset, startY, postOffset, self.longitudeFontSize);
                UIFont *textFont= self.longitudeFont; //设置字体
                NSMutableParagraphStyle *textStyle=[[[NSMutableParagraphStyle alloc]init]autorelease];//段落样式
                textStyle.alignment=NSTextAlignmentRight;
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                //绘制字体
                [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                
            } else {
                //                [str drawInRect:CGRectMake(offset + (i - 0.5) * postOffset, startY, postOffset, self.longitudeFontSize)
                //                       withFont:self.longitudeFont
                //                  lineBreakMode:NSLineBreakByWordWrapping
                //                      alignment:NSTextAlignmentCenter];
                
                CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, startY, postOffset, self.longitudeFontSize);
                UIFont *textFont= self.longitudeFont; //设置字体
                NSMutableParagraphStyle *textStyle=[[[NSMutableParagraphStyle alloc]init]autorelease];//段落样式
                textStyle.alignment=NSTextAlignmentCenter;
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                //绘制字体
                [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
            }
            
        } else {
            //            [str drawInRect:CGRectMake(offset + (i - 0.5) * postOffset, startY, postOffset, self.longitudeFontSize)
            //                   withFont:self.longitudeFont
            //              lineBreakMode:NSLineBreakByWordWrapping
            //                  alignment:NSTextAlignmentCenter];
            
            CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, startY, postOffset, self.longitudeFontSize);
            UIFont *textFont= self.longitudeFont; //设置字体
            NSMutableParagraphStyle *textStyle=[[[NSMutableParagraphStyle alloc]init]autorelease];//段落样式
            textStyle.alignment=NSTextAlignmentCenter;
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            //绘制字体
            [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
        }
    }
}

- (void)initAxisX {
    if (self.linesData == nil) {
        return;
    }
    
    if ([self.linesData count] == 0) {
        return;
    }
    NSMutableArray *TitleX = [[[NSMutableArray alloc] init] autorelease];
    //以第1条线作为X轴的标示
    CCSTitledLine *line = [self.linesData objectAtIndex:0];
    
    if (line== nil) {
        return;
    }
    if ([line.data count] == 0) {
        return;
    }
    CCFloat average = self.displayNumber / self.longitudeNum;
    //处理刻度
    for (CCUInt i = 0; i < self.longitudeNum; i++) {
        CCUInt index = self.displayFrom + (CCUInt) floor(i * average);
        if (index > self.displayFrom + self.displayNumber - 1) {
            index = self.displayFrom + self.displayNumber - 1;
        }
        CCSLineData *lineData = [line.data objectAtIndex:index];
        //追加标题
        [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
    }
    CCSLineData *lineData = [line.data objectAtIndex:self.displayFrom + self.displayNumber];
    //追加标题
    [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
    
    self.longitudeTitles = TitleX;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    //[super touchesBegan:touches withEvent:event];
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        
        if (_flag == 0) {
            _firstX = pt1.x;
        } else {
            if (fabs(pt1.x - self.singleTouchPoint.x) < 6) {
                self.displayCrossXOnTouch = NO;
                self.displayCrossYOnTouch = NO;
                [self setNeedsDisplay];
                self.singleTouchPoint = CGPointZero;
                _flag = 0;
                
            } else {
                //获取选中点
                self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
                //重绘
                self.displayCrossXOnTouch = YES;
                self.displayCrossYOnTouch = YES;
                [self setNeedsDisplay];
                
                _flag = 1;
            }
        }
        
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];
        
        _startDistance1 = fabsf(pt1.x - pt2.x);
    } else {
        
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesMoved:touches withEvent:event];
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        if (_flag == 0) {
            CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:self.frame] / self.displayNumber) - 1;
            
            if (pt1.x - _firstX > lineLength) {
                if (self.displayFrom > 1) {
                    self.displayFrom = self.displayFrom - 2;
                }
            } else if (pt1.x - _firstX < -lineLength) {
                
                CCSTitledLine *line = [self.linesData objectAtIndex:0];
                if (self.displayFrom < [line.data count] - 2 - self.displayNumber) {
                    self.displayFrom = self.displayFrom + 2;
                }
            }
            
            _firstX = pt1.x;
            
            [self setNeedsDisplay];
            //设置可滚动
            [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
            
        } else {
            //获取选中点
            self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
            //设置可滚动
            [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
        }
        //        }
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];
        
        CCFloat endDistance = fabsf(pt1.x - pt2.x);
        //放大
        if (endDistance - _startDistance1 > _minDistance1) {
            [self zoomOut];
            _startDistance1 = endDistance;
            
            [self setNeedsDisplay];
        } else if (endDistance - _startDistance1 < -_minDistance1) {
            [self zoomIn];
            _startDistance1 = endDistance;
            
            [self setNeedsDisplay];
        }
        
    } else {
        
    }
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesEnded:touches withEvent:event];
    
    _startDistance1 = 0;
    
    _flag = 1;
    
    [self setNeedsDisplay];
}


- (void)zoomOut {
    if (self.displayNumber > self.minDisplayNumber) {
        
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        
        //区分缩放方向
        if (self.zoomBaseLine == CCSLineZoomBaseLineCenter) {
            self.displayNumber = self.displayNumber - 2;
            self.displayFrom = self.displayFrom + 1;
        } else if (self.zoomBaseLine == CCSLineZoomBaseLineLeft) {
            self.displayNumber = self.displayNumber - 2;
        } else if (self.zoomBaseLine == CCSLineZoomBaseLineRight) {
            self.displayNumber = self.displayNumber - 2;
            self.displayFrom = self.displayFrom + 2;
        }
        
        //处理displayNumber越界
        if (self.displayNumber < self.minDisplayNumber) {
            self.displayNumber = self.minDisplayNumber;
        }
        
        //处理displayFrom越界
        if (self.displayFrom + self.displayNumber >= [line.data count]) {
            self.displayFrom = [line.data count] - self.displayNumber;
        }
        
    }
}

- (void)zoomIn {
    CCSTitledLine *line = [self.linesData objectAtIndex:0];
    
    if (self.displayNumber < [line.data count] - 1) {
        if (self.displayNumber + 2 > [line.data count] - 1) {
            self.displayNumber = [line.data count] - 1;
            self.displayFrom = 0;
        } else {
            //区分缩放方向
            if (self.zoomBaseLine == CCSLineZoomBaseLineCenter) {
                self.displayNumber = self.displayNumber + 2;
                if (self.displayFrom > 1) {
                    self.displayFrom = self.displayFrom - 1;
                } else {
                    self.displayFrom = 0;
                }
            } else if (self.zoomBaseLine == CCSLineZoomBaseLineLeft) {
                self.displayNumber = self.displayNumber + 2;
            } else if (self.zoomBaseLine == CCSLineZoomBaseLineRight) {
                self.displayNumber = self.displayNumber + 2;
                if (self.displayFrom > 2) {
                    self.displayFrom = self.displayFrom - 2;
                } else {
                    self.displayFrom = 0;
                }
            }
        }
        
        if (self.displayFrom + self.displayNumber >= [line.data count]) {
            self.displayNumber = [line.data count] - self.displayFrom;
        }
    }
}


@end
