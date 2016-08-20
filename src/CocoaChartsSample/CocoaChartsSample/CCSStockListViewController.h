//
//  CCSStockListViewController.h
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/6/22.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCSStockListViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

/** 股票列表 */
@property (weak, nonatomic) IBOutlet UITableView      *tbStocks;

/** 价格保留小数位数 */
@property (assign, nonatomic) NSUInteger               scalePrice;

@end
