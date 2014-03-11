//
//  CCSMACDData.h
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSBaseData.h"

@interface CCSMACDData : CCSBaseData {
    CGFloat _dea;
    CGFloat _diff;
    CGFloat _macd;
    NSString *_date;
}

@property(assign, nonatomic) CGFloat dea;
@property(assign, nonatomic) CGFloat diff;
@property(assign, nonatomic) CGFloat macd;
@property(strong, nonatomic) NSString *date;

- (id)initWithDea:(CGFloat)dea diff:(CGFloat)diff macd:(CGFloat)macd date:(NSString *)date;

@end
