//
//  MaskViewManager.h
//  HX_SHOP
//
//  Created by lengyc on 11/11/14.
//  Copyright (c) 2014 TES. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MBProgressHUD.h"

@interface MaskViewManager : NSObject

// 获取遮罩对象的实例
+ (MaskViewManager *)sharedMaskViewManager;

// 显示遮罩
+ (void)show;

// 隐藏遮罩
+ (void)hide;

// 强制隐藏遮罩
+ (void)forceHide;

@end
