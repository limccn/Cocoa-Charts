//
//  CCSMACDData.m
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSMACDData.h"

@implementation CCSMACDData
@synthesize dea = _dea;
@synthesize diff = _diff;
@synthesize macd = _macd;
@synthesize date = _date;


- (id)init {
    self = [super init];
    if (self) {

    }
    return self;
}

- (id)initWithDea:(CGFloat)dea diff:(CGFloat)diff macd:(CGFloat)macd date:(NSString *)date; {
    self = [self init];

    if (self) {
        self.dea = dea;
        self.diff = diff;
        self.macd = macd;
        self.date = date;
    }
    return self;
}

@end
