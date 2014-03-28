//
//  CCSGridChart.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-24.
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

#import "CCSGridChart.h"

@implementation CCSGridChart

@synthesize latitudeTitles = _latitudeTitles;
@synthesize longitudeTitles = _longitudeTitles;
@synthesize axisXColor = _axisXColor;
@synthesize axisYColor = _axisYColor;
@synthesize longitudeColor = _longitudeColor;
@synthesize latitudeColor = _latitudeColor;
@synthesize borderColor = _borderColor;
@synthesize longitudeFontColor = _longitudeFontColor;
@synthesize latitudeFontColor = _latitudeFontColor;
@synthesize longitudeFont = _longitudeFont;
@synthesize latitudeFont = _latitudeFont;
//@synthesize axisMarginLeft = _axisMarginLeft;
//@synthesize axisMarginBottom = _axisMarginBottom;
//@synthesize axisMarginTop = _axisMarginTop;
//@synthesize axisMarginRight = _axisMarginRight;
@synthesize axisYTitleQuadrantWidth = _axisYTitleQuadrantWidth;
@synthesize axisXTitleQuadrantHeight = _axisXTitleQuadrantHeight;
@synthesize dataQuadrantPaddingTop = _dataQuadrantPaddingTop;
@synthesize dataQuadrantPaddingLeft = _dataQuadrantPaddingLeft;
@synthesize dataQuadrantPaddingBottom = _dataQuadrantPaddingBottom;
@synthesize dataQuadrantPaddingRight = _dataQuadrantPaddingRight;
@synthesize axisWidth = _axisWidth;
@synthesize borderWidth = _borderWidth;
@synthesize longitudeFontSize = _longitudeFontSize;
@synthesize latitudeFontSize = _latitudeFontSize;
@synthesize axisXPosition = _axisXPosition;
@synthesize axisYPosition = _axisYPosition;
@synthesize displayLatitudeTitle = _displayLatitudeTitle;
@synthesize displayLongitudeTitle = _displayLongitudeTitle;
@synthesize displayLongitude = _displayLongitude;
@synthesize dashLongitude = _dashLongitude;
@synthesize displayLatitude = _displayLatitude;
@synthesize dashLatitude = _dashLatitude;
@synthesize displayBorder = _displayBorder;
@synthesize displayCrossXOnTouch = _displayCrossXOnTouch;
@synthesize displayCrossYOnTouch = _displayCrossYOnTouch;
@synthesize singleTouchPoint = _singleTouchPoint;
@synthesize crossLinesColor = _crossLinesColor;
@synthesize crossLinesFontColor = _crossLinesFontColor;
@synthesize chartDelegate = _chartDelegate;

- (void)dealloc {

    [self removeObservers];

    [_latitudeTitles release];
    [_longitudeTitles release];
    [_axisXColor release];
    [_axisYColor release];
    [_longitudeColor release];
    [_latitudeColor release];
    [_borderColor release];
    [_longitudeFontColor release];
    [_latitudeFontColor release];
    [_crossLinesColor release];
    [_crossLinesFontColor release];
    [_longitudeFont release];
    [_latitudeFont release];
    [super dealloc];

}

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];

    //初始化相关属性
    self.axisXColor = [UIColor lightGrayColor];
    self.axisYColor = [UIColor lightGrayColor];
    self.borderColor = [UIColor lightGrayColor];
    self.longitudeColor = [UIColor lightGrayColor];
    self.latitudeColor = [UIColor lightGrayColor];
    self.longitudeFontColor = [UIColor lightGrayColor];
    self.latitudeFontColor = [UIColor lightGrayColor];
    self.crossLinesColor = [UIColor lightGrayColor];
    self.crossLinesFontColor = [UIColor whiteColor];
    self.longitudeFontSize = 11;
    self.latitudeFontSize = 11;
    self.longitudeFont = [UIFont systemFontOfSize:self.longitudeFontSize];
    self.latitudeFont = [UIFont systemFontOfSize:self.latitudeFontSize];
//    self.axisMarginLeft = 40;
//    self.axisMarginBottom = 16;
//    self.axisMarginTop = 3;
//    self.axisMarginRight = 1;
    self.axisYTitleQuadrantWidth = 40;
    self.axisXTitleQuadrantHeight = 16;
    self.dataQuadrantPaddingTop = 3;
    self.dataQuadrantPaddingLeft = 1;
    self.dataQuadrantPaddingBottom = 1;
    self.dataQuadrantPaddingRight = 1;
    self.axisWidth = 1;
    self.borderWidth = 1;
    self.axisXPosition = CCSGridChartXAxisPositionBottom;
    self.axisYPosition = CCSGridChartYAxisPositionRight;
    self.displayLatitudeTitle = YES;
    self.displayLongitudeTitle = YES;
    self.displayLongitude = YES;
    self.displayLatitude = YES;
    self.dashLongitude = YES;
    self.dashLatitude = YES;
    self.displayBorder = YES;
    self.displayCrossXOnTouch = YES;
    self.displayCrossYOnTouch = YES;

    //初期化X轴
    self.latitudeTitles = nil;
    //初期化X轴
    self.longitudeTitles = nil;
    //设置可以多点触控
    self.multipleTouchEnabled = YES;
    self.userInteractionEnabled = YES;

    [self registerObservers];
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)drawRect:(CGRect)rect {
    //清理当前画面，设置背景色
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    //消除锯齿
    CGContextSetAllowsAntialiasing(context, YES);

    //绘制边框
    [self drawBorder:rect];

    //绘制XY轴
    [self drawXAxis:rect];
    [self drawYAxis:rect];

    //绘制纬线
    [self drawLatitudeLines:rect];
    //绘制X轴标题
    [self drawXAxisTitles:rect];
    //绘制经线
    [self drawLongitudeLines:rect];
    //绘制Y轴标题
    [self drawYAxisTitles:rect];

    [self drawCrossLines:rect];
}

- (void)drawBorder:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, [self borderWidth] * 2);

    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddRect(context, rect);

    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextStrokePath(context);
}


- (void)drawXAxis:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context,[self axisWidth]);
    
    if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
        CGContextMoveToPoint(context, [self borderWidth], [self dataQuadrantEndY:rect]+[self axisWidth]/2);
        CGContextAddLineToPoint(context, rect.size.width - [self borderWidth], [self dataQuadrantEndY:rect]+[self axisWidth]/2);
    }else{
        CGContextMoveToPoint(context, [self borderWidth], [self dataQuadrantStartY:rect] - [self axisWidth]/2);
        CGContextAddLineToPoint(context, rect.size.width - [self borderWidth], [self dataQuadrantStartY:rect]- [self axisWidth]/2);
    }
    
    CGContextSetStrokeColorWithColor(context, self.axisXColor.CGColor);
    CGContextStrokePath(context);
}

- (void)drawYAxis:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, [self axisWidth]);
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        CGContextMoveToPoint(context, [self dataQuadrantStartX:rect]-[self axisWidth]/2, [self dataQuadrantStartY:rect]);
        CGContextAddLineToPoint(context, [self dataQuadrantStartX:rect]-[self axisWidth]/2, [self dataQuadrantEndY:rect]);

    } else {
        CGContextMoveToPoint(context, [self dataQuadrantEndX:rect]+[self axisWidth]/2, [self dataQuadrantStartY:rect]);
        CGContextAddLineToPoint(context, [self dataQuadrantEndX:rect]+[self axisWidth]/2, [self dataQuadrantEndY:rect]);

    }
    CGContextSetStrokeColorWithColor(context, self.axisYColor.CGColor);
    CGContextStrokePath(context);
}

- (void)drawLatitudeLines:(CGRect)rect {
    
    if (self.displayLatitude == NO) {
        return;
    }
    
    if ([self.latitudeTitles count] <= 0){
        return ;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.latitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.latitudeFontColor.CGColor);
    
    //设置线条为点线
    if (self.dashLatitude) {
        CGFloat lengths[] = {3.0, 3.0};
        CGContextSetLineDash(context, 0.0, lengths, 2);
    }
    
    CGFloat postOffset = [self dataQuadrantPaddingHeight:rect] / ([self.latitudeTitles count] - 1);
    CGFloat offset = [self dataQuadrantPaddingEndY:rect];
    
    for (NSUInteger i = 0; i < [self.latitudeTitles count]; i++) {
        CGContextMoveToPoint(context,[self dataQuadrantStartX:rect], offset - i * postOffset);
        CGContextAddLineToPoint(context, [self dataQuadrantEndX:rect], offset - i * postOffset);
    }
    CGContextStrokePath(context);
    //还原线条
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawYAxisTitles:(CGRect)rect {
    if (self.displayLatitude == NO) {
        return;
    }
    
    if (self.displayLatitudeTitle == NO) {
        return;
    }
    
    if ([self.latitudeTitles count] <= 0) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.latitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.latitudeFontColor.CGColor);
    
    CGFloat postOffset = [self dataQuadrantPaddingHeight:rect] / ([self.latitudeTitles count] - 1);
    CGFloat offset = [self dataQuadrantPaddingEndY:rect];
    
    for (NSUInteger i = 0; i < [self.latitudeTitles count]; i++) {
        CGFloat startX;
        NSInteger alignment;
        // 绘制线条
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            startX = [self borderWidth];
            alignment = NSTextAlignmentRight;
        }else{
            startX = rect.size.width - [self borderWidth] - [self axisYTitleQuadrantWidth];
            alignment = NSTextAlignmentLeft;
        }
        NSString *str = (NSString *) [self.latitudeTitles objectAtIndex:i];
        
        //处理成千分数形式
        NSNumberFormatter *decimalformatter = [[[NSNumberFormatter alloc] init]autorelease];
        decimalformatter.numberStyle = NSNumberFormatterDecimalStyle;
        
        str = [decimalformatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
        
        //调整Y轴坐标位置
        if (i == 0) {
            [str drawInRect:CGRectMake(startX, offset - i * postOffset - self.latitudeFontSize, [self axisYTitleQuadrantWidth], self.latitudeFontSize)
                   withFont:self.latitudeFont
              lineBreakMode:NSLineBreakByWordWrapping
                  alignment:alignment];
            
        } else if (i == [self.latitudeTitles count] - 1) {
            [str drawInRect:CGRectMake(startX, offset - i * postOffset, [self axisYTitleQuadrantWidth], self.latitudeFontSize)
                   withFont:self.latitudeFont
              lineBreakMode:NSLineBreakByWordWrapping
                  alignment:alignment];
            
        } else {
            [str drawInRect:CGRectMake(startX, offset - i * postOffset - self.latitudeFontSize / 2.0, [self axisYTitleQuadrantWidth], self.latitudeFontSize)
                   withFont:self.latitudeFont
              lineBreakMode:NSLineBreakByWordWrapping
                  alignment:alignment];
        }
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
    
    CGFloat postOffset= [self dataQuadrantPaddingWidth:rect] / ([self.longitudeTitles count] - 1);
    CGFloat offset = [self dataQuadrantPaddingStartX:rect];
    
    for (NSUInteger i = 0; i < [self.longitudeTitles count]; i++) {
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
    
    CGFloat postOffset= [self dataQuadrantPaddingWidth:rect] / ([self.longitudeTitles count] - 1);
    CGFloat offset = [self dataQuadrantPaddingStartX:rect];
    
    for (NSUInteger i = 0; i < [self.longitudeTitles count]; i++) {
        CGFloat startY;
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            startY = [self dataQuadrantEndY:rect] + [self axisWidth];
        }else{
            startY = [self borderWidth];
        }
        
        NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:i];
        
        //调整X轴坐标位置
        if (i == 0) {
            [str drawInRect:CGRectMake([self dataQuadrantPaddingStartX:rect], startY, postOffset, self.longitudeFontSize)
                   withFont:self.longitudeFont
              lineBreakMode:NSLineBreakByWordWrapping
                  alignment:NSTextAlignmentLeft];
            
        } else if (i == [self.longitudeTitles count] - 1) {
            if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
                [str drawInRect:CGRectMake(rect.size.width - postOffset, startY, postOffset, self.longitudeFontSize)
                       withFont:self.longitudeFont
                  lineBreakMode:NSLineBreakByWordWrapping
                      alignment:NSTextAlignmentRight];
            } else {
                [str drawInRect:CGRectMake(offset + (i - 0.5) * postOffset, startY, postOffset, self.longitudeFontSize)
                       withFont:self.longitudeFont
                  lineBreakMode:NSLineBreakByWordWrapping
                      alignment:NSTextAlignmentCenter];
            }
            
        } else {
            [str drawInRect:CGRectMake(offset + (i - 0.5) * postOffset, startY, postOffset, self.longitudeFontSize)
                   withFont:self.longitudeFont
              lineBreakMode:NSLineBreakByWordWrapping
                  alignment:NSTextAlignmentCenter];
        }
    }
}

- (void)drawCrossLines:(CGRect)rect {

    if (self.singleTouchPoint.y < [self dataQuadrantPaddingStartY:rect]) {
        self.singleTouchPoint = CGPointMake(self.singleTouchPoint.x, [self dataQuadrantPaddingStartY:rect]);
    }
    if (self.singleTouchPoint.y > [self dataQuadrantPaddingEndY:rect]) {
        self.singleTouchPoint = CGPointMake(self.singleTouchPoint.x, [self dataQuadrantPaddingEndY:rect]);
    }

    if (self.singleTouchPoint.x < [self dataQuadrantPaddingStartX:rect]) {
        self.singleTouchPoint = CGPointMake([self dataQuadrantPaddingStartX:rect], self.singleTouchPoint.y);
    }
    if (self.singleTouchPoint.x > [self dataQuadrantPaddingEndX:rect]) {
        self.singleTouchPoint = CGPointMake([self dataQuadrantPaddingEndX:rect], self.singleTouchPoint.y);
    }

    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.crossLinesColor.CGColor);
    CGContextSetFillColorWithColor(context, self.crossLinesColor.CGColor);
    
    //绘制横线
    if (self.displayCrossXOnTouch) {
        //还原半透明
        CGContextSetAlpha(context, 1);
        
        CGContextMoveToPoint(context, self.singleTouchPoint.x, [self dataQuadrantStartY:rect]);
        CGContextAddLineToPoint(context, self.singleTouchPoint.x, [self dataQuadrantEndY:rect]);
        
        CGContextStrokePath(context);
        
    }

    
    //绘制纵线与刻度
    if (self.displayCrossYOnTouch) {

        //还原半透明
        CGContextSetAlpha(context, 1);
        
        CGContextMoveToPoint(context, [self dataQuadrantStartX:rect], self.singleTouchPoint.y);
        CGContextAddLineToPoint(context, [self dataQuadrantEndX:rect], self.singleTouchPoint.y);
        
        CGContextStrokePath(context);
        
    }

//    CGContextSetFillColorWithColor(context,[UIColor blueColor].CGColor);
//    
//    NSString *degree = [NSString stringWithFormat:@"(%@,%@)",[self calcAxisXGraduate:rect],[self calcAxisYGraduate:rect]];
//    
//    //绘制标尺刻度
//    [degree drawInRect:CGRectMake([self borderWidth], [self borderWidth], 200, 14)
//              withFont:[UIFont fontWithName:@"Helvetica" size:self.longitudeFontSize]
//         lineBreakMode:UILineBreakModeTailTruncation
//             alignment:NSTextAlignmentLeft];
//    CGContextFillPath(context);

}


- (NSString *)calcAxisXGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisXValue:rect]];
}

- (NSString *)calcAxisYGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisYValue:rect]];
}


- (CGFloat)touchPointAxisXValue:(CGRect)rect {
    CGFloat length = [self dataQuadrantPaddingWidth:rect];
    CGFloat valueLength = self.singleTouchPoint.x - [self dataQuadrantPaddingStartX:rect];;
    return valueLength / length;
}

- (CGFloat)touchPointAxisYValue:(CGRect)rect {
    CGFloat length = [self dataQuadrantPaddingHeight:rect];
    CGFloat valueLength = length - self.singleTouchPoint.y + [self dataQuadrantPaddingStartY:rect];
    return valueLength / length;
}

CGFloat _startDistance = 0;
CGFloat _minDistance = 8;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesBegan:touches withEvent:event];

    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //重绘
        [self setNeedsDisplay];
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];

        _startDistance = fabsf(pt1.x - pt2.x);
    } else {

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesMoved:touches withEvent:event];

    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
//        if(fabs([[allTouches objectAtIndex:0]locationInView:self].x - self.singleTouchPoint.x) > 5)
//        {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //设置可滚动
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
//        }
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];

        CGFloat endDistance = fabsf(pt1.x - pt2.x);
        //放大
        if (endDistance - _startDistance > _minDistance) {
            [self zoomOut];
            _startDistance = endDistance;

            [self setNeedsDisplay];
        } else if (endDistance - _startDistance < -_minDistance) {
            [self zoomIn];
            _startDistance = endDistance;

            [self setNeedsDisplay];
        }

    } else {

    }

}


- (CGFloat) dataQuadrantWidth:(CGRect)rect{
    return rect.size.width - [self axisYTitleQuadrantWidth] - 2 * [self borderWidth]
            - [self axisWidth];
}

- (CGFloat) dataQuadrantHeight:(CGRect)rect{
    return rect.size.height - [self axisXTitleQuadrantHeight] - 2 * [self borderWidth]
            - [self axisWidth];
}

- (CGFloat) dataQuadrantStartX:(CGRect)rect{
    if ([self axisYPosition] == CCSGridChartYAxisPositionLeft) {
        return [self borderWidth] + [self axisYTitleQuadrantWidth] + [self axisWidth];
    } else {
        return [self borderWidth];
    }
}

- (CGFloat) dataQuadrantPaddingStartX:(CGRect)rect{
    return [self dataQuadrantStartX:rect] + [self dataQuadrantPaddingLeft];
}

- (CGFloat) dataQuadrantEndX:(CGRect)rect{
    if ([self axisYPosition] == CCSGridChartYAxisPositionLeft) {
        return rect.size.width - [self borderWidth];
    } else {
        return rect.size.width - [self borderWidth] - [self axisYTitleQuadrantWidth]
                - [self axisWidth];
    }
}

- (CGFloat) dataQuadrantPaddingEndX:(CGRect)rect{
    return [self dataQuadrantEndX:rect] - [self dataQuadrantPaddingRight];
}

- (CGFloat) dataQuadrantStartY:(CGRect)rect{
    if ([self axisXPosition] == CCSGridChartXAxisPositionBottom) {
        return [self borderWidth];
    }else{
        return [self borderWidth] + [self axisXTitleQuadrantHeight] + [self axisWidth];
    }
}

- (CGFloat) dataQuadrantPaddingStartY:(CGRect)rect{
    return [self dataQuadrantStartY:rect] + [self dataQuadrantPaddingTop];
}

- (CGFloat) dataQuadrantEndY:(CGRect)rect{
    if ([self axisXPosition] == CCSGridChartXAxisPositionBottom) {
        return rect.size.height - [self borderWidth] - [self axisXTitleQuadrantHeight]
            - [self axisWidth];
    }else{
        return rect.size.height - [self borderWidth];
    }
}

- (CGFloat) dataQuadrantPaddingEndY:(CGRect)rect{
    return [self dataQuadrantEndY:rect] - [self dataQuadrantPaddingTop];
}

- (CGFloat) dataQuadrantPaddingWidth:(CGRect)rect{
    return [self dataQuadrantWidth:rect] - [self dataQuadrantPaddingLeft]
            - [self dataQuadrantPaddingRight];
}

- (CGFloat) dataQuadrantPaddingHeight:(CGRect)rect{
    return [self dataQuadrantHeight:rect] - [self dataQuadrantPaddingTop]
            - [self dataQuadrantPaddingBottom];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesEnded:touches withEvent:event];

    _startDistance = 0;

    [self setNeedsDisplay];
}

- (void)zoomOut {
}

- (void)zoomIn {
}

- (void)CCSChartDidTouched:(CGPoint *)point {
}

- (void) setSingleTouchPoint:(CGPoint) point
{
    _singleTouchPoint = point;
    
    if (self.chartDelegate && [self.chartDelegate respondsToSelector:@selector(CCSChartBeTouchedOn:indexAt:)]) {
        [self.chartDelegate CCSChartBeTouchedOn:point indexAt:0];
    }
}


- (void) setAxisMarginLeft:(CGFloat)val{
    self.axisYTitleQuadrantWidth = val;
}

- (CGFloat) getAxisMarginLeft {
    return [self axisYTitleQuadrantWidth];
}

- (void) setAxisMarginRight:(CGFloat)val{
    self.dataQuadrantPaddingLeft = val;
    self.dataQuadrantPaddingRight = val;
}

- (CGFloat) getAxisMarginRight {
    return [self dataQuadrantPaddingLeft];
}

- (void) setAxisMarginBottom:(CGFloat)val{
    self.axisXTitleQuadrantHeight = val;
}

- (CGFloat) getAxisMarginBottom {
    return [self axisXTitleQuadrantHeight];
}

- (void) setAxisMarginTop:(CGFloat)val{
    self.dataQuadrantPaddingTop = val;
    self.dataQuadrantPaddingBottom = val;
}

- (CGFloat) getAxisMarginTop {
    return [self dataQuadrantPaddingTop];
}

- (void) setDataQuadrantPadding:(CGFloat)val {
    self.dataQuadrantPaddingTop = val;
    self.dataQuadrantPaddingBottom = val;
    self.dataQuadrantPaddingLeft = val;
    self.dataQuadrantPaddingRight = val;
}

- (CGFloat) getDataQuadrantPadding {
    return MAX(MAX([self dataQuadrantPaddingTop],[self dataQuadrantPaddingBottom]),MAX([self dataQuadrantPaddingLeft],[self dataQuadrantPaddingRight]));
}

@end
