//
//  NSString+ICSandbox.h
//  FinanceInfo
//
//  Created by zhourr_ on 16/1/19.
//  Copyright © 2016年 OHS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ICSandbox)

+ (NSString *)homePath;

+ (NSString *)applicationPath;

+ (NSString *)documentPath;

+ (NSString *)libraryPreferencePath;

+ (NSString *)libraryCachesPath;

+ (NSString *)tmpPath;

- (BOOL)hasLive;

//单个文件的大小

- (long long) fileSizeAtPath;

//遍历文件夹获得文件夹大小，返回多少M

- (float ) folderSizeAtPath;

/**
 * 遍历文件夹获得文件名
 */
- (NSArray *)fileAtFolder;

/**
 * 遍历文件夹获得文件大小,k
 */
- (NSArray *)fileSizeAtFolder;

/**
 * 删除文件
 */
- (BOOL)deleteFile;

@end
