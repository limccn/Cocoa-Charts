//
//  CCSWMCloudRequest.m
//  CocoaChartsSample
//
//  Created by zhourr_ on 16/6/24.
//  Copyright © 2016年 limc. All rights reserved.
//

#import "CCSWMCloudRequest.h"

#define WMCLOUD_DOMAIN        @"https://api.wmcloud.com/data/v1/api/"
#define WMCLOUD_TOKEN         @"506f7271bb827ffbbbc0bc567f72038a84396dcebc3cebcebf71aaa6ddb98a86"

@implementation CCSWMCloudRequest

- (void)initialise
{
    [super initialise];
    // 设置 Http header
    self.headers = [NSMutableDictionary dictionaryWithDictionary:@{@"Authorization": [@"Bearer " stringByAppendingString:WMCLOUD_TOKEN]}];
    // 拼接 url
    self.url = [NSString stringWithFormat:@"%@%@", WMCLOUD_DOMAIN, self.url];
}

@end
