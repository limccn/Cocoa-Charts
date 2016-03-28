//
//  CCSSlipLineChart.m
//  CocoaChartsSample
//
//  Created by limc on 12/6/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSSlipLineChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@interface CCSSlipLineChart () {
    CCFloat _startDistance1;
    CCFloat _minDistance1;
    CCInt _flag;
    CCFloat _firstX;
    
    BOOL _isLongPress;
    BOOL _isMoved;
    BOOL _waitForLongPress;
    
    CGPoint _firstTouchPoint;
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
        
        
         _isLongPress = NO;
         _isMoved = NO;
         _waitForLongPress = NO;
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
    
    self.displayCrossXOnTouch = NO;
    self.displayCrossYOnTouch = NO;
    
}


- (void)calcValueRange {
    //调用父类
    //[super calcDataValueRange];
    
    CCFloat maxValue = -CCIntMax;
    CCFloat minValue = CCIntMax;
    
    for (CCInt i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        //获取线条数据
        NSArray *lineDatas = line.data;
        for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber - 1; j++) {
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
    
    // 起始位置
    CCFloat startX;
    CCFloat lastY = 0;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
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
                //判断Y轴的位置设置从左往右还是从右往左绘制
                if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
                    //TODO:自左向右绘图未对应
                    // 点线距离
                    CCFloat lineLength = ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / self.displayNumber);
                    //起始点
                    startX = super.axisMarginLeft + lineLength / 2;
                    //遍历并绘制线条
                    for (CCUInt j = self.displayFrom; j < self.displayFrom + self.displayNumber; j++) {
                        CCSLineData *lineData = [lineDatas objectAtIndex:j];
                        //获取终点Y坐标
                        CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
                    
                    // 点线距离
                    CCFloat lineLength = ((rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
                    //起始点
                    startX = rect.size.width - self.axisMarginRight - self.axisMarginLeft - lineLength / 2;
                    
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
                        for (CCUInt j = 0; j < self.displayNumber; j++) {
                            CCUInt index = self.displayFrom + self.displayNumber - 1 - j;
                            CCSLineData *lineData = [lineDatas objectAtIndex:index];
                            //获取终点Y坐标
                            CCFloat valueY = ((1 - (lineData.value - self.minValue) / (self.maxValue - self.minValue)) * (rect.size.height - 2 * self.axisMarginTop - self.axisMarginBottom) + self.axisMarginTop);
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
    }
}

- (void)initAxisX {
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.linesData != NULL && [self.linesData count] > 0) {
        //以第1条线作为X轴的标示
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if ([line.data count] > 0) {
            CCFloat average = [line.data count] / self.longitudeNum;            
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
            CCSLineData *lineData = [line.data objectAtIndex:self.displayFrom + self.displayNumber - 1];
            //追加标题
            [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
        }
    }
    self.longitudeTitles = TitleX;
}

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
//    //调用父类的触摸事件
//    //[super touchesBegan:touches withEvent:event];
//    
//    NSArray *allTouches = [touches allObjects];
//    //处理点击事件
//    if ([allTouches count] == 1) {
//        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
//        
//        if (_flag == 0) {
//            _firstX = pt1.x;
//        } else {
//            if (fabs(pt1.x - self.singleTouchPoint.x) < 6) {
//                self.displayCrossXOnTouch = NO;
//                self.displayCrossYOnTouch = NO;
//                [self setNeedsDisplay];
//                self.singleTouchPoint = CGPointZero;
//                _flag = 0;
//                
//            } else {
//                //获取选中点
//                self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
//                //重绘
//                self.displayCrossXOnTouch = YES;
//                self.displayCrossYOnTouch = YES;
//                [self setNeedsDisplay];
//                
//                _flag = 1;
//            }
//        }
//        
//    } else if ([allTouches count] == 2) {
//        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
//        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];
//        
//        _startDistance1 = fabsf(pt1.x - pt2.x);
//    } else {
//        
//    }
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
//    //调用父类的触摸事件
//    [super touchesMoved:touches withEvent:event];
//    
//    NSArray *allTouches = [touches allObjects];
//    //处理点击事件
//    if ([allTouches count] == 1) {
//        if (_flag == 0) {
//            CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
//            CCFloat stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 1;
//            
//            if (pt1.x - _firstX > stickWidth) {
//                if (self.displayFrom > 1) {
//                    self.displayFrom = self.displayFrom - 2;
//                }
//            } else if (pt1.x - _firstX < -stickWidth) {
//                
//                CCSTitledLine *line = [self.linesData objectAtIndex:0];
//                if (self.displayFrom < [line.data count] - 2 - self.displayNumber) {
//                    self.displayFrom = self.displayFrom + 2;
//                }
//            }
//            
//            _firstX = pt1.x;
//            
//            [self setNeedsDisplay];
//            //设置可滚动
//            [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
//            
//        } else {
//            //获取选中点
//            self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
//            //设置可滚动
//            [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
//        }
//        //        }
//    } else if ([allTouches count] == 2) {
//        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
//        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];
//        
//        CCFloat endDistance = fabsf(pt1.x - pt2.x);
//        //放大
//        if (endDistance - _startDistance1 > _minDistance1) {
//            [self zoomOut];
//            _startDistance1 = endDistance;
//            
//            [self setNeedsDisplay];
//        } else if (endDistance - _startDistance1 < -_minDistance1) {
//            [self zoomIn];
//            _startDistance1 = endDistance;
//            
//            [self setNeedsDisplay];
//        }
//        
//    } else {
//        
//    }
//    
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
//    //调用父类的触摸事件
//    [super touchesEnded:touches withEvent:event];
//    
//    _startDistance1 = 0;
//    
//    _flag = 1;
//    
//    [self setNeedsDisplay];
//}





- (void) changeLongPressState:(BOOL)state {
    _waitForLongPress = NO;
    
    if (_isLongPress == NO) {
        _isLongPress = YES;
        
        self.displayCrossXOnTouch = NO;
        self.displayCrossYOnTouch = NO;
        //获取选中点
        self.singleTouchPoint = _firstTouchPoint;
        [self setNeedsDisplay];
        
    }else{
        self.displayCrossXOnTouch = YES;
        self.displayCrossYOnTouch = YES;
        [self setNeedsDisplay];
    }
    
    [self canPerformAction:@selector(changeLongPressState:) withSender:nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        
        
        self.displayCrossXOnTouch = NO;
        self.displayCrossYOnTouch = NO;
        
        _firstX = pt1.x;
        
        _firstTouchPoint = pt1;
        
        _isLongPress = NO;
        _isMoved = NO;
        _waitForLongPress = YES;
        [self performSelector:@selector(changeLongPressState:) withObject:nil afterDelay:0.5];
        
        
        //        if (_flag == 0) {
        //            _firstX = pt1.x;
        //
        //        } else {
        //            if (fabs(pt1.x - self.singleTouchPoint.x) < 10) {
        //                self.displayCrossXOnTouch = NO;
        //                self.displayCrossYOnTouch = NO;
        //                [self setNeedsDisplay];
        //                self.singleTouchPoint = CGPointZero;
        //                _flag = 0;
        //
        //            } else {
        //                //获取选中点
        //                self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //                //重绘
        //                self.displayCrossXOnTouch = YES;
        //                self.displayCrossYOnTouch = YES;
        //                [self setNeedsDisplay];
        //
        //                _flag = 1;
        //            }
        //        }
        
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];
        
        _startDistance1 = fabs(pt1.x - pt2.x);
    } else {
        
    }
    
    //调用父类的触摸事件
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        
        
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        
        if (_isLongPress == NO) {
            if (fabs(pt1.x - _firstTouchPoint.x) < 4) {
                //            _firstX = pt1.x;
                if (_waitForLongPress) {
                    NSLog(@"Waiting for LongPress");
                }else{
                    _isLongPress = YES;
                    NSLog(@"LongPress");
                }
            }else{
                NSLog(@"Moved");
                //                _firstX = pt1.x;
                _waitForLongPress = NO;
                _isMoved = YES;
                [self canPerformAction:@selector(changeLongPressState:) withSender:nil];
                //            _isLongPress = NO;
            }
            self.displayCrossXOnTouch = NO;
            self.displayCrossYOnTouch = NO;
            [self setNeedsDisplay];
            
        }else if(_isMoved == NO){
            self.displayCrossXOnTouch = YES;
            self.displayCrossYOnTouch = YES;
            [self setNeedsDisplay];
            
        }
        
        if (_isMoved) {
            
            self.displayCrossXOnTouch = NO;
            self.displayCrossYOnTouch = NO;
            
            CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
            CCFloat stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 1;
            
            
            CCSTitledLine *line = [self.linesData objectAtIndex:0];
            
            if (pt1.x - _firstX > stickWidth) {
                if (self.displayFrom > 2) {
                    self.displayFrom = self.displayFrom - 2;
                }
            } else if (pt1.x - _firstX < -stickWidth) {
                if (self.displayFrom + self.displayNumber + 2 < [line.data count]) {
                    self.displayFrom = self.displayFrom + 2;
                }
            }
            
            
            _firstX = pt1.x;
            
            //获取选中点
            self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
            
            [self setNeedsDisplay];
            
            //设置可滚动
            //[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
            
            //            if (self.coChart) {
            //                ((CCSSlipStickChart *)self.coChart).displayFrom = self.displayFrom;
            //                ((CCSSlipStickChart *)self.coChart).displayNumber = self.displayNumber;
            //                [self.coChart setNeedsDisplay];
            //            }
            
        }
        
        
        //        if (_flag == 0) {
        ////            CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        ////            CCFloat stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber) - 1;
        ////
        ////
        ////            if (_isLongPress) {
        ////                if (pt1.x - _firstX < 15) {
        ////                    NSLog(@"LongPress");
        ////                }
        ////            }
        ////
        ////            if (pt1.x - _firstX > stickWidth) {
        ////                if (self.displayFrom > 2) {
        ////                    self.displayFrom = self.displayFrom - 2;
        ////                }
        ////            } else if (pt1.x - _firstX < -stickWidth) {
        ////                if (self.displayFrom + self.displayNumber + 2 < [self.stickData count]) {
        ////                    self.displayFrom = self.displayFrom + 2;
        ////                }
        ////            }
        ////
        ////            _firstX = pt1.x;
        ////
        ////            [self setNeedsDisplay];
        ////            //设置可滚动
        ////            //[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
        ////
        ////            if (self.coChart) {
        ////                ((CCSSlipStickChart *)self.coChart).displayFrom = self.displayFrom;
        ////                ((CCSSlipStickChart *)self.coChart).displayNumber = self.displayNumber;
        ////                [self.coChart setNeedsDisplay];
        ////            }
        //        } else {
        //            //获取选中点
        //            self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //            //设置可滚动
        //            //[self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
        //            [self setNeedsDisplay];
        //        }
        //        }
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];
        
        CCFloat endDistance = fabs(pt1.x - pt2.x);
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
    
    [self canPerformAction:@selector(changeLongPressState:) withSender:nil];
    
    _startDistance1 = 0;
    
    _flag = 1;
    
    NSLog(@"end");
    _isLongPress = NO;
    _isMoved = NO;
    _waitForLongPress = YES;
    
    self.displayCrossXOnTouch = NO;
    self.displayCrossYOnTouch = NO;
    
    
    [self setNeedsDisplay];
}

- (void)calcSelectedIndex {
    //X在系统范围内、进行计算
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        if (self.singleTouchPoint.x > self.axisMarginLeft
            && self.singleTouchPoint.x < self.frame.size.width) {
            CCFloat stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
            CCFloat valueWidth = self.singleTouchPoint.x - self.axisMarginLeft;
            if (valueWidth > 0) {
                CCUInt index = (CCUInt) (valueWidth / stickWidth);
                //如果超过则设置位最大
                if (index >= self.displayNumber) {
                    index = self.displayNumber - 1;
                }
                //设置选中的index
                self.selectedIndex = self.displayFrom + index;
                
            }
        }
    } else {
        if (self.singleTouchPoint.x > self.axisMarginLeft
            && self.singleTouchPoint.x < self.frame.size.width - self.axisMarginRight) {
            CCFloat stickWidth = 1.0 * ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
            CCFloat valueWidth = self.singleTouchPoint.x - self.axisMarginLeft;
            if (valueWidth > 0) {
                CCUInt index = (CCUInt) (valueWidth / stickWidth);
                //如果超过则设置位最大
                if (index >= self.displayNumber) {
                    index = self.displayNumber - 1;
                }
                //设置选中的index
                self.selectedIndex = self.displayFrom + index;
                
            }
        }
    }
    
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


-(void) bindSelectedIndex
{
    CCFloat stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
    _singleTouchPoint = CGPointMake(self.axisMarginLeft +(self.selectedIndex - self.displayFrom + 0.5) * stickWidth, self.singleTouchPoint.y);
}

@end
