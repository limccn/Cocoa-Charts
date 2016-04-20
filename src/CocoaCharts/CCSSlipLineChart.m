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
@synthesize maxDisplayNumber = _maxDisplayNumber;
//@synthesize zoomBaseLine = _zoomBaseLine;
//@synthesize noneDisplayValue = _noneDisplayValue;

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
    self.displayNumber = 20;
    self.minDisplayNumber = 20;
    self.maxDisplayNumber = 20;
//    self.zoomBaseLine = CCSLineZoomBaseLineCenter;
//    self.noneDisplayValue = 0;
    
    self.displayCrossXOnTouch = NO;
    self.displayCrossYOnTouch = NO;
    
}


- (void)calcDataValueRange {
    if (self.displayNumber <= 0) {
        return;
    }
    //调用父类
    //[super calcDataValueRange];
    
    CCFloat maxValue = -CCIntMax;
    CCFloat minValue = CCIntMax;
    
    for (CCInt i = [self.linesData count] - 1; i >= 0; i--) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        //获取线条数据
        NSArray *lineDatas = line.data;
        for (CCUInt j = self.displayFrom; j < [self getDisplayTo] - 1; j++) {
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
    
    self.minValue = minValue;
    self.maxValue = maxValue;
    
    if(self.maxValue < self.minValue){
        self.minValue = 0;
        self.maxValue = 0;
    }
}

- (void)calcValueRange {
    if (self.linesData != NULL && [self.linesData count] > 0) {
        [self calcDataValueRange];
//        [self calcValueRangePaddingZero];
    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }
    
//    [self calcValueRangeFormatForAxis];
    
    if (self.balanceRange) {
        [self calcBalanceRange];
    }
}

- (void)drawRect:(CGRect)rect {
    
    //初始化XY轴
    [self initAxisY];
    [self initAxisX];
    
    [super drawRect:rect];
}

- (void)drawLines:(CGRect)rect {
    
    // 起始位置
    CCFloat startX;
//    CCFloat lastY = 0;
    
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
               // 点线距离
                    CCFloat lineLength = ((rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / self.displayNumber);
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
}

- (void)initAxisX {
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.linesData != NULL && [self.linesData count] > 0 && self.displayNumber > 0) {
        //以第1条线作为X轴的标示
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if ([line.data count] > 0) {
            CCFloat average = [line.data count] / self.longitudeNum;            
            //处理刻度
            for (CCUInt i = 0; i < self.longitudeNum; i++) {
                CCUInt index = self.displayFrom + (CCUInt) floor(i * average);
                if (index > [self getDisplayTo] - 1) {
                    index = [self getDisplayTo] - 1;
                }
                CCSLineData *lineData = [line.data objectAtIndex:index];
                //追加标题
                [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
            }
            CCSLineData *lineData = [line.data objectAtIndex:[self getDisplayTo] - 1];
            //追加标题
            [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
        }
    }
    self.longitudeTitles = TitleX;
}


- (void)initAxisY {
    //计算取值范围
    if ([self autoCalcRange]) {
        //计算取值范围
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
            CCInt degree = (self.minValue + i * average) / self.axisCalc;
            NSString *value = [[NSNumber numberWithInteger:degree]stringValue];
            [TitleY addObject:value];
        } else {
            NSString *value = [NSString stringWithFormat:@"%-.2f", (self.minValue + i * average) / self.axisCalc];
            [TitleY addObject:value];
        }
    }
    //处理最大值
    if (self.axisCalc == 1) {
        CCInt degree = self.maxValue / self.axisCalc;
        NSString *value = [[NSNumber numberWithInteger:degree]stringValue];
        [TitleY addObject:value];
    }
    else {
        NSString *value = [NSString stringWithFormat:@"%-.2f", (self.maxValue) / self.axisCalc];
        [TitleY addObject:value];
    }
    
    self.latitudeTitles = TitleY;
}

- (NSString *)calcAxisXGraduate:(CGRect)rect {
    CCFloat value = [self touchPointAxisXValue:rect];
    NSString *result = @"";
    
    
    if (self.linesData != NULL && [self.linesData count] > 0) {
        
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if(line != nil){
           if(line.data != nil && [line.data count] >0){
        
//        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            if (value >= 1) {
                result = ((CCSLineData *) [line.data objectAtIndex:[self getDisplayTo] - 1]).date;
            } else if (value <= 0) {
                result = ((CCSLineData *) [line.data objectAtIndex:self.displayFrom]).date;
            } else {
                CCUInt index = self.displayFrom + (CCUInt) (self.displayNumber * value);
                if (index > [self getDisplayTo] - 1) {
                    index = [self getDisplayTo] - 1;
                }
                result = ((CCSLineData *) [line.data objectAtIndex:index]).date;
            }
//        } else {
//            if (value >= 1) {
//                result = ((CCSStickChartData *) [self.stickData objectAtIndex:[self getDisplayTo] - 1]).date;
//            } else if (value <= 0) {
//                result = ((CCSStickChartData *) [self.stickData objectAtIndex:self.displayFrom]).date;
//            } else {
//                CCUInt index = self.displayFrom + (CCUInt) (self.displayNumber * value);
//                if (index > [self getDisplayTo] - 1) {
//                    index = [self getDisplayTo] - 1;
//                }
//                result = ((CCSStickChartData *) [self.stickData objectAtIndex:index]).date;
//            }
//        }
           }
        }
    }
    return result;
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
//            CCFloat stickWidth = [self getStickWidth] - 1;
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
        self.displayCrossXOnTouch = NO;
        self.displayCrossYOnTouch = NO;
        
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
            CCFloat stickWidth = [self getDataStickWidth];
            
            
//            CCSTitledLine *line = [self.linesData objectAtIndex:0];
//            
//            if (pt1.x - _firstX > stickWidth) {
//                if (self.displayFrom > 2) {
//                    self.displayFrom = self.displayFrom - 2;
//                }
//            } else if (pt1.x - _firstX < -stickWidth) {
//                if ([self getDisplayTo] + 2 < [line.data count]) {
//                    self.displayFrom = self.displayFrom + 2;
//                }
//            }
            
            if (pt1.x - _firstX > stickWidth) {
                [self moveLeft];
            } else if (pt1.x - _firstX < -stickWidth) {
                [self moveRight];
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
        ////            CCFloat stickWidth = [self getStickWidth] - 1;
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
        ////                if ([self getDisplayTo] + 2 < [self.stickData count]) {
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
        //限制为单指十字线
        if (self.displayCrossXOnTouch == YES && self.displayCrossYOnTouch == YES) {
            self.displayCrossXOnTouch = NO;
            self.displayCrossYOnTouch = NO;
            
            [self setNeedsDisplay];
        }
        
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
        //限制为单指十字线
        if (self.displayCrossXOnTouch == YES && self.displayCrossYOnTouch == YES) {
            self.displayCrossXOnTouch = NO;
            self.displayCrossYOnTouch = NO;
            
            [self setNeedsDisplay];
        }
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
            CCFloat stickWidth = [self getDataStickWidth];
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
            CCFloat stickWidth = 1.0 * [self getDataStickWidth];
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

- (void) moveLeft {
    
    if (self.displayNumber < self.minDisplayNumber){
        return;
    }
    if (self.displayFrom < 2) {
        self.displayFrom = 0;
    }else{
        self.displayFrom = self.displayFrom - 2;
    }
    
    //    if (self.displayFrom > 2) {
    //        self.displayFrom = self.displayFrom - 2;
    //    }
    
    if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartDisplayChangedFrom:from:number:)]) {
        [self.chartDelegate CCSChartDisplayChangedFrom:self from:self.displayFrom number:self.displayNumber];
    }
    
}

- (void) moveRight {
    
    if (self.displayNumber < self.minDisplayNumber){
        return;
    }
    if ([self getDisplayTo] + 2 > self.maxDisplayNumber) {
        if(self.displayFrom == self.maxDisplayNumber - self.displayNumber){
        }else{
            self.displayFrom = self.maxDisplayNumber - self.displayNumber;
        }
    }else{
        self.displayFrom = self.displayFrom + 2;
    }
    
    //    if ([self getDisplayTo] + 2 < [self.stickData count]) {
    //        self.displayFrom = self.displayFrom + 2;
    //    }
    
    if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartDisplayChangedFrom:from:number:)]) {
        [self.chartDelegate CCSChartDisplayChangedFrom:self from:self.displayFrom number:self.displayNumber];
    }
}

- (void)zoomOut {
    CCSTitledLine *line = [self.linesData objectAtIndex:0];
    
    if (self.displayNumber > self.minDisplayNumber) {
        
        if (self.displayNumber == self.minDisplayNumber){
            
        }else {
            CCInt resultDisplayNumber = self.displayNumber - 2;
            CCInt resultDisplayFrom = self.displayFrom + 2 / 2;
            
            if (resultDisplayNumber <= self.minDisplayNumber) {
                self.displayNumber = self.minDisplayNumber;
            } else {
                self.displayNumber = resultDisplayNumber;
            }
            
            if (resultDisplayFrom >= self.maxDisplayNumber - self.minDisplayNumber){
                self.displayFrom = self.maxDisplayNumber - self.minDisplayNumber;
            }else{
                self.displayFrom = resultDisplayFrom;
            }
        }
        
        //处理displayNumber越界
        if (self.displayNumber < self.minDisplayNumber) {
            self.displayNumber = self.minDisplayNumber;
        }
        
        //处理displayFrom越界
        if ([self getDisplayTo] >= [line.data count]) {
            self.displayFrom = [line.data count] - self.displayNumber;
        }
        
        if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartDisplayChangedFrom:from:number:)]) {
            [self.chartDelegate CCSChartDisplayChangedFrom:self from:self.displayFrom number:self.displayNumber];
        }
        
    }
}

- (void)zoomIn {
    
    CCSTitledLine *line = [self.linesData objectAtIndex:0];
    
    if (self.displayNumber < self.minDisplayNumber) {
        return;
    }
    if (self.displayNumber < [line.data count] - 1) {
        if (self.displayFrom ==0 && self.displayNumber == self.maxDisplayNumber){
        }else {
            CCInt resultDisplayNumber = self.displayNumber + 2;
            CCInt resultDisplayFrom = self.displayFrom - 2 / 2;
            
            if (resultDisplayFrom <= 0) {
                self.displayFrom = 0;
                if (resultDisplayNumber >= self.maxDisplayNumber) {
                    self.displayNumber = self.maxDisplayNumber;
                } else {
                    self.displayNumber = resultDisplayNumber;
                }
            } else {
                self.displayFrom = resultDisplayFrom;
                if (resultDisplayNumber >= self.maxDisplayNumber) {
                    self.displayNumber = self.maxDisplayNumber;
                    self.displayFrom = 0;
                } else{
                    if(resultDisplayFrom + resultDisplayNumber >= self.maxDisplayNumber){
                        self.displayNumber = resultDisplayNumber;
                        self.displayFrom = self.maxDisplayNumber - resultDisplayNumber;
                    } else{
                        self.displayNumber = resultDisplayNumber;
                    }
                }
            }
        }
        
        if ([self getDisplayTo] >= [line.data count]) {
            self.displayNumber = [line.data count] - self.displayFrom;
        }
        
        if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartDisplayChangedFrom:from:number:)]) {
            [self.chartDelegate CCSChartDisplayChangedFrom:self from:self.displayFrom number:self.displayNumber];
        }
        
    }
}

- (void) setDisplayFrom:(CCInt)displayFrom
{
//    if (displayFrom > 0 && displayFrom < self.maxDisplayNumber - self.minDisplayNumber) {
//        if (displayFrom + self.displayNumber <= self.maxDisplayNumber) {
//            _displayFrom = displayFrom;
//       }
//    }
    
    if(displayFrom > 0){
        _displayFrom = displayFrom;
    }
}

-(void) setDisplayNumber:(CCInt)displayNumber
{
    
//    if (displayNumber > 0 && displayNumber >= self.minDisplayNumber && displayNumber <= self.maxDisplayNumber) {
//        if (self.displayFrom + displayNumber <= self.maxDisplayNumber) {
//            _displayNumber = displayNumber;
//        }
//    }
    
    if(displayNumber > 0){
        _displayNumber = displayNumber;
    }
}

- (void) setLinesData:(NSArray *)linesData
{
    if (linesData == nil) {
        NSLog(@"Lines data is nil");
        return;
    }
        
    CCSTitledLine *line = [linesData objectAtIndex:0];
    if (line == nil) {
        NSLog(@"First line is nil");
        return;
    }
    if (line.data == nil) {
        NSLog(@"First line data is nil");
        return;
    }
    
    CCInt datasize = [line.data count];
    if (datasize == 0) {
        NSLog(@"data size is Zero");
        return;
    }
    
     _linesData = linesData;
    
    if (self.minDisplayNumber > datasize) {
        self.maxDisplayNumber = datasize;
        self.displayFrom = 0;
        self.displayNumber = datasize;
    }else{
        //右侧显示
        self.displayFrom = datasize - self.displayNumber;
        self.maxDisplayNumber = datasize;
    }
    
//    self.maxValue = CCIntMin;
//    self.minValue = CCIntMax;
}

-(CCInt) getDataDisplayNumber{
    return self.displayNumber > self.minDisplayNumber ? self.displayNumber:self.self.minDisplayNumber;
}

-(CCInt) getDisplayTo{
    return self.displayFrom + self.displayNumber;
}

-(CGFloat) getStickWidth{
    return (self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber;
}

-(CGFloat) getDataStickWidth{
    return (self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / [self getDataDisplayNumber];
}

-(void) bindSelectedIndex
{
    CCFloat stickWidth = [self getDataStickWidth];
    _singleTouchPoint = CGPointMake(self.axisMarginLeft +(self.selectedIndex - self.displayFrom + 0.5) * stickWidth, self.singleTouchPoint.y);
}

-(void) bindSelectedIndex
{
    CCFloat stickWidth = ((self.frame.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
    _singleTouchPoint = CGPointMake(self.axisMarginLeft +(self.selectedIndex - self.displayFrom + 0.5) * stickWidth, self.singleTouchPoint.y);
}

@end
