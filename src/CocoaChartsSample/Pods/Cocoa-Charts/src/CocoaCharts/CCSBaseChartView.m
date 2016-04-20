//
//  CCSBaseChartView.m
//  Cocoa-Charts
//
//  Created by limc on 11-10-27.
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

#import "CCSBaseChartView.h"


@implementation CCSBaseChartView

- (id)init {
    self = [super init];
    if (self) {
        //初始化属性
        [self initProperty];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //初始化属性
        [self initProperty];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;

        //初始化属性
        [self initProperty];
    }
    return self;
}

- (void)initProperty {
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    //如果父view容器不为空
    if (nil != self.superview) {
        [self.superview touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];

    //如果父view容器不为空
    if (nil != self.superview) {
        [self.superview touchesMoved:touches withEvent:event];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];

    //如果父view容器不为空
    if (nil != self.superview) {
        [self.superview touchesEnded:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {

    [super touchesEnded:touches withEvent:event];

    //如果父view容器不为空
    if (nil != self.superview) {
        [self.superview touchesCancelled:touches withEvent:event];
    }
}


@end
