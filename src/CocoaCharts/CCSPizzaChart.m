//
//  CCSPizzaChart.m
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

#import "CCSPizzaChart.h"
#import "CCSTitleValueColor.h"

@implementation CCSPizzaChart

@synthesize selectedIndex = _selectedIndex;
@synthesize offsetLength = _offsetLength;


- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    //初始化相关属性
    self.selectedIndex = 0;
    self.offsetLength = self.radius * 0.11f;

    //不显示标题
    self.displayValueTitle = NO;
}


- (void)drawRect:(CGRect)rect {
    //绘制数据
    [self drawData:rect];
}

- (void)drawData:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0f);
    CGContextSetAllowsAntialiasing(context, YES);
    CGContextSetStrokeColorWithColor(context, self.circleBorderColor.CGColor);

    if (self.data != NULL) {

        //获得总数
        CCFloat sum = 0;
        for (CCUInt i = 0; i < [self.data count]; i++) {
            sum = sum + ((CCSTitleValueColor *) [self.data objectAtIndex:i]).value;
        }

        CCFloat offset = 0;
        // 遍历每一条数据列表
        for (CCUInt j = 0; j < [self.data count]; j++) {

            CCUInt index = j + self.selectedIndex;
            index %= ([self.data count]);

            CCSTitleValueColor *entity = [self.data objectAtIndex:index];

            //圆弧填充色
            CGContextSetFillColorWithColor(context, entity.color.CGColor);

            //角度
            CCFloat sweep = entity.value * 2 * PI / sum;
            //如果是选中的数据
            if (j == 0) {
                //初始化偏移值
                offset = -0.5f * sweep;
                CCFloat realOffset;
                if (offset != -PI / 2 && offset != 0 && offset != -PI) {
                    if (offset > 0) {
                        realOffset = self.offsetLength / sin(offset);
                    } else {
                        realOffset = self.offsetLength / sin(-offset);
                    }
                } else {
                    realOffset = self.offsetLength;
                }

                //移动到圆心偏移点
                CGContextMoveToPoint(context, self.position.x + realOffset, self.position.y);

                CGContextAddArc(context, self.position.x + realOffset, self.position.y, self.radius, offset, offset + sweep, 0);
                CGContextClosePath(context);

                CGContextFillPath(context);

                //绘制外边框
                CGContextMoveToPoint(context, self.position.x + realOffset, self.position.y);
                CGContextAddArc(context, self.position.x + realOffset, self.position.y, self.radius, offset, offset + sweep, 0);
                CGContextClosePath(context);

                CGContextStrokePath(context);
            } else {
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

            }

            //调整偏移
            offset = offset + sweep;

        }
    }
}

- (void)selectPartByIndex:(CCUInt)index {
    //判断是否符合条件
    if (index < [self.data count]) {
        self.selectedIndex = index;
    } else {
        self.selectedIndex = index % [self.data count];
    }

    [self setNeedsDisplay];
}

@end
