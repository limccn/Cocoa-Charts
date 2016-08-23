//
//  CCSCacheManager.h
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/8/20.
//  Copyright © 2016年 limc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CCSCacheManager : NSObject

/** 缓存路径 */
@property(copy, nonatomic) NSString        *cachePath;

/** RLMRealm对象 */
@property(strong, nonatomic) RLMRealm      *realm;

/** 数据模型,相当于婊 */
@property(assign, nonatomic) Class          modelCls;

/** 数据模型,相当于婊 */
@property(strong, nonatomic) RLMResults    *allObjects;

/**
 * 初始化
 */
- (id)initWithPath:(NSString *)path model:(Class)class;

/**
 * 数量
 */
- (NSUInteger)count;

/**
 * 查询数据
 */
- (RLMResults *)selectWithRefresh:(BOOL) refresh;

@end
