//
//  CCSSettingDetailViewController.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/4/11.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, IndicatorType) {
    IndicatorMACD,
    IndicatorMA,
    IndicatorKDJ,
    IndicatorRSI,
    IndicatorWR,
    IndicatorCCI,
    IndicatorBOLL
};

@interface CCSSettingDetailViewController : UIViewController<UITextFieldDelegate,UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIView        *vFirstIndicatorContainer;
@property (weak, nonatomic) IBOutlet UIView        *vSecondIndicatorContainer;
@property (weak, nonatomic) IBOutlet UIView        *vThirdIndicatorContainer;

@property (weak, nonatomic) IBOutlet UILabel       *lblFirstIndicator;
@property (weak, nonatomic) IBOutlet UILabel       *lblSecondIndicator;
@property (weak, nonatomic) IBOutlet UILabel       *lblThirdIndicator;

@property (weak, nonatomic) IBOutlet UITextField   *tfFirstIndicator;
@property (weak, nonatomic) IBOutlet UITextField   *tfSecondIndicator;
@property (weak, nonatomic) IBOutlet UITextField   *tfThirdIndicator;

@property (weak, nonatomic) IBOutlet UIButton      *btnSetting;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintFirstLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintSecondLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintThirdLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintFourLineHeight;

/** 正在编辑的 textview/textfield */
@property(strong, nonatomic) UITextField           *editingTextField;
@property(strong, nonatomic) UITextView            *editingTextView;

@property(assign, nonatomic) IndicatorType          indicatorType;

@property (weak, nonatomic) UIViewController      *ctrlChart;

/**
 * 设置
 */
- (IBAction)settingTouchUpInside:(id)sender;

@end
