//
//  CCSMACDChart.h
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


#import <UIKit/UIKit.h>
#import "CCSSlipStickChart.h"

typedef enum {
    CCSMACDChartDisplayTypeStick,
    CCSMACDChartDisplayTypeLineStick,
    CCSMACDChartDisplayTypeLine
} CCSMACDChartDisplayType;


@interface CCSMACDChart : CCSSlipStickChart {
    CCSMACDChartDisplayType _macdDisplayType;
    
    UIColor *_positiveStickStrokeColor;
    UIColor *_negativeStickStrokeColor;
    UIColor *_positiveStickFillColor;
    UIColor *_negativeStickFillColor;
    UIColor *_macdLineColor;
    UIColor *_diffLineColor;
    UIColor *_deaLineColor;
}

@property(strong, nonatomic) NSArray *linesData;

@property(assign, nonatomic) CCSMACDChartDisplayType macdDisplayType;

@property(strong, nonatomic) UIColor *positiveStickStrokeColor;
@property(strong, nonatomic) UIColor *negativeStickStrokeColor;
@property(strong, nonatomic) UIColor *positiveStickFillColor;
@property(strong, nonatomic) UIColor *negativeStickFillColor;
@property(strong, nonatomic) UIColor *macdLineColor;
@property(strong, nonatomic) UIColor *diffLineColor;
@property(strong, nonatomic) UIColor *deaLineColor;

@end
