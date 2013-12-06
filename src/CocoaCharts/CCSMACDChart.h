//
//  CCSMACDChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
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
