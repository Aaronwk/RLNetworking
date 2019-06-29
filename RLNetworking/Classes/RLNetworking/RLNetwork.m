//
//  RLNetwork.m
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/28.
//  Copyright © 2019 objective. All rights reserved.
//

#import "RLNetwork.h"

#import "RLNetworking.h"

#import "RLConfigure.h"


@class RLLog;

@implementation RLParameter

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.requestMethod = RLGet;
        self.timeOut = 30;
        self.requestSerializer = RLHttp;
        self.responseSerializer = RLHttp;
        self.fileSuffix = @"jpg";
        self.manager = [self getAFnetworkManager];
    }
    return self;
}

- (AFHTTPSessionManager *)getAFnetworkManager {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json",
                                                                              @"text/html",
                                                                              @"text/json",
                                                                              @"text/plain",
                                                                              @"text/javascript",
                                                                              @"text/xml",
                                                                              @"application/ttf",
                                                                              @"image/*"]];
    return manager;
}

- (NSString *)url {
    if(_url.length){
        return _url;
    }
    return RLString(@"%@%@%@", RLConfigure.baseUrl, self.path, RLConfigure.suffix?:@"");
}

- (void)setRequestSerializer:(RLSerializer)requestSerializer {
    _requestSerializer = requestSerializer;
    AFHTTPSessionManager *manager = (AFHTTPSessionManager *)_manager;
    switch (requestSerializer) {
        case RLHttp:
            manager.requestSerializer = [AFHTTPRequestSerializer serializer];
            break;
        case RLJson:
            manager.requestSerializer = [AFJSONRequestSerializer serializer];
    }
}

- (void)setResponseSerializer:(RLSerializer)responseSerializer {
    _responseSerializer = responseSerializer;
    AFHTTPSessionManager *manager = (AFHTTPSessionManager *)_manager;
    switch (responseSerializer) {
        case RLHttp:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        case RLJson:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
    }
}

- (void)setTimeOut:(NSTimeInterval)timeOut {
    _timeOut = timeOut;
    AFHTTPSessionManager *manager = (AFHTTPSessionManager *)_manager;
    manager.requestSerializer.timeoutInterval = timeOut;
}

- (void)formData:(RLParameter *)parameter {
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i = 0; i<count; i++) {
        Ivar iva = ivar[i];
        const char *name = ivar_getName(iva);
        NSString *strName = [NSString stringWithUTF8String:name];
        id value = [parameter valueForKey:strName];
        [self setValue:value?:@"" forKey:strName];
    }
    free(ivar);
}


@end




@implementation RLNetwork

+ (NSDictionary *)rl_parseResponse:(id)responseObject {
    NSError *err = nil;
    if([responseObject isKindOfClass:[NSDictionary class]]) {
        return responseObject;
    }else{
        NSDictionary *result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&err];
        if(result == nil) {
            NSString *encodStr = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if(encodStr.length == 0) {return @{};}
            NSData *dutf8 = [encodStr dataUsingEncoding:NSUTF8StringEncoding];
            NSDictionary *result = [NSJSONSerialization JSONObjectWithData:dutf8 options:NSJSONReadingMutableContainers error:&err];
            return result;
        }
        return result;
    }
}

+ (NSURLSessionTask *)rl_request:(RLRequestParameter)requestParameter success:(RLRequestSuccess)success failure:(RLRequestFailure)failure {
    RLParameter *_parameter = [[RLParameter alloc] init];
    requestParameter(_parameter);
    NSURLSessionTask *_task;
    switch (_parameter.requestMethod) {
        case RLGet:
        {
            _task = [RLNetworkGet rl_request:^(RLParameter * _Nonnull parameter) {
                [parameter formData:_parameter];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
                success(task, response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
        }
            break;
        case RLPost:
        {
            _task = [RLNetworkPost rl_request:^(RLParameter * _Nonnull parameter) {
                [parameter formData:_parameter];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
                success(task, response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
        }
            break;
        case RLUpload:
        {
            _task = [RLNetworkUpload rl_request:^(RLParameter * _Nonnull parameter) {
                [parameter formData:_parameter];
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
                success(task, response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                failure(task, error);
            }];
        }
            break;
        case RLDownload:
            _task = [RLNetworkDownload rl_request:^(RLParameter * _Nonnull parameter) {
                [parameter formData:_parameter];
            } success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable response) {
                success(task, response);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
                failure(task, error);
            }];
            break;
    }
    return _task;
}


@end

@implementation RLNetworkGet

+ (NSURLSessionDataTask *)rl_request:(RLRequestParameter)requestParameter success:(RLRequestSuccess)success failure:(RLRequestFailure)failure {
    RLParameter *parameter = [[RLParameter alloc] init];
    requestParameter(parameter);
    [RLLog rl_logRequest:parameter];
    AFHTTPSessionManager *manager = (AFHTTPSessionManager *)parameter.manager;
    return [manager GET:parameter.url
             parameters:parameter.param
               progress:nil
                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    [RLLog rl_logResponse:responseObject task:task];
                    success(task, [self rl_parseResponse:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [RLLog rl_logError:error task:task];
        failure(task, error);
    }];
}

@end

@implementation RLNetworkPost

+ (NSURLSessionDataTask *)rl_request:(RLRequestParameter)requestParameter success:(RLRequestSuccess)success failure:(RLRequestFailure)failure {
    RLParameter *parameter = [[RLParameter alloc] init];
    requestParameter(parameter);
    [RLLog rl_logRequest:parameter];
    AFHTTPSessionManager *manager = (AFHTTPSessionManager *)parameter.manager;
    return  [manager POST:parameter.url?:RLString(@"%@%@%@", RLConfigure.baseUrl, parameter.path, RLConfigure.suffix)
               parameters:parameter.param
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      [RLLog rl_logResponse:responseObject task:task];
                      success(task, [self rl_parseResponse:responseObject]);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [RLLog rl_logError:error task:task];
        failure(task, error);
    }];
}

@end


@implementation RLNetworkUpload

+ (NSURLSessionDataTask *)rl_request:(RLRequestParameter)requestParameter success:(RLRequestSuccess)success failure:(RLRequestFailure)failure {
    RLParameter *parameter = [[RLParameter alloc] init];
    requestParameter(parameter);
    [RLLog rl_logRequest:parameter];
    AFHTTPSessionManager *manager = (AFHTTPSessionManager *)parameter.manager;
    return [manager POST:parameter.url
              parameters:parameter.param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                  if(parameter.data){
                      for (int i = 0; i < parameter.data.count; i++) {
                          NSString *imageFileName = @"";
                          if (parameter.fileName == nil ||
                              ![parameter.fileName isKindOfClass:[NSString class]] ||
                              parameter.fileName.length == 0) {
                              NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                              formatter.dateFormat = @"yyyyMMddHHmmss";
                              NSString *str = [formatter stringFromDate:[NSDate date] ];
                              imageFileName = RLString(@"%@%@%d.%@", parameter.fileName, str, i, parameter.fileSuffix);
                          }
                          [formData appendPartWithFileData:parameter.data[i] name:parameter.fileKey fileName:imageFileName mimeType:parameter.fileType];
                      }
                  }
              } progress:^(NSProgress * _Nonnull uploadProgress) {
                  [RLLog rl_logUpLoadProgress:uploadProgress];
                  if(parameter.uploadProgress){
                      parameter.uploadProgress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount);
                  }
              } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  [RLLog rl_logResponse:responseObject task:task];
                  success(task, [self rl_parseResponse:responseObject]);
              } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  [RLLog rl_logError:error task:task];
                  failure(task, error);
              }];
    
}

@end

@implementation RLNetworkDownload

+ (NSURLSessionTask *)rl_request:(RLRequestParameter)requestParameter success:(RLRequestSuccess)success failure:(RLRequestFailure)failure {
    RLParameter *_parameter = [[RLParameter alloc] init];
    requestParameter(_parameter);
    NSString *urlString = [_parameter.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    _parameter.manager = manager;
    NSURL *URL = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        [RLLog rl_logDownloadProgress:downloadProgress];
        if(_parameter.downloadProgress){
            _parameter.downloadProgress(downloadProgress.completedUnitCount, downloadProgress.totalUnitCount);
        }
    }  destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSURL *documentsDirectoryURL = [NSURL URLWithString:RLString(@"file://%@", _parameter.saveToPath)];
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if(error){
            [RLLog rl_logError:error task:nil];
            failure(nil, error);
        }else{
            if(_parameter.downloadFinish) {
                _parameter.downloadFinish(filePath);
            }
            [RLLog rl_logResponse:response task:nil];
            success(nil, [self rl_parseResponse:response]);
        }
    }];
    
    [downloadTask resume];
    return downloadTask;
}

@end


@implementation RLLog

+ (void)rl_logRequest:(RLParameter *)parameter {
    if(RLConfigure.isLog){
        NSString *requestMethod;
        switch (parameter.requestMethod) {
            case RLGet:
                requestMethod = @"GET";
                break;
            case RLPost:
                requestMethod = @"POST";
                break;
            case RLUpload:
                requestMethod = @"UPLOAD";
                break;
            case RLDownload:
                requestMethod = @"DOWNLOAD";
                break;
                
            default:
                break;
        }
        
        NSLog(@"\n-------------------------------------------------\n| 请求地址: %@\n| 请求方式: %@\n| 请求参数:⤵️\n%@\n-------------------------------------------------", parameter.url, requestMethod, parameter.param);
    }
}

+ (void)rl_logError:(NSError *)error task:(NSURLSessionDataTask *)task {
    if(RLConfigure.isLog) {
        NSLog(@"❎ 错误码: %ld", error.code);
        NSLog(@"❎ 错误信息: %@", error.errorMessage);
    }
}

+ (void)rl_logResponse:(id)response task:(NSURLSessionDataTask *)task {
    if(RLConfigure.isLog) {
        NSLog(@"✅");
        NSLog(@"\n%@", [self rl_parseResponse:response]);
    }
}

+ (void)rl_logUpLoadProgress:(NSProgress *)progress {
    if(RLConfigure.isLog){
        NSLog(@"\n上传数据包--%lld,数据包总量---%lld, ---%%02d",
              progress.completedUnitCount,
              progress.totalUnitCount,
              progress.completedUnitCount/
              progress.totalUnitCount * 100);
    }
}

+ (void)rl_logDownloadProgress:(NSProgress *)progress {
    if(RLConfigure.isLog){
        NSLog(@"\n下载数据包--%lld,数据包总量---%lld, ---%%02d",
              progress.completedUnitCount,
              progress.totalUnitCount,
              progress.completedUnitCount/
              progress.totalUnitCount * 100);
    }
}

@end
