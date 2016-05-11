//
//  CCSChartsSettingTableViewCell.h
//  Cocoa-Charts
//
//  Created by zhourr on 11-10-24.
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

#import <UIKit/UIKit.h>

@interface CCSChartsSettingTableViewCell : UITableViewCell

/** cell 顶部线 */
@property (weak, nonatomic) IBOutlet UIView                  *vTopLine;
/** cell 底部线 */
@property (weak, nonatomic) IBOutlet UIView                  *vBottomLine;
/** 标题 */
@property (weak, nonatomic) IBOutlet UILabel                 *lblTitle;

/**
 * 约束
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintTopLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintBottomLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintTopLineLeft;

/**
 * 设置数据
 */
- (void)setData:(NSDictionary *)data;

/**
 * 设置指标文字
 */
- (void)setIndicatorTextColor:(UIColor *) textColor;

@end
