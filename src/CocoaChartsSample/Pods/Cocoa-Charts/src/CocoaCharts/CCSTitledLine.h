//
//  TiltledLine.h
//  Cocoa-Charts
//
//  Created by limc on 11-10-25.
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
 CCSTitledLine
 
 Entity data which is use for display a line with title and color in CCSGridChart
 
 CCSGridChartのライン表示用データです、ラインはタイトルや色の設定は可能です。
 
 CCSGridChart上显示一条带颜色支持显示标题的线条的实体对象
 */
@interface CCSTitledLine : CCSBaseData {
    NSArray *_data;
    UIColor *_color;
    NSString *_title;
}

/*!
 Line's points data
 ラインのデータ
 线条数据
 */
@property(strong, nonatomic) NSArray *data;

/*!
 Line's color
 ラインの色
 线条颜色
 */
@property(strong, nonatomic) UIColor *color;

/*!
 Line's title
 ラインのタイトル
 线条标题
 */
@property(copy, nonatomic) NSString *title;

/*!
 @abstract Initialize This Object
 オブジェクトを初期化
 初始化当前对象
 
 @param data Data
 値
 数据的值
 
 @param color Color
 値
 数据的值
 
 @param title Title
 タイトル
 标题
 
 @result id Initialized Object
 初期化したオブジェクト
 初期化完成对象
 
 */
- (id)initWithData:(NSMutableArray *)data color:(UIColor *)color title:(NSString *)title;

@end
