//
//  CCSRadarChart.m
//  Cocoa-Charts
//
//  Created by limc on 11-11-8.
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

#import "CCSRadarChart.h"
#import "CCSTitleValuesColor.h"

@implementation CCSRadarChart

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawData:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetAllowsAntialiasing(context, YES);

    CGPathRef path = nil;

    if (self.data != NULL) {
        // 遍历每一条数据列表
        for (CCUInt j = 0; j < [self.data count]; j++) {
            CCSTitleValuesColor *entity = [self.data objectAtIndex:j];

            CGContextSetFillColorWithColor(context, entity.color.CGColor);
            CGContextSetStrokeColorWithColor(context, entity.color.CGColor);
            CGContextSetAlpha(context, 0.5);
            // 获取数据点列表
            NSArray *values = entity.values;
            // 获取Path
            //绘制Web图
            for (CCUInt i = 0; i < self.longitudeNum; i++) {
                //获取值
                CCFloat value = [((NSNumber *) [values objectAtIndex:i]) doubleValue];

                CCFloat ptX = (CCFloat) (self.position.x - self.longitudeLength * value / self.latitudeNum * sin(i * 2 * PI / self.longitudeNum));
                CCFloat ptY = (CCFloat) (self.position.y - self.longitudeLength * value / self.latitudeNum * cos(i * 2 * PI / self.longitudeNum));

                if (i == 0) {
                    CGContextMoveToPoint(context, ptX, ptY);
                } else {
                    CGContextAddLineToPoint(context, ptX, ptY);
                }
            }
            CGContextClosePath(context);
            //备份路径
            path = CGContextCopyPath(context);

            CGContextFillPath(context);

            CGContextAddPath(context, path);
            CGContextSetAlpha(context, 1);
            CGContextStrokePath(context);

            CGPathRelease(path);
        }
    }

    path = nil;
}


- (void)drawSpiderWeb:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 1.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetFillColorWithColor(context, self.spiderWebFillColor.CGColor);

    //绘制蛛网图外围边框与填充
    for (CCUInt i = 0; i < self.longitudeNum; i++) {

        CCFloat ptX = (CCFloat) (self.position.x - self.longitudeLength * sin(i * 2 * PI / self.longitudeNum));
        CCFloat ptY = (CCFloat) (self.position.y - self.longitudeLength * cos(i * 2 * PI / self.longitudeNum));

        //绘制标题
        NSString *title = [self.titles objectAtIndex:i];
        CCFloat realx = 0;
        CCFloat realy = 0;

        //重新计算坐标
        //TODO 计算算法日后完善
        if (ptX < self.position.x) {
            realx = ptX - 40;
        } else if (ptX > self.position.x) {
            realx = ptX - 2;
        } else {
            realx = ptX - 22;
        }

        if (ptY > self.position.y) {
            realy = ptY - 10;
        } else if (ptY < self.position.y) {
            realy = ptY - 10;
        } else {
            realy = ptY - 3;
        }

        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        //文字
        UIFont *font = [UIFont fontWithName:@"Arial" size:11];

        //调整X轴坐标位置
//        [title drawInRect:CGRectMake(realx, realy, 44, 11)
//                 withFont:font
//            lineBreakMode:NSLineBreakByWordWrapping
//                alignment:NSTextAlignmentCenter];
        
        CGRect textRect= CGRectMake(realx, realy, 44, 11);
        UIFont *textFont= font; //设置字体
        NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
        textStyle.alignment=NSTextAlignmentCenter;
        textStyle.lineBreakMode = NSLineBreakByWordWrapping;
        //绘制字体
        [title drawInRect:textRect withAttributes:@{NSFontAttributeName:textFont,NSParagraphStyleAttributeName:textStyle}];
        
        CGContextSetFillColorWithColor(context, self.spiderWebFillColor.CGColor);
    }

    CGContextAddEllipseInRect(context, CGRectMake(self.position.x - self.longitudeLength, self.position.y - self.longitudeLength, 2 * self.longitudeLength, 2 * self.longitudeLength));
    CGContextFillPath(context);


    CGContextAddEllipseInRect(context, CGRectMake(self.position.x - self.longitudeLength, self.position.y - self.longitudeLength, 2 * self.longitudeLength, 2 * self.longitudeLength));
    CGContextSetAlpha(context, 1);
    CGContextSetStrokeColorWithColor(context, self.latitudeColor.CGColor);
    CGContextStrokePath(context);

    CGContextSetLineWidth(context, 1.0f);
    //绘制内部蜘蛛网
    for (CCUInt j = 1; j < self.latitudeNum; j++) {
        CCFloat length = self.longitudeLength * j / self.latitudeNum;
        CGContextAddEllipseInRect(context, CGRectMake(self.position.x - length, self.position.y - length, 2 * length, 2 * length));
        CGContextStrokePath(context);
    }

    CGContextSetStrokeColorWithColor(context, self.longitudeColor.CGColor);
    //绘制蛛网经线
    for (CCUInt i = 0; i < self.longitudeNum; i++) {

        CCFloat ptX = (CCFloat) (self.position.x - self.longitudeLength * sin(i * 2 * PI / self.longitudeNum));
        CCFloat ptY = (CCFloat) (self.position.y - self.longitudeLength * cos(i * 2 * PI / self.longitudeNum));

        CGContextMoveToPoint(context, self.position.x, self.position.y);
        CGContextAddLineToPoint(context, ptX, ptY);
        CGContextStrokePath(context);
    }

}

@end
