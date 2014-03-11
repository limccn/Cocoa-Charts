//
//  CCSSlipStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/21/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSSlipStickChart.h"
#import "CCSStickChartData.h"

@interface  CCSSlipStickChart () {
    float _startDistance1;
    float _minDistance1;
    float _doubleTouchInterval;
    int _flag;
    float _firstX;
}
@end

@implementation CCSSlipStickChart
@synthesize displayNumber = _displayNumber;
@synthesize displayFrom = _displayFrom;
@synthesize minDisplayNumber = _minDisplayNumber;
@synthesize zoomBaseLine = _zoomBaseLine;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _startDistance1 = 0;
        _minDistance1 = 8;
        _doubleTouchInterval = 100;
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
    self.zoomBaseLine = CCSStickZoomBaseLineCenter;
}

- (void)calcDataValueRange {
    double maxValue = 0;
    double minValue = NSIntegerMax;

    CCSStickChartData *first = [self.stickData objectAtIndex:self.displayFrom];
    //第一个stick为停盘的情况
    if (first.high == 0 && first.low == 0) {

    } else {
        maxValue = first.high;
        minValue = first.low;
    }

    //判断显示为方柱或显示为线条
    for (NSUInteger i = self.displayFrom; i < self.displayFrom + self.displayNumber; i++) {
        CCSStickChartData *stick = [self.stickData objectAtIndex:i];
        if (stick.low < minValue) {
            minValue = stick.low;
        }

        if (stick.high > maxValue) {
            maxValue = stick.high;
        }

    }

    self.maxValue = maxValue;
    self.minValue = minValue;
}

- (void)initAxisY {
    NSMutableArray *TitleY = [[NSMutableArray alloc] init];
    if (self.stickData != NULL && [self.stickData count] > 0) {
        float average = self.displayNumber / self.longitudeNum;
        CCSStickChartData *chartdata = nil;
        if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
            //处理刻度
            for (NSUInteger i = 0; i < self.longitudeNum; i++) {
                NSUInteger index = self.displayFrom + (NSUInteger) floor(i * average);
                if (index > self.displayFrom + self.displayNumber - 1) {
                    index = self.displayFrom + self.displayNumber - 1;
                }
                chartdata = [self.stickData objectAtIndex:index];
                //追加标题
                [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
            }
            chartdata = [self.stickData objectAtIndex:self.displayFrom + self.displayNumber - 1];
            //追加标题
            [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
        }
        else {
            //处理刻度
            for (NSUInteger i = 0; i < self.longitudeNum; i++) {
                NSUInteger index = self.displayFrom + (NSUInteger) floor(i * average);
                if (index > self.displayFrom + self.displayNumber - 1) {
                    index = self.displayFrom + self.displayNumber - 1;
                }
                chartdata = [self.stickData objectAtIndex:index];
                //追加标题
                [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
            }
            chartdata = [self.stickData objectAtIndex:self.displayFrom + self.displayNumber - 1];
            //追加标题
            [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
        }

    }
    self.axisYTitles = TitleY;
}

- (void)initAxisX {
    //计算取值范围
    [self calcValueRange];

    if (self.maxValue == 0. && self.minValue == 0.) {
        self.axisXTitles = nil;
        return;
    }

    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    float average = (NSUInteger) ((self.maxValue - self.minValue) / self.latitudeNum);
    //处理刻度
    for (NSUInteger i = 0; i < self.latitudeNum; i++) {
        if (self.axisCalc == 1) {
            NSUInteger degree = floor(self.minValue + i * average) / self.axisCalc;
            NSString *value = [[NSNumber numberWithUnsignedInteger:degree]stringValue];
            [TitleX addObject:value];
        } else {
            NSString *value = [NSString stringWithFormat:@"%-.2f", floor(self.minValue + i * average) / self.axisCalc];
            [TitleX addObject:value];
        }
    }
    //处理最大值
    if (self.axisCalc == 1) {
        NSUInteger degree = (NSInteger) (self.maxValue) / self.axisCalc;
        NSString *value = [[NSNumber numberWithUnsignedInteger:degree]stringValue];
        [TitleX addObject:value];
    }
    else {
        NSString *value = [NSString stringWithFormat:@"%-.2f", (self.maxValue) / self.axisCalc];
        [TitleX addObject:value];
    }

    self.axisXTitles = TitleX;
}

- (NSString *)calcAxisXGraduate:(CGRect)rect {
    float value = [self touchPointAxisXValue:rect];
    NSString *result = @"";
    if (self.stickData != NULL && [self.stickData count] > 0) {
        if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
            if (value >= 1) {
                result = ((CCSStickChartData *) [self.stickData objectAtIndex:self.displayFrom + self.displayNumber - 1]).date;
            } else if (value <= 0) {
                result = ((CCSStickChartData *) [self.stickData objectAtIndex:self.displayFrom]).date;
            } else {
                NSUInteger index = self.displayFrom + (NSUInteger) (self.displayNumber * value);
                if (index > self.displayFrom + self.displayNumber - 1) {
                    index = self.displayFrom + self.displayNumber - 1;
                }
                result = ((CCSStickChartData *) [self.stickData objectAtIndex:index]).date;
            }
        } else {
            if (value >= 1) {
                result = ((CCSStickChartData *) [self.stickData objectAtIndex:self.displayFrom + self.displayNumber - 1]).date;
            } else if (value <= 0) {
                result = ((CCSStickChartData *) [self.stickData objectAtIndex:self.displayFrom]).date;
            } else {
                NSUInteger index = self.displayFrom + (NSUInteger) (self.displayNumber * value);
                if (index > self.displayFrom + self.displayNumber - 1) {
                    index = self.displayFrom + self.displayNumber - 1;
                }
                result = ((CCSStickChartData *) [self.stickData objectAtIndex:index]).date;
            }
        }
    }
    return result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {


    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];

        if (_flag == 0) {
            _firstX = pt1.x;
        } else {
            if (fabs(pt1.x - self.singleTouchPoint.x) < 10) {
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
    
    //调用父类的触摸事件
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {


    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        if (_flag == 0) {
            CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
            float stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 1;

            if (pt1.x - _firstX > stickWidth) {
                if (self.displayFrom > 2) {
                    self.displayFrom = self.displayFrom - 2;
                }
            } else if (pt1.x - _firstX < -stickWidth) {
                if (self.displayFrom + self.displayNumber + 2 < [self.stickData count]) {
                    self.displayFrom = self.displayFrom + 2;
                }
            }

            _firstX = pt1.x;

            [self setNeedsDisplay];
            //设置可滚动
            //[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
            
            if (self.coChart) {
                ((CCSSlipStickChart *)self.coChart).displayFrom = self.displayFrom;
                ((CCSSlipStickChart *)self.coChart).displayNumber = self.displayNumber;
                [self.coChart setNeedsDisplay];
            }
        } else {
            //获取选中点
            self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
            //设置可滚动
            //[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
            [self setNeedsDisplay];
        }
        //        }
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];

        float endDistance = fabsf(pt1.x - pt2.x);
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
    
    //调用父类的触摸事件
    [super touchesMoved:touches withEvent:event];

}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesEnded:touches withEvent:event];

    _startDistance1 = 0;

    _flag = 1;

    [self setNeedsDisplay];
}

- (void)drawData:(CGRect)rect {
    // 蜡烛棒宽度
    float stickWidth = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 1;

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.stickBorderColor.CGColor);
    CGContextSetFillColorWithColor(context, self.stickFillColor.CGColor);

    if (self.stickData != NULL && [self.stickData count] > 0) {

        if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
            // 蜡烛棒起始绘制位置
            float stickX = self.axisMarginLeft + 1;
            //判断显示为方柱或显示为线条
            for (NSUInteger i = self.displayFrom; i < self.displayFrom + self.displayNumber; i++) {
                CCSStickChartData *stick = [self.stickData objectAtIndex:i];

                float highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                float lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        //填充路径
                        CGContextFillPath(context);
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
                        //绘制线条
                        CGContextStrokePath(context);
                    }
                }

                //X位移
                stickX = stickX + 1 + stickWidth;
            }
        } else {
            // 蜡烛棒起始绘制位置
            float stickX = rect.size.width - self.axisMarginRight - 1 - stickWidth;
            //判断显示为方柱或显示为线条
            for (NSUInteger i = 0; i < self.displayNumber; i++) {
                //获取index
                NSUInteger index = self.displayFrom + self.displayNumber - 1 - i;
                CCSStickChartData *stick = [self.stickData objectAtIndex:index];

                float highY = ((1 - (stick.high - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - super.axisMarginTop);
                float lowY = ((1 - (stick.low - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - self.axisMarginBottom) - self.axisMarginTop);

                if (stick.high == 0) {
                    //没有值的情况下不绘制
                } else {
                    //绘制数据，根据宽度判断绘制直线或方柱
                    if (stickWidth >= 2) {
                        CGContextAddRect(context, CGRectMake(stickX, highY, stickWidth, lowY - highY));
                        //填充路径
                        CGContextFillPath(context);
                    } else {
                        CGContextMoveToPoint(context, stickX, highY);
                        CGContextAddLineToPoint(context, stickX, lowY);
                        //绘制线条
                        CGContextStrokePath(context);
                    }
                }
                //X位移
                stickX = stickX - 1 - stickWidth;
            }
        }

    }
}

- (void)calcSelectedIndex {
    //X在系统范围内、进行计算
    if (self.axisYPosition == CCSGridChartAxisYPositionLeft) {
        if (self.singleTouchPoint.x > self.axisMarginLeft
            && self.singleTouchPoint.x < self.frame.size.width) {
            float stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
            float valueWidth = self.singleTouchPoint.x - self.axisMarginLeft;
            if (valueWidth > 0) {
                NSUInteger index = (NSUInteger) (valueWidth / stickWidth);
                //如果超过则设置位最大
                if (index >= self.displayNumber) {
                    index = self.displayNumber - 1;
                }
                //设置选中的index
                self.selectedStickIndex = self.displayFrom + index;
            }
        }
    } else {
        if (self.singleTouchPoint.x > self.axisMarginLeft
            && self.singleTouchPoint.x < self.frame.size.width - self.axisMarginRight) {
            float stickWidth = 1.0 * ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
            float valueWidth = self.singleTouchPoint.x - self.axisMarginLeft;
            if (valueWidth > 0) {
                NSUInteger index = (NSUInteger) (valueWidth / stickWidth);
                //如果超过则设置位最大
                if (index >= self.displayNumber) {
                    index = self.displayNumber - 1;
                }
                //设置选中的index
                self.selectedStickIndex = self.displayFrom + index;
            }
        }
    }
    
}

- (void)zoomOut {
    if (self.displayNumber > self.minDisplayNumber) {

        //区分缩放方向
        if (self.zoomBaseLine == CCSStickZoomBaseLineCenter) {
            self.displayNumber = self.displayNumber - 2;
            self.displayFrom = self.displayFrom + 1;
        } else if (self.zoomBaseLine == CCSStickZoomBaseLineLeft) {
            self.displayNumber = self.displayNumber - 2;
        } else if (self.zoomBaseLine == CCSStickZoomBaseLineRight) {
            self.displayNumber = self.displayNumber - 2;
            self.displayFrom = self.displayFrom + 2;
        }

        //处理displayNumber越界
        if (self.displayNumber < self.minDisplayNumber) {
            self.displayNumber = self.minDisplayNumber;
        }

        //处理displayFrom越界
        if (self.displayFrom + self.displayNumber >= [self.stickData count]) {
            self.displayFrom = [self.stickData count] - self.displayNumber;
        }

        if (self.coChart) {
            ((CCSSlipStickChart *)self.coChart).displayFrom = self.displayFrom;
            ((CCSSlipStickChart *)self.coChart).displayNumber = self.displayNumber;
            [self.coChart setNeedsDisplay];
        }
    }
}

- (void)zoomIn {
    if (self.displayNumber < [self.stickData count] - 1) {
        if (self.displayNumber + 2 > [self.stickData count] - 1) {
            self.displayNumber = [self.stickData count] - 1;
            self.displayFrom = 0;
        } else {
            //区分缩放方向
            if (self.zoomBaseLine == CCSStickZoomBaseLineCenter) {
                self.displayNumber = self.displayNumber + 2;
                if (self.displayFrom > 1) {
                    self.displayFrom = self.displayFrom - 1;
                } else {
                    self.displayFrom = 0;
                }
            } else if (self.zoomBaseLine == CCSStickZoomBaseLineLeft) {
                self.displayNumber = self.displayNumber + 2;
            } else if (self.zoomBaseLine == CCSStickZoomBaseLineRight) {
                self.displayNumber = self.displayNumber + 2;
                if (self.displayFrom > 2) {
                    self.displayFrom = self.displayFrom - 2;
                } else {
                    self.displayFrom = 0;
                }
            }
        }

        if (self.displayFrom + self.displayNumber >= [self.stickData count]) {
            self.displayNumber = [self.stickData count] - self.displayFrom;
        }

        if (self.coChart) {
            ((CCSSlipStickChart *)self.coChart).displayFrom = self.displayFrom;
            ((CCSSlipStickChart *)self.coChart).displayNumber = self.displayNumber;
            [self.coChart setNeedsDisplay];
        }
    }
}

- (void) setDisplayFrom:(NSUInteger)displayFrom
{
    _displayFrom = displayFrom;
    
    if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartDisplayChangedFrom:number:)]) {
        [self.chartDelegate CCSChartDisplayChangedFrom:displayFrom number:self.displayNumber];
    }
}

-(void) setDisplayNumber:(NSUInteger)displayNumber
{
    _displayNumber = displayNumber;
    
    if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartDisplayChangedFrom: number:)]) {
        [self.chartDelegate CCSChartDisplayChangedFrom:self.displayFrom number:displayNumber];
    }
}

@end
