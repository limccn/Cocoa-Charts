//
//  CCSSettingResetTableViewCell.h
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/4/11.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSSettingResetTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton     *btnReset;

- (void)setData:(NSDictionary *)data;

@end
