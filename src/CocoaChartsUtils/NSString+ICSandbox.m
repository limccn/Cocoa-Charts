//
//  NSString+ICSandbox.m
//  FinanceInfo
//
//  Created by zhourr_ on 16/1/19.
//  Copyright © 2016年 OHS. All rights reserved.
//

#import "NSString+ICSandbox.h"

@implementation NSString (ICSandbox)

+ (NSString *)homePath{
    return NSHomeDirectory();
}

+ (NSString *)applicationPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSApplicationDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)documentPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

+ (NSString *)libraryPreferencePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Preference"];
}

+ (NSString *)libraryCachesPath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingFormat:@"/Caches"];
}

+ (NSString *)tmpPath
{
    return [NSHomeDirectory() stringByAppendingFormat:@"/tmp"];
}

- (BOOL)hasLive
{
    if ( NO == [[NSFileManager defaultManager] fileExistsAtPath:self] )
    {
        return [[NSFileManager defaultManager] createDirectoryAtPath:self
                                         withIntermediateDirectories:YES
                                                          attributes:nil
                                                               error:NULL];
    }
    return YES;
}

//单个文件的大小

- (long long) fileSizeAtPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:self]){
        return [[manager attributesOfItemAtPath:self error:nil] fileSize];
    }
    
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M

- (float ) folderSizeAtPath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:self]) return 0;
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:self] objectEnumerator];
    
    NSString* fileName;
    
    long long folderSize = 0;
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        
        NSString* fileAbsolutePath = [self stringByAppendingPathComponent:fileName];
        
        folderSize += [fileAbsolutePath fileSizeAtPath];
        
    }
    
    return folderSize/(1024.0*1024.0);
    
}

/**
 * 遍历文件夹获得文件名
 */
- (NSArray *)fileAtFolder{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:self]){
        return [[NSArray alloc] init];
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:self] objectEnumerator];
    
    NSString* fileName;
    
    NSMutableArray *fileNames = [[NSMutableArray alloc] init];
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [self stringByAppendingPathComponent:fileName];
        [fileNames addObject:fileAbsolutePath];
    }
    
    return fileNames;
    
}

/**
 * 遍历文件夹获得文件大小,k
 */
- (NSArray *)fileSizeAtFolder{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:self]){
        return [[NSArray alloc] init];
    }
    
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:self] objectEnumerator];
    
    NSString* fileName;
    
    NSMutableArray *fileSizes = [[NSMutableArray alloc] init];
    
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [self stringByAppendingPathComponent:fileName];
        NSString *fileSize = [NSString stringWithFormat:@"%lld", [fileAbsolutePath fileSizeAtPath]];
        [fileSizes addObject: fileSize];
    }
    
    return fileSizes;
    
}

/**
 * 删除文件
 */
- (BOOL)deleteFile{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    
    if (![manager fileExistsAtPath:self]){
        return NO;
    }
    
    return [manager removeItemAtPath:self error:nil];
}

@end
