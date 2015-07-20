//
//  CCSDonutChart.h
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

#import "CCSDonutChart.h"
#import "CCSTitleValueColor.h"

@implementation CCSDonutChart
@synthesize donutWidth = _donutWidth;


- (void)initProperty {
    //初始化父类的熟悉
    [super initProperty];
    
    self.donutWidth = self.radius * 0.382;
    
}

- (void)drawData:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
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
            
            CGContextSetLineWidth(context, self.donutWidth);
            CGContextSetStrokeColorWithColor(context, entity.color.CGColor);
            CGContextAddArc(context, self.position.x, self.position.y, self.radius - self.donutWidth/2, offset, offset + sweep, 0);
            CGContextStrokePath(context);
            
            
            //调整偏移
            offset = offset + sweep;
            
        }
        
        
        CGContextSetFillColorWithColor(context, [UIColor lightGrayColor].CGColor);
        
        if (self.displayValueTitle) {
            
            float pointSize = self.titleFont.pointSize;
            
            float startX = self.position.x - (self.radius - self.donutWidth) / 1.4f;
            float startY = self.position.y - [self.data count] * pointSize /2  ;
            
            for (CCUInt k = 0; k < [self.data count]; k++) {
                CCSTitleValueColor *entity = [self.data objectAtIndex:k];
                
                

                CGContextSetFillColorWithColor(context, entity.color.CGColor);
                CGContextFillRect(context, CGRectMake(startX+1, startY+1 + k * pointSize, pointSize - 2, pointSize -2));
                
                CGContextSetFillColorWithColor(context, self.titleTextColor.CGColor);
                //绘制标题
                NSString *title = entity.title;
                
                //绘制百分比
                NSMutableString *percentage = [[NSMutableString alloc] initWithCapacity:8];
                [percentage appendString:[[NSString stringWithFormat:@"%f", (int) (entity.value / sum * 10000) / 100.0f] substringToIndex:5]];
                [percentage appendString:@"%"];
                
                CGRect textRect= CGRectMake(startX + pointSize, startY + k * pointSize, (self.position.x - startX)*2, pointSize);
                NSMutableParagraphStyle *textStyle=[[NSMutableParagraphStyle alloc]init];//段落样式
                textStyle.alignment=NSTextAlignmentLeft;
                textStyle.lineBreakMode = NSLineBreakByWordWrapping;
                //绘制字体
                [[[percentage stringByAppendingString:@" "]stringByAppendingString:title] drawInRect:textRect withAttributes:@{NSFontAttributeName:self.titleFont,NSParagraphStyleAttributeName:textStyle,NSForegroundColorAttributeName:self.titleTextColor}];
                
            }
        }
    }
}


@end