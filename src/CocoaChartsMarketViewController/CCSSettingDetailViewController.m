//
//  CCSSettingDetailViewController.m
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

#import "CCSSettingDetailViewController.h"

#import "CCSMarketDetailViewController.h"

#import "NSString+UserDefault.h"

#define CELL_BACKGROUND_DAY                         [UIColor whiteColor]
#define CELL_BACKGROUND_NIGHT                       [@"#16181F" str2Color]

#define CELL_TEXT_COLOR_DAY                         [@"#323232" str2Color]
#define CELL_TEXT_COLOR_NIGHT                       [UIColor lightGrayColor]

@interface CCSSettingDetailViewController (){
    UIToolbar                                         *_keyboardToolBar;
}

@end

@implementation CCSSettingDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.btnSetting.layer setCornerRadius:5.0f];
    
    [self.layoutConstraintFirstLineHeight setConstant:0.5f];
    [self.layoutConstraintSecondLineHeight setConstant:0.5f];
    [self.layoutConstraintThirdLineHeight setConstant:0.5f];
    [self.layoutConstraintFourLineHeight setConstant:0.5f];
    
    [self initViewWithIndicatorType:self.indicatorType];
    
//    self.themeMode = ThemeNightMode;
    [self.view setBackgroundColor: self.themeMode == ThemeDayMode? CONTENT_BACKGROUND_DAY:CONTENT_BACKGROUND_NIGHT];
    
    [self.vFirstIndicatorContainer setBackgroundColor:self.themeMode == ThemeDayMode? CELL_BACKGROUND_DAY:CELL_BACKGROUND_NIGHT];
    [self.vSecondIndicatorContainer setBackgroundColor:self.themeMode == ThemeDayMode? CELL_BACKGROUND_DAY:CELL_BACKGROUND_NIGHT];
    [self.vThirdIndicatorContainer setBackgroundColor:self.themeMode == ThemeDayMode? CELL_BACKGROUND_DAY:CELL_BACKGROUND_NIGHT];
    
    [self.tfFirstIndicator setTextColor:self.themeMode == ThemeDayMode? CELL_TEXT_COLOR_DAY:CELL_TEXT_COLOR_NIGHT];
    [self.tfSecondIndicator setTextColor:self.themeMode == ThemeDayMode? CELL_TEXT_COLOR_DAY:CELL_TEXT_COLOR_NIGHT];
    [self.tfThirdIndicator setTextColor:self.themeMode == ThemeDayMode? CELL_TEXT_COLOR_DAY:CELL_TEXT_COLOR_NIGHT];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingTouchUpInside:(id)sender{
    NSArray *idIndicatorValues = self.indicatorType == IndicatorMACD?@[self.tfFirstIndicator.text, self.tfSecondIndicator.text, self.tfThirdIndicator.text]:self.indicatorType == IndicatorMA?@[self.tfFirstIndicator.text, self.tfSecondIndicator.text, self.tfThirdIndicator.text]:self.indicatorType == IndicatorVMA?@[self.tfFirstIndicator.text, self.tfSecondIndicator.text, self.tfThirdIndicator.text]:self.indicatorType == IndicatorKDJ?@[self.tfFirstIndicator.text]:self.indicatorType == IndicatorRSI?@[self.tfFirstIndicator.text, self.tfSecondIndicator.text]:self.indicatorType == IndicatorWR?@[self.tfFirstIndicator.text]:self.indicatorType == IndicatorCCI?@[self.tfFirstIndicator.text]:@[self.tfFirstIndicator.text];
    
    if (![self verfiyIdIndicator: idIndicatorValues]) {
        return;
    }
    
    CCSMarketDetailViewController *ctrlChart = (CCSMarketDetailViewController *)self.ctrlChart;
    
    if (self.indicatorType == IndicatorMACD) {
        ctrlChart.macdS = [idIndicatorValues[0] integerValue];
        ctrlChart.macdL = [idIndicatorValues[1] integerValue];
        ctrlChart.macdM = [idIndicatorValues[2] integerValue];
    }else if (self.indicatorType == IndicatorMA){
        ctrlChart.ma1 = [idIndicatorValues[0] integerValue];
        ctrlChart.ma2 = [idIndicatorValues[1] integerValue];
        ctrlChart.ma3 = [idIndicatorValues[2] integerValue];
    }else if (self.indicatorType == IndicatorVMA){
        ctrlChart.vma1 = [idIndicatorValues[0] integerValue];
        ctrlChart.vma2 = [idIndicatorValues[1] integerValue];
        ctrlChart.vma3 = [idIndicatorValues[2] integerValue];
    }else if (self.indicatorType == IndicatorKDJ){
        ctrlChart.kdjN = [idIndicatorValues[0] integerValue];
    }else if (self.indicatorType == IndicatorRSI){
        ctrlChart.rsiN1 = [idIndicatorValues[0] integerValue];
        ctrlChart.rsiN2 = [idIndicatorValues[1] integerValue];
    }else if (self.indicatorType == IndicatorWR){
        ctrlChart.wrN = [idIndicatorValues[0] integerValue];
    }else if (self.indicatorType == IndicatorCCI){
        ctrlChart.cciN = [idIndicatorValues[0] integerValue];
    }else if (self.indicatorType == IndicatorBOLL){
        ctrlChart.bollN = [idIndicatorValues[0] integerValue];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        [ctrlChart updateChartsWithIndicatorType:self.indicatorType];
    }];
}

/******************************************************************************
 * Implements Of UISearchBarDelegate UITextFieldDelegate
 ******************************************************************************/

#pragma mark -
#pragma mark UITextFieldDelegate Call back Implementation

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.editingTextField = textField;
    
    _keyboardToolBar = [[UIToolbar alloc] init];
    _keyboardToolBar.frame = CGRectMake(0, 0, 0, 44);
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:@"隐藏"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(hideKeyboard)];
    
    [_keyboardToolBar setItems:[NSArray arrayWithObjects:spacer, btnDone, nil]];
    self.editingTextField.inputAccessoryView = _keyboardToolBar;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.editingTextField = nil;
}

/******************************************************************************
 *  UITextViewDelegate Call back Implementation
 ******************************************************************************/

#pragma mark -
#pragma mark UITextViewDelegate Call back Implementation

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    
}

- (void)textViewDidChange:(UITextView *)textView
{
    
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.editingTextView = textView;
    
    _keyboardToolBar = [[UIToolbar alloc] init];
    _keyboardToolBar.frame = CGRectMake(0, 0, 320, 44);
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                           target:nil
                                                                           action:nil];
    
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc]initWithTitle:@"隐藏"
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(hideKeyboard)];
    
    [_keyboardToolBar setItems:[NSArray arrayWithObjects:spacer, btnDone, nil]];
    self.editingTextView.inputAccessoryView = _keyboardToolBar;
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    self.editingTextView = nil;
    return YES;
}

/**
 * 隐藏键盘
 */
- (void)hideKeyboard
{
    [self.editingTextField resignFirstResponder];
    self.editingTextField = nil;
    
    [self.editingTextView resignFirstResponder];
    self.editingTextView = nil;
}

- (void)initViewWithIndicatorType: (IndicatorType)indicatorType{
    if (indicatorType == IndicatorMACD) {
        [self initViewWithMACD];
    }else if (indicatorType == IndicatorMA){
        [self initViewWithMA];
    }else if (indicatorType == IndicatorVMA){
        [self initViewWithVMA];
    }else if (indicatorType == IndicatorKDJ){
        [self.vSecondIndicatorContainer setHidden:YES];
        [self.vThirdIndicatorContainer setHidden:YES];
        
        [self initViewWithKDJ];
    }else if (indicatorType == IndicatorRSI){
        [self.vThirdIndicatorContainer setHidden:YES];
        
        [self initViewWithRSI];
    }else if (indicatorType == IndicatorWR){
        [self.vSecondIndicatorContainer setHidden:YES];
        [self.vThirdIndicatorContainer setHidden:YES];
        
        [self initViewWithWR];
    }else if (indicatorType == IndicatorCCI){
        [self.vSecondIndicatorContainer setHidden:YES];
        [self.vThirdIndicatorContainer setHidden:YES];
        
        [self initViewWithCCI];
    }else if (indicatorType == IndicatorBOLL){
        [self.vSecondIndicatorContainer setHidden:YES];
        [self.vThirdIndicatorContainer setHidden:YES];
        
        [self initViewWithBOLL];
    }
}

- (void)initViewWithMACD{
    [self.lblFirstIndicator setText:@"S:"];
    [self.lblSecondIndicator setText:@"L:"];
    [self.lblThirdIndicator setText:@"M:"];
    
    [self.tfFirstIndicator setPlaceholder:@"MACD-S"];
    [self.tfSecondIndicator setPlaceholder:@"MACD-L"];
    [self.tfThirdIndicator setPlaceholder:@"MACD-M"];
    
    [self.tfFirstIndicator setText:[MACD_S getUserDefaultString]];
    [self.tfSecondIndicator setText:[MACD_L getUserDefaultString]];
    [self.tfThirdIndicator setText:[MACD_M getUserDefaultString]];
}

- (void)initViewWithMA{
    [self.lblFirstIndicator setText:@"MA1:"];
    [self.lblSecondIndicator setText:@"MA2:"];
    [self.lblThirdIndicator setText:@"MA3:"];
    
    [self.tfFirstIndicator setPlaceholder:@"MA1"];
    [self.tfSecondIndicator setPlaceholder:@"MA2"];
    [self.tfThirdIndicator setPlaceholder:@"MA3"];
    
    [self.tfFirstIndicator setText:[MA1 getUserDefaultString]];
    [self.tfSecondIndicator setText:[MA2 getUserDefaultString]];
    [self.tfThirdIndicator setText:[MA3 getUserDefaultString]];
}

- (void)initViewWithVMA{
    [self.lblFirstIndicator setText:@"VMA1:"];
    [self.lblSecondIndicator setText:@"VMA2:"];
    [self.lblThirdIndicator setText:@"VMA3:"];
    
    [self.tfFirstIndicator setPlaceholder:@"VMA1"];
    [self.tfSecondIndicator setPlaceholder:@"VMA2"];
    [self.tfThirdIndicator setPlaceholder:@"VMA3"];
    
    [self.tfFirstIndicator setText:[VMA1 getUserDefaultString]];
    [self.tfSecondIndicator setText:[VMA2 getUserDefaultString]];
    [self.tfThirdIndicator setText:[VMA3 getUserDefaultString]];
}

- (void)initViewWithKDJ{
    [self.lblFirstIndicator setText:@"KDJ:"];
    [self.tfFirstIndicator setPlaceholder:@"KDJ-N"];
    
    [self.tfFirstIndicator setText:[KDJ_N getUserDefaultString]];
}

- (void)initViewWithRSI{
    [self.lblFirstIndicator setText:@"N1:"];
    [self.lblSecondIndicator setText:@"N2:"];
    
    [self.tfFirstIndicator setPlaceholder:@"RSI-N1"];
    [self.tfSecondIndicator setPlaceholder:@"RSI-N2"];
    
    [self.tfFirstIndicator setText:[RSI_N1 getUserDefaultString]];
    [self.tfSecondIndicator setText:[RSI_N2 getUserDefaultString]];
}

- (void)initViewWithWR{
    [self.lblFirstIndicator setText:@"WR:"];
    
    [self.tfFirstIndicator setPlaceholder:@"WR-N"];
    
    [self.tfFirstIndicator setText:[WR_N getUserDefaultString]];
}

- (void)initViewWithCCI{
    [self.lblFirstIndicator setText:@"CCI:"];
    
    [self.tfFirstIndicator setPlaceholder:@"CCI-N"];
    
    [self.tfFirstIndicator setText:[CCI_N getUserDefaultString]];
}

- (void)initViewWithBOLL{
    [self.lblFirstIndicator setText:@"BOLL:"];
    
    [self.tfFirstIndicator setPlaceholder:@"BOLL-N"];
    
    [self.tfFirstIndicator setText:[BOLL_N getUserDefaultString]];
}

- (BOOL)verfiyIdIndicator:(NSArray *) idIndicatorValues{
    
    return YES;
}

@end
