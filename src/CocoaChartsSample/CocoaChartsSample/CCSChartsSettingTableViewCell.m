//
//  CCSChartsSettingTableViewCell.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/4/11.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSChartsSettingTableViewCell.h"

@implementation CCSChartsSettingTableViewCell

- (void)awakeFromNib {
    [self.layoutConstraintTopLineHeight setConstant:0.5f];
    [self.layoutConstraintBottomLineHeight setConstant:0.5f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data{
    [self.lblTitle setText:data[@"title"]];
    
    if ([@"YES" isEqualToString: data[@"hidebottom"]]) {
        [self.vBottomLine setHidden:YES];
    }else{
        [self.vBottomLine setHidden:NO];
    }
    
    if ([@"YES" isEqualToString: data[@"hidetop"]]) {
        [self.vTopLine setHidden:YES];
    }else{
        [self.vTopLine setHidden:NO];
    }
    
    [self.layoutConstraintTopLineLeft setConstant:[data[@"left"] floatValue]];
}

@end
