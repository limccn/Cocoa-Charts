//
//  CCSSamplGroupChartDetailTableViewCell.h
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/4/6.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSSamplGroupChartDetailTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel      *lblTime;
@property (weak, nonatomic) IBOutlet UILabel      *lblPrice;
@property (weak, nonatomic) IBOutlet UILabel      *lblCount;

- (void)setData:(NSDictionary *)data;

@end
