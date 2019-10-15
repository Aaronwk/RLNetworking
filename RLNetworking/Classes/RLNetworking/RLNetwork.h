//
//  RLNetwork.h
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/28.
//  Copyright © 2019 objective. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, RLRequestMethod) {
    RLPost,     // POST请求
    RLGet,      // GET请求
    RLUpload,   // 上传操作<FormData>
    RLDownload  // 下载操作
};

typedef NS_ENUM(NSUInteger, RLSerializer) {
    RLJson,     // JSON
    RLHttp,     // HTTP
};

/**
 Desc:上传文件的实时进度回调
 */
typedef void(^RLUploadProgress)(int64_t bytesProgress, int64_t totalBytesProgress);
/**
 Desc:下载文件的实时进度回调
 */
typedef void(^RLDownloadProgress)(int64_t bytesProgress, int64_t totalBytesProgress);
/**
 Desc:下载完成回调
 */
typedef void(^RLDownloadFinish)(NSURL * filePath);

@class AFURLSessionManager;

@interface RLParameter : NSObject

/**
 Desc:请求路径，用户与BaseUrl结合使用。
 * 用于与BaseUrl结合使用
 */
@property (copy, nonatomic) NSString *path;
/**
 Desc:请求URL。
 * 该URL为完成的请求地址，优先级高于Path。
 */
@property (copy, nonatomic) NSString *url;
/**
 Desc:请求参数集
 * 用于上传服务器的参数集合。改参数与Path/url配合使用。
 * 例:@{@"type":@"1", @"id":@"1"}
 */
@property (strong, nonatomic) NSDictionary *param;
/**
 Desc:请求超时时间。
 * 默认为 30s
 */
@property (assign, nonatomic) NSTimeInterval timeOut;
/**
 Desc:请求发起时，字符串/URL格式编码的参数序列化。
 * JSON & HTTP
 */
@property (assign, nonatomic) RLSerializer requestSerializer;

/**
 Desc:服务器响应信息的序列化
 * JSON & HTTP
 */
@property (assign, nonatomic) RLSerializer responseSerializer;
/**
 Desc:需要上传的文件集
 * 单个&多个通用
 */
@property (strong, nonatomic) NSArray <NSData *> *data;
/**
 Desc:上传文件的后缀名
 * 默认为 .jpg
 */
@property (copy, nonatomic) NSString *fileSuffix;
/**
 Desc:上传时的文件名称。注* data存在时使用
 * 格式为:[fileName][时间格式][编号].[fileSuffix]
 * fileSuffix 默认为JPG
 * 时间格式:yyyyMMddHHmmss
 */
@property (copy, nonatomic) NSString *fileName;
/**
 Desc:服务器约定的读取键(key)。注* data存在时使用
 * 根据服务器要求，自由定制。
 */
@property (copy, nonatomic) NSString *fileKey;
/**
 Desc:上传文件的类型。注* data存在时使用
 * image/jpeg 等等。
 */
@property (copy, nonatomic) NSString *fileType;
/**
 Desc:文件存储路径
 * 下载完成时，文件存储的路径。
 */
@property (copy, nonatomic) NSString *saveToPath;
/**
 Desc:请求方式
 * POST | GET | UPLOAD | DOWNLAOD
 */
@property (assign, nonatomic) RLRequestMethod requestMethod;
/**
 Desc:上传数据进度监听回调
 */
@property (copy, nonatomic) RLUploadProgress uploadProgress;
/**
 Desc:下载数据进度监听回调
 */
@property (copy, nonatomic) RLDownloadProgress downloadProgress;
/**
 Desc:下载数据完成回调
 */
@property (copy, nonatomic) RLDownloadFinish downloadFinish;

/**
 Desc:这是“AFHTTPSessionManager”的基类
 * 1.它为发出HTTP请求添加了特定的功能。如果您希望对“AFURLSessionManager”进行专门针对HTTP的扩展，请考虑将“AFHTTPSessionManager”子类化。
 * 2.但是当前manager默认初始为AFHTTPSessionManager。原因为此工具主要针对HTTP请求来做的封装。
 * 3.如果需要AFURLSessionManager。请单独定制并赋值给manager。
 */
@property (strong, nonatomic) AFURLSessionManager *manager;

/**
 Desc:平行转移模型
 */
- (void)formData:(RLParameter *)parameter;

@end

/**
 Desc:参数钩子
 */
typedef void (^RLRequestParameter)(RLParameter *p);
/**
 Desc:请求成功块
 */
typedef void (^RLRequestSuccess)(NSURLSessionDataTask * _Nullable task, id _Nullable response);
/**
 Desc:请求失败块
 */
typedef void (^RLRequestFailure)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error);

@interface RLNetwork : NSObject


+ (NSURLSessionDataTask *)rl_request:(RLRequestParameter)requestParameter
                             success:(RLRequestSuccess)success
                             failure:(RLRequestFailure)failure;

@end


@interface RLNetworkGet : RLNetwork
@end

@interface RLNetworkPost : RLNetwork
@end

@interface RLNetworkUpload : RLNetwork
@end

@interface RLNetworkDownload : RLNetwork
@end

@interface RLLog : RLNetwork

+ (void)rl_logRequest:(RLParameter *)parameter;

+ (void)rl_logError:(NSError *_Nullable)error task:(NSURLSessionDataTask *_Nullable)task;

+ (void)rl_logResponse:(id _Nullable )response task:(NSURLSessionDataTask *_Nullable)task;

+ (void)rl_logUpLoadProgress:(NSProgress *)progress;

+ (void)rl_logDownloadProgress:(NSProgress *)progress;

@end


NS_ASSUME_NONNULL_END
