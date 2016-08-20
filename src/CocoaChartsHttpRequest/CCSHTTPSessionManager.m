// CCSHTTPSessionManager.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "CCSHTTPSessionManager.h"

@implementation CCSHTTPSessionManager

+ (instancetype)sharedClient {
    static CCSHTTPSessionManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sharedClient = [[CCSHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
        // 跳过ssl证书认证
        _sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
//        _sharedClient.securityPolicy.allowInvalidCertificates = YES;
        
        // 申明请求的数据是 JSON 类型(Request),请求参数为 JSON 格式时才需要设置
        _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
        // 设置超时时间
        _sharedClient.requestSerializer.timeoutInterval = TIMEOUT_INTERVAL;
        // 设置编码
        _sharedClient.requestSerializer.stringEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingUTF8);
        // 设置 Header
        [_sharedClient.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        
        // 申明返回的结果
        _sharedClient.responseSerializer = [AFHTTPResponseSerializer serializer];
        // 申明返回的结果是json类型
//        _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        // 接收替换一致text/html或别的
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"text/json",@"application/json",@"application/x-javascript", nil];
        // 设置最大并行请求数量
        //        [_sharedClient.operationQueue setMaxConcurrentOperationCount:5];
        // 初始化数组
        _sharedClient.afRequests = [[NSMutableArray alloc] init];
    });
    
    return _sharedClient;
}

@end
