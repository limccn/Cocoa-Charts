//
//  CCSTickChart.m
//  CocoaChartsSample
//
//  Created by 李 明成 on 16/4/21.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSTickChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSTickChart

@synthesize longitudeSplitor = _longitudeSplitor;
@synthesize latitudeSplitor = _latitudeSplitor;
@synthesize lastClose = _lastClose;
@synthesize limitRangeSupport = _limitRangeSupport;
@synthesize limitMaxValue = _limitMaxValue;
@synthesize limitMinValue = _limitMinValue;
@synthesize enableZoom = _enableZoom;
@synthesize enableSlip = _enableSlip;

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    
    self.longitudeSplitor = [[NSArray alloc]init];
    self.latitudeSplitor = [[NSArray alloc]init];
    
    self.lastClose = 0;
    self.limitRangeSupport = NO;
    self.limitMaxValue = 0;
    self.limitMinValue = 0;
    self.enableSlip = YES;
    self.enableZoom = YES;
    
}

- (void)calcValueRange {
    if (self.linesData != NULL && [self.linesData count] > 0) {
        [self calcDataValueRange];
        [self calcValueRangePaddingZero];
    } else {
        self.maxValue = 0;
        self.minValue = 0;
    }
    
    //    [self calcValueRangeFormatForAxis];
    
    if (self.balanceRange) {
        [self calcBalanceRange];
    }
    
    if (self.limitRangeSupport) {
        [self calcLimitRange];
    }
}

- (void) calcBalanceRange{
    if(self.lastClose > 0 && self.maxValue > 0 && self.minValue > 0){
        CCFloat gap = MAX(fabs(self.maxValue - self.lastClose),fabs(self.minValue - self.lastClose));
        self.maxValue = self.lastClose + gap;
        self.minValue = self.lastClose - gap;

    }
}

- (void) calcLimitRange{
    if (self.limitMinValue >= 0 && self.limitMaxValue >= 0) {
        if(self.maxValue > self.limitMaxValue){
            self.maxValue = self.limitMaxValue;
        }
        if(self.minValue < self.limitMinValue){
            self.minValue = self.limitMinValue;
        }
    }
}

- (void)initAxisX {
    if (self.autoCalcLongitudeTitle == NO) {
        return;
    }
    NSMutableArray *TitleX = [[NSMutableArray alloc] init];
    if (self.linesData != NULL && [self.linesData count] > 0 && self.displayNumber > 0) {
        //以第1条线作为X轴的标示
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if ([line.data count] > 0 && [self.longitudeSplitor count] >0) {
            
            CCUInt counter = 0;
            do{
                for(CCUInt i = 0; i < [self.longitudeSplitor count] ;i++){
                    CCUInt index = counter;
                    if (index > self.displayNumber -1) {
                        index =  self.displayNumber - 1;
                    }
                    CCSLineData *lineData = [line.data objectAtIndex:index];
                    [TitleX addObject:[NSString stringWithFormat:@"%@", lineData.date]];
                    //计数器重新设置
                    counter = counter + [[self.longitudeSplitor objectAtIndex:i] integerValue];
                }
            }while(counter < self.displayNumber);
        }
    }
    self.longitudeTitles = TitleX;
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
    
    CCFloat lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
    CCFloat offset = self.axisMarginLeft + lineLength / 2;;

    CCUInt counter = 0;
    do{
        for(CCUInt i=0; i < [self.longitudeSplitor count] ;i++){
            CGContextMoveToPoint(context, offset + counter * lineLength, 0);
            CGContextAddLineToPoint(context, offset + counter * lineLength, rect.size.height - self.axisMarginBottom);
            CGContextStrokePath(context);
            //计数器重新设置
            counter = counter + [[self.longitudeSplitor objectAtIndex:i] integerValue];
        }
        
    }while(counter < self.displayNumber);
    
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
    
    if (self.longitudeTitles == nil) {
        return;
    }
    
    if ([self.longitudeTitles count] <= 0) {
        return;
    }
    
    CCFloat offset;
    CCFloat postOffset;
    
    CCFloat lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
    
    CCUInt counter = 0;
    CCUInt titleIndex = 0;
    do{
        for(CCUInt i=0; i < [self.longitudeSplitor count]
            && titleIndex < [self.longitudeTitles count];i++){
            
            NSString *str = (NSString *) [self.longitudeTitles objectAtIndex:titleIndex];

            postOffset = counter * lineLength;
            offset = self.axisMarginLeft + lineLength / 2;
            
            CCFloat titleLength = [str boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.longitudeFont} context:nil].size.width;
            
            CGRect textRect;
            if (titleIndex > 0) {
                CCFloat titleX= offset + postOffset - titleLength / 2.0;
                //处理最后一条轴线越线问题
                if (titleX + titleLength > rect.size.width - self.axisMarginRight) {
                    titleX= rect.size.width - self.axisMarginRight - titleLength;
                }
                textRect= CGRectMake(titleX, rect.size.height - self.axisMarginBottom, titleLength, self.longitudeFontSize);
            }else{
                textRect= CGRectMake(offset + postOffset , rect.size.height - self.axisMarginBottom, titleLength, self.longitudeFontSize);
            }
            
            UIFont *textFont= self.longitudeFont; //设置字体
            NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
            textStyle.alignment=NSTextAlignmentLeft;
            textStyle.lineBreakMode = NSLineBreakByWordWrapping;
            //绘制字体
            [str drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,
                                                      NSParagraphStyleAttributeName:textStyle,
                                                      NSForegroundColorAttributeName:self.longitudeFontColor}];
            
            //计数器重新设置
            counter = counter + [[self.longitudeSplitor objectAtIndex:i] integerValue];
            titleIndex = titleIndex + 1;
        }
        
        if (titleIndex ==  [self.longitudeTitles count]){
            break;
        }
        
    }while(counter < self.displayNumber);
    
 }

- (void)drawLines:(CGRect)rect {
    // 起始位置
    CCFloat startX;
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
                CCFloat lineLength = ((rect.size.width - self.axisMarginLeft - self.axisMarginRight) / self.displayNumber);
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
                    CCUInt counter = 0;
                    do{
                        if ([self.longitudeSplitor count] == 1) {
                            counter = counter + [[self.longitudeSplitor objectAtIndex:0] integerValue];
                        }else{
                            for(CCUInt k=0; k < [self.longitudeSplitor count] ;k++){
                                counter = counter + [[self.longitudeSplitor objectAtIndex:k] integerValue];
                                if (counter == j) {
                                    CGContextStrokePath(context);
                                }
                            }
                        }
                    }while(counter < self.displayNumber);
                    //X位移
                    startX = startX + lineLength;
                }
                //绘制路径
                CGContextStrokePath(context);
            }
        }
    }
}

-(void) bindSelectedIndex
{
    CCFloat stickWidth = [self getDataStickWidth];
    CCFloat pointX = self.axisMarginLeft +(self.selectedIndex - self.displayFrom + 0.5) * stickWidth;
    CCFloat pointY = self.singleTouchPoint.y;
    
    if (self.linesData != nil && [self.linesData count] > 0 ){
        CCSTitledLine *line = [self.linesData objectAtIndex:0];
        if (line != nil) {
            if (line.data != nil && [line.data count] > self.selectedIndex) {
                CCSLineData *lineData = [line.data objectAtIndex:self.selectedIndex];
                if ([self isNoneDisplayValue:lineData.value] == NO) {
                    pointY = [self computeValueY:lineData.value inRect:self.frame];
                }
            }
        }
    }
    
    _singleTouchPoint = CGPointMake(pointX,pointY);
}


- (void)zoomOut {
    if (self.enableZoom) {
        [super zoomOut];
    }
}

- (void)zoomIn {
    if (self.enableZoom) {
        [super zoomIn];
    }
}

- (void)moveLeft {
    if (self.enableSlip) {
        [super moveLeft];
    }
}

- (void)moveRight {
    if (self.enableSlip) {
        [super moveRight];
    }
}

@end
