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
@synthesize axisMarginLeft = _axisMarginLeft;
@synthesize axisMarginBottom = _axisMarginBottom;
@synthesize axisMarginTop = _axisMarginTop;
@synthesize axisMarginRight = _axisMarginRight;
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
@synthesize dashCrossLines = _dashCrossLines;
@synthesize crossLinesColor = _crossLinesColor;
@synthesize crossLinesFontColor = _crossLinesFontColor;
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
    self.crossLinesColor = [UIColor blackColor];
    self.crossLinesFontColor = [UIColor whiteColor];
    self.longitudeFontSize = 11;
    self.latitudeFontSize = 11;
    self.longitudeFont = [UIFont systemFontOfSize:self.longitudeFontSize];
    self.latitudeFont = [UIFont systemFontOfSize:self.latitudeFontSize];
    self.axisMarginLeft = 3;
    self.axisMarginBottom = 16;
    self.axisMarginTop = 3;
    self.axisMarginRight = 3;
    self.axisXPosition = CCSGridChartXAxisPositionBottom;
    self.axisYPosition = CCSGridChartYAxisPositionLeft;
    self.displayLatitudeTitle = YES;
    self.displayLongitudeTitle = YES;
    self.displayLongitude = YES;
    self.displayLatitude = YES;
    self.dashLongitude = NO;
    self.dashLatitude = NO;
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
//    [self drawYAxis:rect];

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
//        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
//            CGContextMoveToPoint(context, self.axisMarginLeft, offset - i * postOffset);
//            CGContextAddLineToPoint(context, rect.size.width, offset - i * postOffset);
//            
//        } else {
            CGContextMoveToPoint(context, 0, offset - i * postOffset);
            CGContextAddLineToPoint(context, rect.size.width , offset - i * postOffset);
//        }
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
    
    const int fixedLableWidth = 100;
    
    for (CCUInt i = 0; i <= [self.latitudeTitles count]; i++) {
        // 绘制线条
//        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            if (i < [self.latitudeTitles count]) {
                NSString *str = (NSString *) [self.latitudeTitles objectAtIndex:i];
                
                //处理成千分数形式
                NSNumberFormatter *decimalformatter = [[NSNumberFormatter alloc] init];
                decimalformatter.numberStyle = NSNumberFormatterDecimalStyle;
                
                str = [decimalformatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
                
                //调整Y轴坐标位置
                if (i == 0) {
                    CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset - self.latitudeFontSize - 1, fixedLableWidth, self.latitudeFontSize);
                    UIFont *textFont= self.latitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentLeft;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.latitudeFontColor}];
                } else if (i == [self.latitudeTitles count] - 1) {
                    
                    CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset, fixedLableWidth, self.latitudeFontSize);
                    UIFont *textFont= self.latitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentLeft;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.latitudeFontColor}];
                } else {
                    CGRect textRect= CGRectMake(self.axisMarginLeft, offset - i * postOffset - self.latitudeFontSize - 1 , fixedLableWidth, self.latitudeFontSize);
                    UIFont *textFont= self.latitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentLeft;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.latitudeFontColor}];
                }
                
            }
            
//        } else {
            if (i < [self.latitudeTitles count]) {
                NSString *str = (NSString *) [self.latitudeTitles objectAtIndex:i];
                
                //处理成千分数形式
                NSNumberFormatter *decimalformatter = [[NSNumberFormatter alloc] init];
                decimalformatter.numberStyle = NSNumberFormatterDecimalStyle;
                
                str = [decimalformatter stringFromNumber:[NSNumber numberWithDouble:[str doubleValue]]];
                
                //调整Y轴坐标位置
                if (i == 0) {
                    
                    CGRect textRect= CGRectMake(rect.size.width - fixedLableWidth - self.axisMarginRight, offset - i * postOffset - self.latitudeFontSize - 1, fixedLableWidth, self.latitudeFontSize);
                    UIFont *textFont= self.latitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentRight;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.latitudeFontColor}];
                    
                    
                } else if (i == [self.latitudeTitles count] - 1) {
                    
                    CGRect textRect= CGRectMake(rect.size.width - fixedLableWidth - self.axisMarginRight, offset - i * postOffset, fixedLableWidth, self.latitudeFontSize);
                    UIFont *textFont= self.latitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentRight;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.latitudeFontColor}];
                    
                } else {
                    
                    CGRect textRect= CGRectMake(rect.size.width - fixedLableWidth - self.axisMarginRight, offset - i * postOffset - self.latitudeFontSize - 1, fixedLableWidth, self.latitudeFontSize);
                    UIFont *textFont= self.latitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentRight;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
//
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.latitudeFontColor}];
                }
            }
//        }
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
    
//    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
//        postOffset = (rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / ([self.longitudeTitles count] - 1);
//        offset = self.axisMarginLeft + self.axisMarginRight;
//    }
//    else {
//        postOffset = (rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count] - 1);
//        offset = self.axisMarginLeft;
//    }
    
    
    postOffset = (rect.size.width - self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count] - 1);
    offset = self.axisMarginLeft;
    
    for (CCUInt i = 0; i <= [self.longitudeTitles count]; i++) {
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
    
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        postOffset = (rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight) / ([self.longitudeTitles count] - 1);
        offset = self.axisMarginLeft + self.axisMarginRight;
    } else {
        postOffset = (rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight) / ([self.longitudeTitles count] - 1);
        offset = self.axisMarginLeft;
    }
        
    for (CCUInt i = 0; i <= [self.longitudeTitles count]; i++) {
        if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
            if (i < [self.longitudeTitles count]) {
                NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:i];
                
                //调整X轴坐标位置
                if (i == 0) {
                    CGRect textRect= CGRectMake(0, rect.size.height - self.axisMarginBottom, postOffset, self.longitudeFontSize);
                    UIFont *textFont= self.longitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentLeft;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.longitudeFontColor}];
                    
                } else if (i == [self.longitudeTitles count] - 1) {
                    CGRect textRect= CGRectMake(rect.size.width - postOffset, rect.size.height - self.axisMarginBottom, postOffset, self.longitudeFontSize);
                    UIFont *textFont= self.longitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentRight;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    //绘制字体
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.longitudeFontColor}];
                } else {
                    CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, rect.size.height - self.axisMarginBottom, postOffset, self.longitudeFontSize);
                    UIFont *textFont= self.longitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentCenter;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    //绘制字体
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.longitudeFontColor}];
                }
            }
        } else {
            
            if (i < [self.longitudeTitles count]) {
                NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:i];
                
                //调整X轴坐标位置
                if (i == 0) {
                    CGRect textRect= CGRectMake(0, 0, postOffset, self.longitudeFontSize);
                    UIFont *textFont= self.longitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentLeft;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    //绘制字体
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.longitudeFontColor}];
                    
                } else if (i == [self.longitudeTitles count] - 1) {
                    CGRect textRect= CGRectMake(rect.size.width - postOffset, 0, postOffset, self.longitudeFontSize);
                    UIFont *textFont= self.longitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentRight;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    //绘制字体
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.longitudeFontColor}];
                } else {
                    CGRect textRect= CGRectMake(offset + (i - 0.5) * postOffset, 0, postOffset, self.longitudeFontSize);
                    UIFont *textFont= self.longitudeFont; //设置字体
                    NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                    textStyle.alignment=NSTextAlignmentCenter;
                    textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                    //绘制字体
//                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
                    //绘制字体
                    [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                              NSParagraphStyleAttributeName:textStyle,
                                                              NSForegroundColorAttributeName:self.longitudeFontColor}];
                }
            }
        }
    }
}

- (void)drawCrossLines:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.5f);
    CGContextSetStrokeColorWithColor(context, self.crossLinesColor.CGColor);
    CGContextSetFillColorWithColor(context, self.crossLinesColor.CGColor);

    //设置线条为点线
    if (self.dashCrossLines) {
        CGFloat lengths[] = {2.0, 2.0};
        CGContextSetLineDash(context, 0.0, lengths, 1);
    }

    if (self.axisXPosition == CCSGridChartXAxisPositionBottom) {
//        //界定点击有效范围
//        if (self.singleTouchPoint.x >= self.axisMarginLeft
//                && self.singleTouchPoint.y > 0
//                && self.singleTouchPoint.x < rect.size.width
//                && self.singleTouchPoint.y < rect.size.height - self.axisMarginBottom) {

//            //获得标尺刻度
//            NSString *meterY = [self calcAxisYGraduate:rect];
//            NSString *meterX = [self calcAxisXGraduate:rect];
//            
//            //处理成千分数形式
//            NSNumberFormatter *decimalformatter = [[NSNumberFormatter alloc]init];
//            decimalformatter.numberStyle = NSNumberFormatterDecimalStyle;
//            
//            meterY = [decimalformatter stringFromNumber:[NSNumber numberWithDouble:[meterY doubleValue]]];


            //绘制横线
            if (self.displayCrossXOnTouch) {
//                //设置半透明
//                CGContextSetAlpha(context, 0.7);
//                CGContextSetFillColorWithColor(context,self.crossLinesColor.CGColor);
//                //填充方框
//                CGContextAddRect(context,CGRectMake(self.singleTouchPoint.x -35, rect.size.height - self.axisMarginBottom + 1, 70, 14));
//                //绘制线条
//                CGContextFillPath(context);

                //还原半透明
                CGContextSetAlpha(context, 1);

                CGContextMoveToPoint(context, self.singleTouchPoint.x, 0);
                CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height - self.axisMarginBottom);

//                //绘制方框
//                CGContextAddRect(context,CGRectMake(self.singleTouchPoint.x -35, rect.size.height - self.axisMarginBottom + 1, 70, 14));
//                //绘制线条
                CGContextStrokePath(context);
//                
//                CGContextSetFillColorWithColor(context,self.crossLinesFontColor.CGColor);

//                //绘制标尺刻度
//                [meterX drawInRect:CGRectMake(self.singleTouchPoint.x -35, rect.size.height - self.axisMarginBottom + 1, 70, 12)
//                          withFont:[UIFont fontWithName:@"Helvetica" size:self.longitudeFontSize] 
//                     lineBreakMode:UILineBreakModeTailTruncation 
//                         alignment:NSTextAlignmentCenter];

            }

            //绘制纵线与刻度
            if (self.displayCrossYOnTouch) {
//                //设置半透明
//                CGContextSetAlpha(context, 0.7);
//                CGContextSetFillColorWithColor(context,self.crossLinesColor.CGColor);
//                //填充方框
//                CGContextAddRect(context,CGRectMake(1, self.singleTouchPoint.y - 6, self.axisMarginLeft-2, 14));
//                //绘制线条
//                CGContextFillPath(context);
                //还原半透明
                CGContextSetAlpha(context, 1);

                CGContextMoveToPoint(context, 0, self.singleTouchPoint.y);
                CGContextAddLineToPoint(context, rect.size.width, self.singleTouchPoint.y);

//                //绘制方框
//                CGContextAddRect(context,CGRectMake(1, self.singleTouchPoint.y - 6, self.axisMarginLeft-2, 14));
//                //绘制线条
                CGContextStrokePath(context);
//                
//                CGContextSetFillColorWithColor(context,self.crossLinesFontColor.CGColor);

//                [meterY drawInRect:CGRectMake(1, self.singleTouchPoint.y - 5, self.axisMarginLeft-2, 50)
//                          withFont:[UIFont fontWithName:@"Helvetica" size:self.latitudeFontSize]
//                     lineBreakMode:NSLineBreakByWordWrapping 
//                         alignment:NSTextAlignmentRight];

            }
//        }
 
    } else {
//        //界定点击有效范围
//        if (self.singleTouchPoint.x >= self.axisMarginLeft
//                && self.singleTouchPoint.y > self.axisMarginTop
//                && self.singleTouchPoint.x < rect.size.width
//                && self.singleTouchPoint.y < rect.size.height) {

//            //获得标尺刻度
//            NSString *meterY = [self calcAxisYGraduate:rect];
//            NSString *meterX = [self calcAxisXGraduate:rect];
//            
//            //处理成千分数形式
//            NSNumberFormatter *decimalformatter = [[NSNumberFormatter alloc]init];
//            decimalformatter.numberStyle = NSNumberFormatterDecimalStyle;
//            
//            meterY = [decimalformatter stringFromNumber:[NSNumber numberWithDouble:[meterY doubleValue]]];

            //绘制横线
            if (self.displayCrossXOnTouch) {
//                //设置半透明
//                CGContextSetAlpha(context, 0.7);
//                CGContextSetFillColorWithColor(context,self.crossLinesColor.CGColor);
//                //填充方框
//                CGContextAddRect(context,CGRectMake(self.singleTouchPoint.x -35, self.axisMarginTop + 1, 70, 14));
//                //绘制线条
//                CGContextFillPath(context);

                //还原半透明
                CGContextSetAlpha(context, 1);

                CGContextMoveToPoint(context, self.singleTouchPoint.x, self.axisMarginTop);
                CGContextAddLineToPoint(context, self.singleTouchPoint.x, rect.size.height);

//                //绘制方框
//                CGContextAddRect(context,CGRectMake(self.singleTouchPoint.x -35, self.axisMarginTop + 1, 70, 14));
//                //绘制线条
                CGContextStrokePath(context);
//                
//                CGContextSetFillColorWithColor(context,self.crossLinesFontColor.CGColor);

//                //绘制标尺刻度
//                [meterX drawInRect:CGRectMake(self.singleTouchPoint.x -35, self.axisMarginTop + 1, 70, 12)
//                          withFont:[UIFont fontWithName:@"Helvetica" size:self.longitudeFontSize] 
//                     lineBreakMode:UILineBreakModeTailTruncation 
//                         alignment:NSTextAlignmentCenter];
            }

            //绘制纵线与刻度
            if (self.displayCrossYOnTouch) {

//                //设置半透明
//                CGContextSetAlpha(context, 0.7);
//                CGContextSetFillColorWithColor(context,self.crossLinesColor.CGColor);
//                //填充方框
//                CGContextAddRect(context,CGRectMake(1, self.singleTouchPoint.y - 6, self.axisMarginLeft-2, 14));
//                //绘制线条
//                CGContextFillPath(context);
                //还原半透明
                CGContextSetAlpha(context, 1);

                CGContextMoveToPoint(context, 0, self.singleTouchPoint.y);
                CGContextAddLineToPoint(context, rect.size.width, self.singleTouchPoint.y);

//                //绘制方框
//                CGContextAddRect(context,CGRectMake(1, self.singleTouchPoint.y - 6, self.axisMarginLeft-2, 14));
//                //绘制线条
                CGContextStrokePath(context);
//                
//                CGContextSetFillColorWithColor(context,self.crossLinesFontColor.CGColor);

//                [meterY drawInRect:CGRectMake(1, self.singleTouchPoint.y - 5, self.axisMarginLeft-2, 50)
//                          withFont:[UIFont fontWithName:@"Helvetica" size:self.latitudeFontSize]
//                     lineBreakMode:NSLineBreakByWordWrapping 
//                         alignment:NSTextAlignmentRight];
            }
//        }

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
    if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
        CCFloat length = rect.size.width - self.axisMarginLeft - 2 * self.axisMarginRight;
        CCFloat valueLength = self.singleTouchPoint.x - self.axisMarginLeft - self.axisMarginRight;

        return valueLength / length;
    } else {
        CCFloat length = rect.size.width - 2 * self.axisMarginLeft - self.axisMarginRight;
        CCFloat valueLength = self.singleTouchPoint.x - self.axisMarginLeft;

        return valueLength / length;
    }
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

@end
