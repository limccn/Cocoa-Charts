//
//  CCSTitleValues.h
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

#import <Foundation/Foundation.h>
#import "CCSBaseData.h"

/*!
 CCSTitleValues
 
 Entity data which its values are titled
 
 表示用データです、値はタイトル設定は可能です。
 
 支持显示标题的值的实体对象
 */
@interface CCSTitleValues : CCSBaseData {
    NSString *_title;
    NSArray *_values;
}

/*!
 value's title
 値のタイトル
 数据的标题
 */
@property(copy, nonatomic) NSString *title;

/*!
 values
 複数な値
 数据的值列表
 */
@property(strong, nonatomic) NSArray *values;


/*!
 @abstract Initialize This Object
 オブジェクトを初期化
 初始化当前对象
 
 @param title Title
 タイトル
 标题
 
 @param values Values
 値
 数据的值
 
 @result id Initialized Object
 初期化したオブジェクト
 初期化完成对象
 
 */
- (id)initWithTitle:(NSString *)title values:(NSArray *)values;

@end
