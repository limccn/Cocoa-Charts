//
//  CCSSegmentedControl.m
//  Cocoa-Charts
//
//  Created by limc on 11-11-8.
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
