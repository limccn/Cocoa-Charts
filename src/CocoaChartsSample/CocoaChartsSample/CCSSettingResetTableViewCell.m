//
//  CCSSettingResetTableViewCell.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/4/11.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSettingResetTableViewCell.h"

@implementation CCSSettingResetTableViewCell

- (void)awakeFromNib {
    [self.btnReset setBackgroundColor:[UIColor redColor]];
    [self.btnReset.layer setCornerRadius:5.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data{
    [self.btnReset setTitle:data[@"title"] forState:UIControlStateNormal];
}

@end
