//
//  CCSColoredStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 12/2/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSSlipStickChart.h"

typedef enum {
    CCSColoredStickStyleNoBorder = 0,
    CCSColoredStickStyleWithBorder = 1,
} CCSColoredStickStyle;


@interface CCSColoredStickChart : CCSSlipStickChart {
    CCSColoredStickStyle _coloredStickStyle;
}

@property(assign, nonatomic) CCSColoredStickStyle coloredStickStyle;

@end
