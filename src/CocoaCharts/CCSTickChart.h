//
//  CCSTickChart.h
//  CocoaChartsSample
//
//  Created by 李 明成 on 16/4/21.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSlipLineChart.h"

@interface CCSTickChart : CCSSlipLineChart {
    NSArray *_longitudeSplitor;
    NSArray *_latitudeSplitor;
    
    CGFloat _lastClose;
    
    BOOL _limitRangeSupport;
    CGFloat _limitMaxValue;
    CGFloat _limitMinValue;
    
}

@property(strong,nonatomic) NSArray *longitudeSplitor;
@property(strong,nonatomic) NSArray *latitudeSplitor;

@property(assign,nonatomic) CGFloat lastClose;

@property(assign,nonatomic) BOOL limitRangeSupport;
@property(assign,nonatomic) CGFloat limitMaxValue;
@property(assign,nonatomic) CGFloat limitMinValue;


@end
