//
//  CCSMACDData.h
//  CocoaChartsSample
//
//  Created by limc on 11/12/13.
//  Copyright (c) 2013 limc. All rights reserved.
//

#import "CCSBaseData.h"

@interface CCSMACDData : CCSBaseData {
    CCFloat _dea;
    CCFloat _diff;
    CCFloat _macd;
    NSString *_date;
}

@property(assign, nonatomic) CCFloat dea;
@property(assign, nonatomic) CCFloat diff;
@property(assign, nonatomic) CCFloat macd;
@property(strong, nonatomic) NSString *date;

- (id)initWithDea:(CCFloat )dea diff:(CCFloat )diff macd:(CCFloat )macd date:(NSString *)date;

@end
