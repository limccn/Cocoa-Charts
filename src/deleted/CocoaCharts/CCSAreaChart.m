//
//  CCSAreaChart.m
//  CocoaChartsSample
//
//  Created by limc on 11/13/13.
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

#import "CCSAreaChart.h"
#import "CCSTitledLine.h"
#import "CCSLineData.h"

@implementation CCSAreaChart
@synthesize areaAlpha = _areaAlpha;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    //去除轴对称属性
    self.areaAlpha = 0.2;
    self.lineAlignType = CCSLineAlignTypeJustify;
}

- (void)drawData:(CGRect)rect {
    if (self.linesData == nil){
        return;
    }
    
    // 起始位置
    CCFloat startX;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextSetAllowsAntialiasing(context, YES);
    
    //逐条输出MA线
    for (CCUInt i = 0; i < [self.linesData count]; i++) {
        CCSTitledLine *line = [self.linesData objectAtIndex:i];
        
        if (line == nil) {
            continue;
        }
        
        //设置线条颜色
        CGContextSetStrokeColorWithColor(context, line.color.CGColor);
        //获取线条数据
        NSArray *lineDatas = line.data;
        //判断Y轴的位置设置从左往右还是从右往左绘制
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            //TODO:自左向右绘图未对应
            // 点线距离
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / ([line.data count] - 1));
            //起始点
            startX = [self dataQuadrantPaddingStartX:rect];
            //遍历并绘制线条
            for (CCUInt j = 0; j < [lineDatas count]; j++) {
                CCSLineData *lineData = [lineDatas objectAtIndex:j];
                //获取终点Y坐标
                CCFloat valueY = [self calcValueY:lineData.value inRect:rect];

                //绘制线条路径
                if (j == 0) {
                    CGContextMoveToPoint(context, startX, valueY);
                } else {
                    CGContextAddLineToPoint(context, startX, valueY);
                }
                //X位移
                startX = startX + lineLength;
            }
        } else {
            
            // 点线距离
            CCFloat lineLength = ([self dataQuadrantPaddingWidth:rect] / ([line.data count] - 1));
            //起始点
            startX = [self dataQuadrantPaddingEndX:rect];
            
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
                for (NSInteger j = [lineDatas count] - 1; j >= 0; j--) {
                    CCSLineData *lineData = [lineDatas objectAtIndex:j];
                    //获取终点Y坐标
                    CCFloat valueY =  [self calcValueY:lineData.value inRect:rect];

                    //绘制线条路径
                    if (j == [lineDatas count] - 1) {
                        CGContextMoveToPoint(context, startX, valueY);
                    } else if (j == 0) {
                        CGContextAddLineToPoint(context, [self dataQuadrantPaddingStartX:rect], valueY);
                    } else {
                        CGContextAddLineToPoint(context, startX, valueY);
                    }
                    //X位移
                    startX = startX - lineLength;
                }
            }
        }
        
        //备份路径
        CGPathRef path = CGContextCopyPath(context);
        
        //绘制路径
        CGContextStrokePath(context);
        
        CGContextAddPath(context, path);
        
        if (self.axisYPosition == CCSGridChartYAxisPositionLeft) {
            CGContextAddLineToPoint(context, [self dataQuadrantPaddingEndX:rect], [self dataQuadrantPaddingEndY:rect]);
            CGContextAddLineToPoint(context, [self dataQuadrantPaddingStartX:rect], [self dataQuadrantPaddingEndY:rect]);
        }else{
            CGContextAddLineToPoint(context, [self dataQuadrantPaddingStartX:rect], [self dataQuadrantPaddingEndY:rect]);
            CGContextAddLineToPoint(context, [self dataQuadrantPaddingEndX:rect], [self dataQuadrantPaddingEndY:rect]);
        }
        
        CGContextClosePath(context);
        CGContextSetAlpha(context, self.areaAlpha);
        CGContextSetFillColorWithColor(context, line.color.CGColor);
        CGContextFillPath(context);
        
        CGPathRelease(path);
        
        path = nil;
    }
}

@end
