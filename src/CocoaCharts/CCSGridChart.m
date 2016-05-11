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
@synthesize latitudeNum = _latitudeNum;
@synthesize longitudeNum = _longitudeNum;
@synthesize longitudeFont = _longitudeFont;
@synthesize latitudeFont = _latitudeFont;
@synthesize crossLinesFont = _crossLinesFont;
@synthesize axisMarginLeft = _axisMarginLeft;
@synthesize axisMarginBottom = _axisMarginBottom;
@synthesize axisMarginTop = _axisMarginTop;
@synthesize axisMarginRight = _axisMarginRight;
@synthesize longitudeFontSize = _longitudeFontSize;
@synthesize latitudeFontSize = _latitudeFontSize;
@synthesize crossLinesFontSize = _crossLinesFontSize;
@synthesize axisXPosition = _axisXPosition;
@synthesize axisYPosition = _axisYPosition;
@synthesize displayLatitudeTitle = _displayLatitudeTitle;
@synthesize displayLeftLatitudeTitle = _displayLeftLatitudeTitle;
@synthesize displayRightLatitudeTitle = _displayRightLatitudeTitle;
@synthesize displayLongitudeTitle = _displayLongitudeTitle;
@synthesize displayLongitude = _displayLongitude;
@synthesize dashLongitude = _dashLongitude;
@synthesize displayLatitude = _displayLatitude;
@synthesize dashLatitude = _dashLatitude;
@synthesize displayBorder = _displayBorder;
@synthesize displayCrossXOnTouch = _displayCrossXOnTouch;
@synthesize displayCrossYOnTouch = _displayCrossYOnTouch;
@synthesize displayXDegreeOnTouch = _displayXDegreeOnTouch;
@synthesize displayYDegreeOnTouch = _displayYDegreeOnTouch;
@synthesize autoCalcLatitudeTitle = _autoCalcLatitudeTitle;
@synthesize autoCalcLongitudeTitle = _autoCalcLongitudeTitle;
@synthesize singleTouchPoint = _singleTouchPoint;
@synthesize dashCrossLines = _dashCrossLines;
@synthesize crossLinesColor = _crossLinesColor;
@synthesize crossLinesFontColor = _crossLinesFontColor;
@synthesize noneDisplayValues = _noneDisplayValues;
@synthesize chartDelegate = _chartDelegate;


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
    self.dashCrossLines = YES;
    self.crossLinesColor = [UIColor grayColor];
    self.crossLinesFontColor = [UIColor whiteColor];
    self.longitudeFontSize = 10;
    self.latitudeFontSize = 10;
    self.latitudeNum = 2;
    self.longitudeNum = 3;
    self.crossLinesFontSize = 10;
    self.longitudeFont = [UIFont systemFontOfSize:self.longitudeFontSize];
    self.latitudeFont = [UIFont systemFontOfSize:self.latitudeFontSize];
    self.crossLinesFont = [UIFont systemFontOfSize:self.crossLinesFontSize];
    self.axisMarginLeft = 3;
    self.axisMarginBottom = 16;
    self.axisMarginTop = 3;
    self.axisMarginRight = 3;
    self.axisXPosition = CCSGridChartXAxisPositionBottom;
    self.axisYPosition = CCSGridChartYAxisPositionLeft;
    self.displayLatitudeTitle = YES;
    self.displayLeftLatitudeTitle = YES;
    self.displayRightLatitudeTitle = YES;
    self.displayLongitudeTitle = YES;
    self.displayLongitude = YES;
    self.displayLatitude = YES;
    self.dashLongitude = NO;
    self.dashLatitude = NO;
    self.displayBorder = YES;
    self.displayCrossXOnTouch = NO;
    self.displayCrossYOnTouch = NO;
    self.displayXDegreeOnTouch = YES;
    self.displayYDegreeOnTouch = YES;
    self.autoCalcLatitudeTitle = YES;
    self.autoCalcLongitudeTitle = YES;

    //初期化X轴
    self.latitudeTitles = nil;
    //初期化X轴
    self.longitudeTitles = nil;
    //设置可以多点触控
    self.multipleTouchEnabled = YES;
    self.userInteractionEnabled = YES;
    
    self.noneDisplayValues = [NSMutableArray arrayWithObjects:@"0", nil];

    [self registerObservers];
}

- (void)registerObservers {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setNeedsDisplay) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)removeObservers {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void) drawData:(CGRect)rect{
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
//    [self drawYAxis:rect];

    //绘制纬线
    [self drawLatitudeLines:rect];
    //绘制经线
    [self drawLongitudeLines:rect];
    //绘制数据
    [self drawData:rect];
    //绘制X轴标题
    [self drawXAxisTitles:rect];
    //绘制Y轴标题
    [self drawYAxisTitles:rect];

    [self drawCrossLines:rect];
    
}

- (void)drawBorder:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);

    CGContextMoveToPoint(context, 0.0f, 0.0f);
    CGContextAddRect(context, rect);

    CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
    CGContextStrokePath(context);
}


- (void)drawXAxis:(CGRect)rect {
    if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);

        CGContextMoveToPoint(context, 0.0f, rect.size.height - self.axisMarginBottom);
        CGContextAddLineToPoint(context, rect.size.width, rect.size.height - self.axisMarginBottom);

        CGContextSetStrokeColorWithColor(context, self.axisXColor.CGColor);
        CGContextStrokePath(context);
    } else {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);

        CGContextMoveToPoint(context, 0.0f, self.axisMarginTop);
        CGContextAddLineToPoint(context, rect.size.width, self.axisMarginTop);

        CGContextSetStrokeColorWithColor(context, self.axisXColor.CGColor);
        CGContextStrokePath(context);
    }
}

- (void)drawYAxis:(CGRect)rect {
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);

        CGContextMoveToPoint(context, self.axisMarginLeft, 0.0f);
        CGContextAddLineToPoint(context, self.axisMarginLeft, rect.size.height - self.axisMarginBottom);

        CGContextSetStrokeColorWithColor(context, self.axisYColor.CGColor);
        CGContextStrokePath(context);
    }
    else {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, 1.0f);

        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            CGContextMoveToPoint(context, rect.size.width - self.axisMarginRight, 0.0f);
            CGContextAddLineToPoint(context, rect.size.width - self.axisMarginRight, rect.size.height - self.axisMarginBottom);
        } else {
            CGContextMoveToPoint(context, rect.size.width - self.axisMarginRight, self.axisMarginTop);
            CGContextAddLineToPoint(context, rect.size.width - self.axisMarginRight, rect.size.height);
        }

        CGContextSetStrokeColorWithColor(context, self.axisYColor.CGColor);
        CGContextStrokePath(context);
    }
}

- (void)drawLatitudeLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.latitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.latitudeFontColor.CGColor);
    
    if (self.displayLatitude == NO) {
        return;
    }
    
    if ([self.latitudeTitles count] <= 0){
        return ;
    }
    //设置线条为点线
    if (self.dashLatitude) {
        CGFloat lengths[] = {3.0, 3.0};
        CGContextSetLineDash(context, 0.0, lengths, 2);
    }
    
    CCFloat postOffset;
    if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
        postOffset = (rect.size.height - self.axisMarginBottom - 2 * self.axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    }
    else {
        postOffset = (rect.size.height - 2 * self.axisMarginBottom - self.axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    }
    
    CCFloat offset = rect.size.height - self.axisMarginBottom - self.axisMarginTop;
    
    for (CCUInt i = 0; i <= [self.latitudeTitles count]; i++) {
        CGContextMoveToPoint(context, 0, offset - i * postOffset);
        CGContextAddLineToPoint(context, rect.size.width , offset - i * postOffset);
    }
    CGContextStrokePath(context);
    //还原线条
    CGContextSetLineDash(context, 0, nil, 0);
}

- (void)drawYAxisTitles:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.latitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.latitudeFontColor.CGColor);
    
    if (self.displayLatitude == NO) {
        return;
    }
    
    if (self.displayLatitudeTitle == NO) {
        return;
    }
    
    if ([self.latitudeTitles count] <= 0) {
        return;
    }
    
    CCFloat postOffset;
    if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
        postOffset = (rect.size.height - self.axisMarginBottom - 2 * self.axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    } else {
        postOffset = (rect.size.height - 2 * self.axisMarginBottom - self.axisMarginTop) * 1.0 / ([self.latitudeTitles count] - 1);
    }
    
    CCFloat offset = rect.size.height - self.axisMarginBottom - self.axisMarginTop;
    
    for (CCUInt i = 0; i < [self.latitudeTitles count]; i++) {
        // 左侧
        // 绘制线条
        NSString *valueStr = (NSString *) [self.latitudeTitles objectAtIndex:i];
        UIFont *textFont= self.latitudeFont; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:self.latitudeFontColor};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        
        if(self.displayLeftLatitudeTitle){
            textStyle.alignment=NSTextAlignmentLeft;
            //调整Y轴坐标位置
            if (i == 0) {
                CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else if (i == [self.latitudeTitles count] - 1) {
                CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset, textSize.width, textSize.height);
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else {
                CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset - textSize.height - 1 ,textSize.width, textSize.height);
                [valueStr drawInRect:textRect withAttributes:attrs];
            }
        }
        
        if(self.displayRightLatitudeTitle){
            textStyle.alignment=NSTextAlignmentRight;
            //绘制右侧
            //调整Y轴坐标位置
            if (i == 0) {
                CGRect textRect= CGRectMake(rect.size.width - textSize.width - self.axisMarginRight, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else if (i == [self.latitudeTitles count] - 1) {
                CGRect textRect= CGRectMake(rect.size.width - textSize.width - self.axisMarginRight, offset - i * postOffset, textSize.width, textSize.height);
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else {
                CGRect textRect= CGRectMake(rect.size.width - textSize.width - self.axisMarginRight, offset - i * postOffset - textSize.height - 1, textSize.width, textSize.height);
                //绘制字体//
                [valueStr drawInRect:textRect withAttributes:attrs];
            }
        }
    }
}

- (void)drawLongitudeLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    CGContextSetFillColorWithColor(context, self.longitudeFontColor.CGColor);
    
    if (self.displayLongitude == NO) {
        return;
    }

    if (self.longitudeNum <= 0){
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
    
    
    postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.longitudeNum;
    offset = self.axisMarginLeft;
    
    for (CCUInt i = 0; i <= self.longitudeNum ; i++) {
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
    
    postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.longitudeNum;
    offset = self.axisMarginLeft ;
    
    for (CCUInt i = 0; i < [self.longitudeTitles count] && i <= self.longitudeNum; i++) {
        
        // 绘制线条
        NSString *valueStr = (NSString *) [self.longitudeTitles objectAtIndex:i];
        UIFont *textFont= self.longitudeFont; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                NSParagraphStyleAttributeName:textStyle,
                                NSForegroundColorAttributeName:self.longitudeFontColor};
        CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                 options:NSStringDrawingUsesLineFragmentOrigin
                                              attributes:attrs
                                                 context:nil].size;
        
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            //调整X轴坐标位置
            if (i == 0) {
                CGRect textRect= CGRectMake(0, rect.size.height - self.axisMarginBottom, postOffset, textSize.height);
                textStyle.alignment=NSTextAlignmentLeft;
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
                
            } else if (i == self.longitudeNum) {
                CGRect textRect= CGRectMake(rect.size.width - postOffset, rect.size.height - self.axisMarginBottom, postOffset, textSize.height);
                textStyle.alignment=NSTextAlignmentRight;
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else {
                CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, rect.size.height - self.axisMarginBottom, postOffset, textSize.height);
                textStyle.alignment=NSTextAlignmentCenter;
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            }
        } else {
            //调整X轴坐标位置
            if (i == 0) {
                CGRect textRect= CGRectMake(0, 0, postOffset, textSize.height);
                textStyle.alignment=NSTextAlignmentLeft;
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else if (i == self.longitudeNum) {
                CGRect textRect= CGRectMake(rect.size.width - postOffset, 0, postOffset, textSize.height);
                textStyle.alignment=NSTextAlignmentRight;
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
            } else {
                CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, 0, postOffset, textSize.height);
                textStyle.alignment=NSTextAlignmentCenter;
                //绘制字体
                [valueStr drawInRect:textRect withAttributes:attrs];
      
            }
        }
    }
}

- (void)drawCrossLines:(CGRect)rect {
    
    //过滤非显示区域的点
    if (self.singleTouchPoint.x < self.axisMarginLeft ||
        self.singleTouchPoint.y < self.axisMarginTop ||
        self.singleTouchPoint.x > rect.size.width - self.axisMarginRight ||
        self.singleTouchPoint.y > rect.size.height - self.axisMarginBottom) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetStrokeColorWithColor(context, self.crossLinesColor.CGColor);
    CGContextSetFillColorWithColor(context, self.crossLinesColor.CGColor);

    //设置线条为点线
    if (self.dashCrossLines) {
        CGFloat lengths[] = {2.0, 2.0};
        CGContextSetLineDash(context, 0.0, lengths, 1);
    }
    
    
    //绘制横线
    if (self.displayCrossXOnTouch) {
        
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            //还原半透明
            CGContextSetAlpha(context, 1);
            
            CGContextMoveToPoint(context, self.singleTouchPoint.x, 0);
            CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height - self.axisMarginBottom);
            
            //绘制线条
            CGContextStrokePath(context);
            
            if(self.displayXDegreeOnTouch){
                // 绘制线条
                NSString *valueStr = [self calcAxisXGraduate:rect];
                UIFont *textFont= self.crossLinesFont; //设置字体
                NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                textStyle.alignment=NSTextAlignmentCenter;
                
                NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                        NSParagraphStyleAttributeName:textStyle,
                                        NSForegroundColorAttributeName:self.crossLinesFontColor};
                CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:attrs
                                                         context:nil].size;
                CGRect boxRect = CGRectMake(self.singleTouchPoint.x - textSize.width / 2.0, 1, textSize.width, textSize.height);
                
                CGContextAddRect(context,boxRect);
                CGContextFillPath(context);
                
                [valueStr drawInRect:boxRect withAttributes:attrs];
            }
        }
        else{
            //还原半透明
            CGContextSetAlpha(context, 1);
            
            CGContextMoveToPoint(context, self.singleTouchPoint.x, self.axisMarginTop);
            CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height);
            
            //绘制线条
            CGContextStrokePath(context);
            
            if(self.displayXDegreeOnTouch){
                // 绘制线条
                NSString *valueStr = [self calcAxisXGraduate:rect];
                UIFont *textFont= self.crossLinesFont; //设置字体
                NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                textStyle.alignment=NSTextAlignmentCenter;
                
                NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                        NSParagraphStyleAttributeName:textStyle,
                                        NSForegroundColorAttributeName:self.crossLinesFontColor};
                CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                         options:NSStringDrawingUsesLineFragmentOrigin
                                                      attributes:attrs
                                                         context:nil].size;
                CGRect boxRect = CGRectMake(self.singleTouchPoint.x - textSize.width / 2.0, 1, textSize.width, textSize.height);
                
                CGContextAddRect(context,boxRect);
                CGContextFillPath(context);
                
                [valueStr drawInRect:boxRect withAttributes:attrs];
            }

        }
        
    }
    
    CGContextSetStrokeColorWithColor(context, self.crossLinesColor.CGColor);
    CGContextSetFillColorWithColor(context, self.crossLinesColor.CGColor);
    
    //绘制纵线与刻度
    if (self.displayCrossYOnTouch) {
        
        //还原半透明
        CGContextSetAlpha(context, 1);
        
        CGContextMoveToPoint(context, 0, self.singleTouchPoint.y);
        CGContextAddLineToPoint(context, rect.size.width, self.singleTouchPoint.y);
        
        //绘制线条
        CGContextStrokePath(context);
        
        if(self.displayYDegreeOnTouch){
            // 绘制线条
            NSString *valueStr = [self calcAxisYGraduate:rect];
            UIFont *textFont= self.crossLinesFont; //设置字体
            NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            textStyle.alignment=NSTextAlignmentLeft;
            
            NSDictionary *attrs = @{NSFontAttributeName:textFont,
                                    NSParagraphStyleAttributeName:textStyle,
                                    NSForegroundColorAttributeName:self.crossLinesFontColor};
            CGSize textSize = [valueStr boundingRectWithSize:CGSizeMake(100, 100)
                                                     options:NSStringDrawingUsesLineFragmentOrigin
                                                  attributes:attrs
                                                     context:nil].size;
            CGRect boxRect = CGRectMake(1, self.singleTouchPoint.y - textSize.height / 2.0, textSize.width, textSize.height);
            
            CGContextAddRect(context,boxRect);
            CGContextFillPath(context);
            
            [valueStr drawInRect:boxRect withAttributes:attrs];
        }
        
    }
    
    
     CGContextSetLineDash(context, 0, nil, 0);
}


- (NSString *)calcAxisXGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisXValue:rect]];
}

- (NSString *)calcAxisYGraduate:(CGRect)rect {
    return [NSString stringWithFormat:@"%f", [self touchPointAxisYValue:rect]];
}


- (CCFloat )touchPointAxisXValue:(CGRect)rect {
    CCFloat length = rect.size.width - self.axisMarginLeft - self.axisMarginRight;
    CCFloat valueLength = self.singleTouchPoint.x - self.axisMarginLeft ;
    return valueLength / length;
}

- (CCFloat )touchPointAxisYValue:(CGRect)rect {
    if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
        CCFloat length = rect.size.height - self.axisMarginBottom - 2 * self.axisMarginTop;
        CCFloat valueLength = length - self.singleTouchPoint.y + self.axisMarginTop;

        return valueLength / length;
    }
    else {
        CCFloat length = rect.size.height - 2 * self.axisMarginBottom - self.axisMarginTop;
        CCFloat valueLength = length - self.singleTouchPoint.y - self.axisMarginBottom;

        return valueLength / length;
    }
}


CCFloat _startDistance = 0;
CCFloat _minDistance = 8;

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

        _startDistance = fabs(pt1.x - pt2.x);
    } else {

    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesMoved:touches withEvent:event];

    NSArray *allTouches = [touches allObjects];
    //处理点击事件
    if ([allTouches count] == 1) {
        //获取选中点
        self.singleTouchPoint = [[allTouches objectAtIndex:0] locationInView:self];
        //设置可滚动
        [self performSelector:@selector(setNeedsDisplay) withObject:nil afterDelay:0];
    } else if ([allTouches count] == 2) {
        CGPoint pt1 = [[allTouches objectAtIndex:0] locationInView:self];
        CGPoint pt2 = [[allTouches objectAtIndex:1] locationInView:self];

        CCFloat endDistance = fabs(pt1.x - pt2.x);
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

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //调用父类的触摸事件
    [super touchesEnded:touches withEvent:event];

    _startDistance = 0;

    [self setNeedsDisplay];
}

- (void)zoomOut {
    // noop
}

- (void)zoomIn {
    // noop
}

- (void)moveLeft{
    // noop
}

- (void)moveRight{
    // noop
}

-(BOOL) isNoneDisplayValue:(CCFloat)value{
    if (self.noneDisplayValues == nil){
        return false;
    }
    if ([self.noneDisplayValues count] == 0){
        return false;
    }
    for(int i = 0 ; i < [self.noneDisplayValues count]; i++){
        if (value - [[self.noneDisplayValues objectAtIndex:i]doubleValue] == 0){
            return true;
        }
    }
    return false;
}

- (void)CCSChartDidTouched:(CGPoint *)point {
    //noop
}

- (void) setSingleTouchPoint:(CGPoint) point
{
    _singleTouchPoint = point;
}

@end
