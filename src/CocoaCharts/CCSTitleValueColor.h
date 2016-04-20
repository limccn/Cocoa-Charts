//
//  CCSTitleValueColor.h
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

#import <Foundation/Foundation.h>
#import "CCSTitleValue.h"

/*!
 CCSTitleValueColor
 
 Entity data which its value is titled and with color
 
 表示用データです、値はタイトルや色の設定は可能です。
 
 支持显示标题的值的实体对象
 */
@interface CCSTitleValueColor : CCSTitleValue {
    UIColor *_color;
}

/*!
 Color
 色
 颜色
 */
@property(strong, nonatomic) UIColor *color;

/*!
 @abstract Initialize This Object
 オブジェクトを初期化
 初始化当前对象
 
 @param title Title
 タイトル
 标题
 
 @param value Value
 値
 数据的值
 
 @param color Color
 色
 颜色
 
 @result id Initialized Object
 初期化したオブジェクト
 初期化完成对象
 
 */
- (id)initWithTitle:(NSString *)title value:(CCFloat)value color:(UIColor *)color;

@end
