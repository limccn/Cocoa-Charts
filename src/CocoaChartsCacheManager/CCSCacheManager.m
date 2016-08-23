//
//  CCSCacheManager.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/8/20.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSCacheManager.h"

@interface CCSCacheManager(){
}

@end

@implementation CCSCacheManager

- (id)init
{
    self = [super init];
    if(self){
        [self initialise];
    }
    return self;
}

- (id)initWithPath:(NSString *)path model:(Class)class
{
    self = [super init];
    if(self){
        self.cachePath = path;
        self.modelCls = class;
        [self initialise];
    }
    return self;
}

- (void)initialise
{
    NSArray *arrCacheDic = [self.cachePath split:@"/"];
    NSString *cacheDic = [self.cachePath replaceAll:arrCacheDic.lastObject target:@""];
    if ([cacheDic hasLive]) {
        self.realm = [RLMRealm realmWithPath: self.cachePath];
    }
    [self selectWithNeedRefresh:YES];
}

- (NSUInteger)count{
    if (self.allObjects) {
        return self.allObjects.count;
    }
    return 0;
}

- (RLMResults *)selectWithRefresh:(BOOL) refresh{
    if (!self.modelCls || !self.realm) {
        self.allObjects = nil;
        return nil;
    }
    self.allObjects = [self.modelCls allObjectsInRealm: self.realm];
    return self.allObjects;
}

@end
