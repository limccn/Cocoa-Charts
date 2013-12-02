//
//  CCSSlipStickChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/21/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSSlipStickChart.h"
#import "CCSStickChartData.h"

@implementation CCSSlipStickChart
@synthesize displayNumber = _displayNumber;
@synthesize displayFrom = _displayFrom;
@synthesize minDisplayNumber = _minDisplayNumber;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    
    self.displayFrom = 0;
    self.displayNumber = 10;
    self.minDisplayNumber = 10;
}

- (void)calcValueRange {
    if (self.stickData != NULL && [self.stickData count] > 0) {
        
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
        
        if ((long) maxValue > (long) minValue) {
            if ((maxValue - minValue) < 10 && minValue > 1) {
                self.maxValue = (long) (maxValue + 1);
                self.minValue = (long) (minValue - 1);
            } else {
                self.maxValue = (long) (maxValue + (maxValue - minValue) * 0.1);
                self.minValue = (long) (minValue - (maxValue - minValue) * 0.1);
                if (self.minValue < 0) {
                    self.minValue = 0;
                }
            }
        } else if ((long) maxValue == (long) minValue) {
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
    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }
    //修正最大值和最小值
    long rate = (self.maxValue - self.minValue) / (self.latitudeNum);
    NSString *strRate = [NSString stringWithFormat:@"%ld", rate];
    float first = [[strRate substringToIndex:1] intValue] + 1.0f;
    if (first > 0 && strRate.length > 1) {
        float second = [[[strRate substringToIndex:2] substringFromIndex:1] intValue];
        if (second < 5) {
            first = first - 0.5;
        }
        rate = first * pow(10, strRate.length - 1);
    } else {
        rate = 1;
    }
    //等分轴修正
    if (self.latitudeNum > 0 && (long) (self.maxValue - self.minValue) % (self.latitudeNum * rate) != 0) {
        //最大值加上轴差
        self.maxValue = (long) self.maxValue + (self.latitudeNum * rate) - ((long) (self.maxValue - self.minValue) % (self.latitudeNum * rate));
    }
}

- (void)initAxisY {
    NSMutableArray *TitleY = [[[NSMutableArray alloc] init] autorelease];
    if (self.stickData != NULL && [self.stickData count] > 0) {
        float average = self.displayNumber / self.longitudeNum;
        CCSStickChartData *chartdata = nil;
        if (self.axisYPosition == CCSGridChartAxisPositionLeft) {
            //处理刻度
            for (NSUInteger i = 0; i < self.longitudeNum; i++) {
                NSUInteger index = self.displayFrom + (NSUInteger) floor(i * average);
                if (index > self.displayFrom + self.displayNumber) {
                    index = self.displayFrom + self.displayNumber;
                }
                chartdata = [self.stickData objectAtIndex:index];
                //追加标题
                [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
            }
            chartdata = [self.stickData objectAtIndex:self.displayFrom + self.displayNumber];
            //追加标题
            [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
        }
        else {
            //处理刻度
            for (NSUInteger i = 0; i < self.longitudeNum; i++) {
                NSUInteger index = [self.stickData count] - self.maxSticksNum + (NSUInteger) floor(i * average);
                if (index > [self.stickData count] - 1) {
                    index = [self.stickData count] - 1;
                }
                chartdata = [self.stickData objectAtIndex:index];
                //追加标题
                [TitleY addObject:[NSString stringWithFormat:@"%@", chartdata.date]];
            }
            chartdata = [self.stickData objectAtIndex:[self.stickData count] - 1];
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
    
    NSMutableArray *TitleX = [[[NSMutableArray alloc] init] autorelease];
    float average = (NSUInteger) ((self.maxValue - self.minValue) / self.latitudeNum);
    //处理刻度
    for (NSUInteger i = 0; i < self.latitudeNum; i++) {
        if (self.axisCalc == 1) {
            NSString *value = [NSString stringWithFormat:@"%d", (int) floor(self.minValue + i * average) / self.axisCalc];
            [TitleX addObject:value];
        } else {
            NSString *value = [NSString stringWithFormat:@"%-.2f", floor(self.minValue + i * average) / self.axisCalc];
            [TitleX addObject:value];
        }
    }
    //处理最大值
    if (self.axisCalc == 1) {
        NSString *value = [NSString stringWithFormat:@"%d", (int) (self.maxValue) / self.axisCalc];
        [TitleX addObject:value];
    }
    else {
        NSString *value = [NSString stringWithFormat:@"%-.2f", (self.maxValue) / self.axisCalc];
        [TitleX addObject:value];
    }
    
    self.axisXTitles = TitleX;
}

float _startDistance1 = 0;
float _minDistance1 = 8;
int _flag = 1;
float _firstX =0;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    //[super touchesBegan:touches withEvent:event];
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        
        if (_flag == 0) {
            _firstX = pt1.x;
        }else{
            if (fabs(pt1.x - self.singleTouchPoint.x) < 6) {
                self.displayCrossXOnTouch = NO;
                self.displayCrossYOnTouch = NO;
                [self setNeedsDisplay];
                self.singleTouchPoint = CGPointZero;
                _flag = 0;
                
            }else{
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
        NSLog(@"Start Distance:%f", _startDistance1);
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
            if (pt1.x - _firstX > 4) {
                if(self.displayFrom > 1){
                    self.displayFrom = self.displayFrom - 1;
                }
            }else if (pt1.x - _firstX < -4) {
                if(self.displayFrom < [self.stickData count] - 1 - self.displayNumber) {
                    self.displayFrom = self.displayFrom + 1;
                }
            }
            
            _firstX = pt1.x;
        }else{
            //获取选中点
            self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
            //设置可滚动
            [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
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
        
        if (self.axisYPosition == CCSGridChartAxisPositionLeft) {
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
            for (NSInteger i = [self.stickData count] - 1; i >= 0; i--) {
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
                stickX = stickX - 1 - stickWidth;
            }
        }
        
    }
}

- (void)zoomOut {
    if (self.displayNumber > self.minDisplayNumber) {
        self.displayNumber = self.displayNumber - 2;
        //固定根数
        if (self.displayNumber < self.minDisplayNumber) {
            self.displayNumber = self.minDisplayNumber;
        }
        if (self.coChart) {
            self.coChart.maxSticksNum = self.maxSticksNum;
            [self.coChart setNeedsDisplay];
        }
    }
}

- (void)zoomIn {
    if (self.displayNumber < [self.stickData count] - 1) {
        if (self.displayNumber + 2 > [self.stickData count] - 1) {
            self.displayNumber = [self.stickData count] - 1;
        } else {
            self.displayNumber = self.displayNumber + 2;
        }
        
        if (self.displayFrom + self.displayNumber >= [self.stickData count] - 1) {
            self.displayNumber = [self.stickData count] - 1 - self.displayFrom;
        }
        
        if (self.coChart) {
            self.coChart.maxSticksNum = self.maxSticksNum;
            [self.coChart setNeedsDisplay];
        }
    }
}

@end
