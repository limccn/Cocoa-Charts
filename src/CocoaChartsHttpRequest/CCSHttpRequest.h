//
//  CCSHttpRequest.h
//  TabbarTest
//
//  Created by zhourr_ on 15/9/28.
//  Copyright © 2015年 zhourr_. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetWorking.h"

/*******************************************************************************
 * uri tag
 *******************************************************************************/

/**
 * 每一个http请求地址都应该有对应的tag
 */
typedef enum
{
    RequestTagNone                          = 0,
    RequestTagNoMask                        = 10000,
    
    /** 获取股票列表 */
    RequestTagStockList,
    /** 获取K线交易数据 */
    RequestTagKLineData,
    /** 获取商品信息 */
    RequestTagProductData,
    /** 获取分时数据 */
    RequestTagTickData
    
} HttpRequestTag;

@interface CCSHttpRequest : NSObject

/** CCSHttpRequest Tag */
@property(assign, nonatomic) HttpRequestTag tag;

/** Http 地址 */
@property(copy, nonatomic) NSString              *url;
/** Http 请求头信息 */
@property(strong, nonatomic) NSMutableDictionary *headers;
/** 参数 */
@property(strong, nonatomic) NSMutableDictionary *parameters;
/** post 请求 data */
@property(strong, nonatomic) NSData              *postData;

/** 是否显示进度条 */
@property(assign, nonatomic) BOOL                 isShowLoading;

/** 是否可以cancel */
@property(assign, nonatomic) BOOL                 canCancel;

/** 是否分页 */
@property(assign, nonatomic) BOOL                 isPage;

/**
 * 初始化方法
 */
- (id)init;

/**
 * 初始化方法
 */
- (id)initWithUrl:(NSString *)url;

/**
 * 供子类实现
 */
- (void)initialise;

/**
 * Http GET 请求
 */
- (void)get: (void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
     failure:(void (^)(AFHTTPRequestSerializer *operation, NSError *error))failure;

- (void)getWithTag:(HttpRequestTag)tag success:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure;

/**
 * Http POST 请求
 */
- (void)post: (void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
         failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure;

- (void)postWithTag:(HttpRequestTag)tag success:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure;

/**
 * Http upload 上传文件
 */
- (void)upload: (void (^)(AFHTTPRequestSerializer *operation, id responseObject))success
       failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure;

- (void)uploadWithTag:(HttpRequestTag)tag success:(void (^)(AFHTTPRequestSerializer *operation, id responseObject))success failure:(void (^)(AFHTTPRequestSerializer *operation, id failure))failure;

/**
 * 取消单个 Http 请求
 */
- (void)cancelRequest;

/**
 * 取消所有 Http 请求
 */
- (void)cancelAllRequest;

/**
 * 设置是否需要loading图片
 */
- (void)setShouldShowLoadingImage:(BOOL)shouldShowLoading;

@end
