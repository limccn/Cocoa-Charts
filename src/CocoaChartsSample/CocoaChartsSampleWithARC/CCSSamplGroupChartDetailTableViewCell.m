//
//  CCSSamplGroupChartDetailTableViewCell.m
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/4/6.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSamplGroupChartDetailTableViewCell.h"

@implementation CCSSamplGroupChartDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data{
    [self.lblTime setText:data[@"time"]];
    [self.lblPrice setText:data[@"price"]];
    [self.lblCount setText:data[@"count"]];
}

@end
