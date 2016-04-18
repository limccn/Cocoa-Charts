//
//  CCSPieChart.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-26.
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

#import "CCSPieChart.h"
#import "CCSTitleValueColor.h"


@implementation CCSPieChart

@synthesize data = _data;
@synthesize radiusColor = _radiusColor;
@synthesize circleBorderColor = _circleBorderColor;
@synthesize titleFont = _titleFont;
@synthesize titleTextColor = _titleTextColor;
@synthesize radius = _radius;
@synthesize displayRadius = _displayRadius;
@synthesize displayValueTitle = _displayValueTitle;
@synthesize position = _position;


- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];

    //初始化相关属性
    self.radiusColor = [UIColor whiteColor];
    self.circleBorderColor = [UIColor whiteColor];
    self.titleFont = [UIFont systemFontOfSize:12];
    self.titleTextColor = [UIColor lightGrayColor];
    self.displayRadius = YES;
    self.displayValueTitle = YES;

    //清理数据
    self.data = nil;

    //获得安全高度宽度
    CCUInt height = (CCUInt) (self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width);
    //绘图高宽度
    self.radius = (CCUInt) ((height / 2.0f) * 0.9);
    //初始化绘图位置
    self.position = CGPointMake((CCUInt) (self.frame.size.width / 2.0f), (CCUInt) (self.frame.size.height / 2.0f));

}


- (void)drawRect:(CGRect)rect {
    //获得安全高度宽度
    CCUInt height = (CCUInt) (self.frame.size.width > self.frame.size.height ? self.frame.size.height : self.frame.size.width);
    //绘图高宽度
    self.radius = (CCUInt) ((height / 2.0f) * 0.9);
    //初始化绘图位置
    self.position = CGPointMake((CCUInt) (self.frame.size.width / 2.0f), (CCUInt) (self.frame.size.height / 2.0f));

    //绘制数据
    [self drawData:rect];
}

- (void)drawData:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetStrokeColorWithColor(context, self.circleBorderColor.CGColor);

    if (self.data != nil) {

        //获得总数
        CCFloat sum = 0;
        for (CCUInt i = 0; i < [self.data count]; i++) {
            sum = sum + ((CCSTitleValueColor *) [self.data objectAtIndex:i]).value;
        }

        CCFloat offset = PI * -0.5f;
        // 遍历每一条数据列表
        for (CCUInt j = 0; j < [self.data count]; j++) {
            CCSTitleValueColor *entity = [self.data objectAtIndex:j];

            //圆弧填充色
            CGContextSetFillColorWithColor(context, entity.color.CGColor);

            //角度
            CCFloat sweep = entity.value * 2 * PI / sum;

            //移动到圆心
            CGContextMoveToPoint(context, self.position.x, self.position.y);

            CGContextAddArc(context, self.position.x, self.position.y, self.radius, offset, offset + sweep, 0);
            CGContextClosePath(context);

            CGContextFillPath(context);

            //绘制外边框
            CGContextMoveToPoint(context, self.position.x, self.position.y);
            CGContextAddArc(context, self.position.x, self.position.y, self.radius, offset, offset + sweep, 0);
            CGContextClosePath(context);

            CGContextStrokePath(context);

            //调整偏移
            offset = offset + sweep;

        }

        if (self.displayValueTitle) {
            CCFloat sumvalue = 0.0;
            //
            for (CCUInt k = 0; k < [self.data count]; k++) {
                CCSTitleValueColor *entity = [self.data objectAtIndex:k];
                //值
                CCFloat value = entity.value;
                //添加偏移
                sumvalue = sumvalue + value;
                //比例
                CCFloat rate = (sumvalue - value / 2.0f) / sum;

                CCFloat offsetX = (CCFloat) (self.position.x - self.radius * 0.8 * sin(rate * -2 * PI));
                CCFloat offsetY = (CCFloat) (self.position.y - self.radius * 0.8 * cos(rate * -2 * PI));

                //绘制标题
                NSString *title = entity.title;

                //绘制百分比
                NSMutableString *percentage = [[NSMutableString alloc] initWithCapacity:8];
                [percentage appendString:[[NSString stringWithFormat:@"%f", (int) (value / sum * 10000) / 100.0f] substringToIndex:5]];
                [percentage appendString:@"%"];
                
                CGRect textRect= CGRectMake(offsetX, offsetY, 100, self.titleFont.pointSize);
                NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                textStyle.alignment=NSTextAlignmentLeft;
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                //绘制字体
                [title drawInRect:textRect withAttributes:@{NSFontAttributeName:self.titleFont,NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName:self.titleTextColor}];

                
                CGRect textRectPer= CGRectMake(offsetX, offsetY + self.titleFont.pointSize , 100, self.titleFont.pointSize);
                NSMutableParagraphStyle *textStylePer=[[NSMutableParagraphStyle alloc]init];//段落样式
                textStylePer.alignment=NSTextAlignmentLeft;
                textStylePer.lineBreakMode = NSLineBreakByWordWrapping;
                //绘制字体
                [percentage drawInRect:textRectPer withAttributes:@{NSFontAttributeName:self.titleFont,NSParagraphStyleAttributeName:textStylePer,NSForegroundColorAttributeName:self.titleTextColor}];

            }
        }
    }
}

@end
