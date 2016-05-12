//
//  CCSTickChart.h
//  CocoaChartsSample
//
//  Created by 李 明成 on 16/4/21.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSlipLineChart.h"
#import "CCSHeader.h"

@interface CCSTickChart : CCSSlipLineChart {
    NSArray *_longitudeSplitor;
    NSArray *_latitudeSplitor;
    
    CCFloat _lastClose;
    
    BOOL _limitRangeSupport;
    CCFloat _limitMaxValue;
    CCFloat _limitMinValue;
    
    BOOL _enableZoom;
    BOOL _enableSlip;
    
}

@property(strong,nonatomic) NSArray *longitudeSplitor;
@property(strong,nonatomic) NSArray *latitudeSplitor;

@property(assign,nonatomic) CCFloat lastClose;

@property(assign,nonatomic) BOOL limitRangeSupport;
@property(assign,nonatomic) CCFloat limitMaxValue;
@property(assign,nonatomic) CCFloat limitMinValue;


@property(assign,nonatomic) BOOL enableZoom;
@property(assign,nonatomic) BOOL enableSlip;

@end
