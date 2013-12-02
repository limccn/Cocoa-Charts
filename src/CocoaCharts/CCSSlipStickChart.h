//
//  CCSSlipStickChart.h
//  CocoaChartsSample
//
//  Created by limc on 11/21/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSStickChart.h"

@interface CCSSlipStickChart : CCSStickChart {
    NSUInteger _displayNumber;
    NSUInteger _displayFrom;
    NSUInteger _minDisplayNumber;
}

@property(assign, nonatomic) NSUInteger displayNumber;
@property(assign, nonatomic) NSUInteger displayFrom;
@property(assign, nonatomic) NSUInteger minDisplayNumber;


@end
