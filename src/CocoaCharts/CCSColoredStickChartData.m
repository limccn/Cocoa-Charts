//
//  CCSColoredStickChartData.m
//  CocoaChartsSample
//
//  Created by limc on 12/2/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSColoredStickChartData.h"

@implementation CCSColoredStickChartData
@synthesize borderColor = _borderColor;
@synthesize fillColor = _fillColor;


- (id)init {
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithHigh:(float)high low:(float)low date:(NSString *)date color:(UIColor *)color{
    self = [self init];
    
    if (self) {
        self.high = high;
        self.low = low;
        self.date = date;
        self.fillColor = color;
        self.borderColor = color;
    }
    return self;
}

- (id)initWithHigh:(float)high low:(float)low date:(NSString *)date fill:(UIColor *)fill border:(UIColor *)border{
    self = [self init];
    
    if (self) {
        self.high = high;
        self.low = low;
        self.date = date;
        self.fillColor = fill;
        self.borderColor = border;
    }
    return self;
}

- (void)dealloc {
    [_fillColor release];
    [_borderColor release];
    [super dealloc];
}

@end
