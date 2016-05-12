//
//  CCSChartsSettingTableViewCell.m
//  Cocoa-Charts
//
//  Created by zhourr on 11-10-24.
//  Copyright 2011 limc.cn All rights reserved.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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

- (void)setIndicatorTextColor:(UIColor *) textColor{
    [self.lblTitle setTextColor:textColor];
}

@end
