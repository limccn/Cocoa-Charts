//
//  CCSHttpRequest.m
//  TabbarTest
//
//  Created by zhourr_ on 15/9/28.
//  Copyright © 2015年 zhourr_. All rights reserved.
//

#import "CCSHttpRequest.h"

#import "CCSHTTPSessionManager.h"
#import "MaskViewManager.h"

#ifndef HTTP_GET
#define HTTP_GET                                            @"GET"
#define HTTP_POST                                           @"POST"
#endif

@interface CCSHttpRequest()

/** mSessionTask */
@property(strong, nonatomic) NSURLSessionDataTask *sessionTask;

@end

@implementation CCSHttpRequest

- (id)init
{
    self = [super init];
    if(self){
        [self initialise];
    }
    return self;
}

- (id)initWithUrl:(NSString *)url
{
    self = [super init];
    if(self){
        self.url = url;
        [self initialise];
    }
    return self;
}

- (void)initialise
{
    self.canCancel = YES;
    self.isShowLoading = YES;
    self.isPage = NO;
}

/**
 * Http GET 请求
 */
- (void)get: (void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
    failure:(void (^)(AFHTTPRequestSerializer *operation, NSError *error))failure{
    [self getWithTag:RequestTagNone success:success failure:failure];
}

- (void)getWithTag:(HttpRequestTag)tag success:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure{
    // 验证 Http url
    if(![self checkURL]){
        return;
    }
    // 设置参数
    NSString *urlWithParams = self.url;
    // 将所有参数拼到 url 中
    for (int i=0; i<self.parameters.allKeys.count; i++) {
        NSString *param = nil;
        // 键
        NSString *key = [self.parameters.allKeys objectAtIndex:i];
        // 值
        if(0 == i){
            param = [NSString stringWithFormat:@"?%@=%@", key, [self.parameters objectForKey:key]];
        } else {
            param = [NSString stringWithFormat:@"&%@=%@", key, [self.parameters objectForKey:key]];
        }
        // 拼接字符串
        urlWithParams = [NSString stringWithFormat:@"%@%@", urlWithParams, param];
    }
    // 设置tag
    self.tag = tag;
    NSLog(@"%u GET URL: %@", self.tag, urlWithParams);
    
    // 判断是否显示进度条
    if (self.isShowLoading) {
        [MaskViewManager sharedMaskViewManager];
        [MaskViewManager show];
    }
    
    // 发送 GET 请求
    NSMutableURLRequest *request = [[AFJSONRequestSerializer serializer] requestWithMethod:HTTP_GET URLString:self.url parameters:self.parameters error:nil];
    // 设置 Header
    if (self.headers) {
        for (NSString *key in self.headers.allKeys) {
            [request addValue: self.headers[key] forHTTPHeaderField: key];
        }
    }
    // 获取 CCSHTTPSessionManager 单例
    CCSHTTPSessionManager *manager = [CCSHTTPSessionManager sharedClient];
    self.sessionTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            // 打印请求失败信息
            NSLog(@"error.code: %ld", (long)error.code);
            NSLog(@"error.localizedDescription: %@", error.localizedDescription);
            
            // 是否取消
            if (-999 == error.code) {
                [self requestField:NO];
            }else{
                [self requestField:YES];
            }
            failure(nil,nil);
        } else {
            [self requestComplete:responseObject];
            success(nil, responseObject);
        }
    }];
    [self.sessionTask resume];
    
    // 存储 afrequest
    [manager.afRequests addObject:self];
}

/**
 * Http Post 请求
 */
- (void)post: (void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure
{
    [self postWithTag:RequestTagNone success:success failure:failure];
}

- (void)postWithTag:(HttpRequestTag)tag success:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure
{
    // 验证 Http url
    if(![self checkURL]){
        return;
    }
    
    NSLog(@"POST URL: %@", self.url);
    
    // 格式化 Http 参数
    [self formatHttpParams];
    
    // 设置tag
    self.tag = tag;
    
    // 判断是否显示进度条
    if (self.isShowLoading) {
        [MaskViewManager sharedMaskViewManager];
        [MaskViewManager show];
    }
    
    // 获取 AFHTTPSessionManager 单例
    CCSHTTPSessionManager *manager = [CCSHTTPSessionManager sharedClient];
    
    // 发送 POST 请求
    self.sessionTask = [manager POST:self.url parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self requestComplete:responseObject];
        success(nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 打印请求失败信息
        if (error) {
            NSLog(@"error.code: %ld", (long)error.code);
            NSLog(@"NSErrorFailingURLStringKey: %@", [error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]);
            NSLog(@"error.localizedDescription: %@", error.localizedDescription);
        }
        // 是否取消
        if ([@"已取消" isEqualToString:[NSString stringWithFormat: @"%@", error.localizedDescription]]) {
            [self requestField:NO];
        }else{
            [self requestField:YES];
        }
        
        failure(nil,nil);
    }];
    // 存储 afrequest
    [manager.afRequests addObject:self];
}


/**
 * Http upload 上传文件
 */
- (void)upload: (void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure
{
    [self uploadWithTag:RequestTagNone success:success failure:failure];
}

- (void)uploadWithTag:(HttpRequestTag)tag success:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure
{
    // 验证 Http url
    if(![self checkURL]){
        return;
    }
    
    NSLog(@"POST URL: %@", self.url);
    
    // 格式化 Http 参数
    [self formatHttpParams];
    
    // 设置tag
    self.tag = tag;
    
    // 判断是否显示进度条
    if (self.isShowLoading) {
        [MaskViewManager sharedMaskViewManager];
        [MaskViewManager show];
    }
    
    // 获取 AFHTTPSessionManager 单例
    CCSHTTPSessionManager *manager = [CCSHTTPSessionManager sharedClient];
    
    // 设置超时时间
    manager.requestSerializer.timeoutInterval = UPLOAD_TIMEOUT_INTERVAL;
    
    // 发送 POST 请求
    self.sessionTask = [manager POST:self.url parameters:self.parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        [self requestComplete:responseObject];
        // 设置超时时间
        manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
        success(nil, responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 打印请求失败信息
        if (error) {
            NSLog(@"error.code: %ld", (long)error.code);
            NSLog(@"NSErrorFailingURLStringKey: %@", [error.userInfo objectForKey:@"NSErrorFailingURLStringKey"]);
            NSLog(@"error.localizedDescription: %@", error.localizedDescription);
        }
        // 是否取消
        if ([@"已取消" isEqualToString:[NSString stringWithFormat: @"%@", error.localizedDescription]]) {
            [self requestField:NO];
        }else{
            [self requestField:YES];
        }
        // 设置超时时间
        manager.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
        
        failure(nil,nil);
    }];
    // 存储 afrequest
    [manager.afRequests addObject:self];
}

/******************************************************************************
 * Private Method
 ******************************************************************************/

/**
 * 格式化 Http 参数
 */
- (void)formatHttpParams{
    // 参数为空时
    if (!self.parameters) {
        self.parameters = [[NSMutableDictionary alloc] init];
    }
    
    // 转换成 JSON
    self.postData = [NSJSONSerialization dataWithJSONObject:self.parameters options:NSJSONWritingPrettyPrinted error:nil];
    // 打印 JSON 格式 Http 参数
    NSLog(@"Http Params: %@",[[NSString alloc] initWithData:self.postData encoding:NSUTF8StringEncoding]);
}

- (BOOL)checkURL
{
    if(nil == self.url)
    {
        NSLog(@"URL is nil !");
        return NO;
    }
    else if([@"" isEqualToString:self.url])
    {
        NSLog(@"URL is Empty !");
        return NO;
    }
    else
    {
        return YES;
    }
}

- (void)cancelRequest
{
    NSLog(@"%s", __FUNCTION__);
    
    if (self.canCancel) {
        // 取消单个请求
        [self.sessionTask cancel];
        // 隐藏遮罩
        [MaskViewManager hide];
    }
}

- (void)cancelAllRequest
{
    NSLog(@"%s", __FUNCTION__);
    // 获得 AFHTTPSessionManager 单例
    CCSHTTPSessionManager *manager = [CCSHTTPSessionManager sharedClient];
    // 取消所有网络请求
    [manager.operationQueue cancelAllOperations];
    // 强制隐藏所有遮罩
    [MaskViewManager forceHide];
}

/**
 * Http 请求完成
 */
- (void)requestComplete: (id)responseData{
    NSLog(@"请求完成");
    NSLog(@"%u:%@", self.tag, PARSE_OBJECT(PARSE_JSON_DATA(responseData)));
    // 获得 AFHTTPSessionManager 单例
    CCSHTTPSessionManager *manager = [CCSHTTPSessionManager sharedClient];
    // 从 request 队列中移除
    [manager.afRequests removeObject:self];
    // 隐藏遮罩
    [MaskViewManager hide];
}

/**
 * Http 请求失败
 */
- (void)requestField :(BOOL)showReason{
    NSLog(@"请求失败");
    // 获得 AFHTTPSessionManager 单例
    CCSHTTPSessionManager *manager = [CCSHTTPSessionManager sharedClient];
    // 从 request 队列中移除
    [manager.afRequests removeObject:self];
    // 是否显示网络请求失败相关消息
    if (showReason) {
        // 提示网络请求失败相关消息
        NSLog(@"网络请求失败");
//        UIView *view = [[[UIApplication sharedApplication] windows] lastObject];
//        [view makeToast:[@"MSG_001_NO_NETWORK" localizedString] duration:1.0f position:CSToastPositionBottom title:nil];
    }
    // 隐藏遮罩
    [MaskViewManager hide];
}


/**
 * 设置是否需要loading图片
 */
- (void)setShouldShowLoadingImage:(BOOL)shouldShowLoading{
    self.isShowLoading = shouldShowLoading;
}

@end
