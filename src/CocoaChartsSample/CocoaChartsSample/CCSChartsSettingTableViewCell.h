//
//  CCSChartsSettingTableViewCell.h
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/4/11.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSChartsSettingTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView      *vTopLine;
@property (weak, nonatomic) IBOutlet UIView      *vBottomLine;

@property (weak, nonatomic) IBOutlet UILabel     *lblTitle;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintTopLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintBottomLineHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint      *layoutConstraintTopLineLeft;

- (void)setData:(NSDictionary *)data;

@end
