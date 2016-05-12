//
//  CCSSettingDetailViewController.h
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

#import "CocoaChartsHeader.h"

@interface CCSSettingDetailViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

/** 指标控件 Container */
@property (weak, nonatomic) IBOutlet UIView        *vFirstIndicatorContainer;
@property (weak, nonatomic) IBOutlet UIView        *vSecondIndicatorContainer;
@property (weak, nonatomic) IBOutlet UIView        *vThirdIndicatorContainer;

/** 指标 */
@property (weak, nonatomic) IBOutlet UILabel       *lblFirstIndicator;
@property (weak, nonatomic) IBOutlet UILabel       *lblSecondIndicator;
@property (weak, nonatomic) IBOutlet UILabel       *lblThirdIndicator;

/** 指标值 */
@property (weak, nonatomic) IBOutlet UITextField   *tfFirstIndicator;
@property (weak, nonatomic) IBOutlet UITextField   *tfSecondIndicator;
@property (weak, nonatomic) IBOutlet UITextField   *tfThirdIndicator;

/** 设置按钮 */
@property (weak, nonatomic) IBOutlet UIButton      *btnSetting;

/**
 * 高度约束,用于设置是否显示
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintFirstLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintSecondLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintThirdLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintFourLineHeight;

/** 正在编辑的 textview/textfield */
@property(strong, nonatomic) UITextField           *editingTextField;
@property(strong, nonatomic) UITextView            *editingTextView;

/** 存储指标类型 */
@property(assign, nonatomic) IndicatorType          indicatorType;

/** 图表ViewController */
@property (weak, nonatomic) UIViewController       *ctrlChart;
/** 主题 */
@property (assign, nonatomic) ThemeModeType         themeMode;

/**
 * 设置
 */
- (IBAction)settingTouchUpInside:(id)sender;

@end
