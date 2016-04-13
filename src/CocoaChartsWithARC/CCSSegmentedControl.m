//
//  CCSSegmentedControl.m
//  CocoaChartsSampleWithARC
//
//  Created by zhourr_ on 16/4/1.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSSegmentedControl.h"

@interface CCSSegmentedControl (){
    /** 是否初始化 */
    BOOL                     _isInitialize;
    /** 是否需要重新加载 */
    BOOL                     _needsReload;
    /** 当前 view 大小 */
    CGSize                   _contentSize;
    
}

@end

@implementation CCSSegmentedControl

/*******************************************************************************
 * initialize
 *******************************************************************************/

- (id)init
{
    self = [super init];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    // 设置初始化标识
    _isInitialize = YES;
    
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 初始化
    if (_isInitialize) {
        _isInitialize = NO;
        _contentSize = self.bounds.size;
    }
    if (_needsReload) {
        _needsReload = NO;
        
        // reload
//        [self reload];
    }
}

/*******************************************************************************
 * Implements Of UIScrollViewDelegate
 *******************************************************************************/

/*******************************************************************************
 * Public Methods
 *******************************************************************************/

/*******************************************************************************
 * Private Methods
 *******************************************************************************/

/*******************************************************************************
 * Unused Codes
 *******************************************************************************/

@end
