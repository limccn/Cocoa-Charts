//
//  CCSMACDChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
    
    UIColor *_positiveStickColor;
    UIColor *_negativeStickColor;
    UIColor *_macdLineColor;
    UIColor *_diffLineColor;
    UIColor *_deaLineColor;
}

@property(retain, nonatomic) NSArray *linesData;

@property(assign, nonatomic) CCSMACDChartDisplayType macdDisplayType;

@property(retain, nonatomic) UIColor *positiveStickColor;
@property(retain, nonatomic) UIColor *negativeStickColor;
@property(retain, nonatomic) UIColor *macdLineColor;
@property(retain, nonatomic) UIColor *diffLineColor;
@property(retain, nonatomic) UIColor *deaLineColor;

@end
