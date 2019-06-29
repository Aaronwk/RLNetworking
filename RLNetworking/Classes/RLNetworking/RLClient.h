//
//  RLClient.h
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/24.
//  Copyright © 2019 objective. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLClient : NSObject




/// 配置用于直接发起请求的url
/// @param url 请求的url.优先级高于 ’configureTheDevelopmentWithHost ‘、’configureTheDistributionWithHost‘
+ (void)configureBaseHost:(NSString *)host;

/// 设置开发模式下的请求信息
/// @param host 服务器主地址        http://xxx.xxx.xxx
/// @param post 端口                      8888
/// @param suffix 后缀                 .php
+ (void)configureTheDevelopmentWithHost:(NSString *)host
                                   post:(NSString *)post
                                 suffix:(NSString *)suffix;
/// 设置发布模式下的请求信息
/// @param host 服务器主地址      http://www.xxx.com
/// @param post 端口                    8080
/// @param suffix 后缀                .php
+ (void)configureTheDistributionWithHost:(NSString *)host
                                    post:(NSString *)post
                                  suffix:(NSString *)suffix;


/// 设置是否在console输出log信息
/// @param value 默认NO(不输出log); 设置为YES, 输出可供调试参考的log信息..
+ (void)setLogEnable:(BOOL)value;


/// 清空所有配置
+ (void)applicationWillTerminate:(UIApplication *)application;


@end

NS_ASSUME_NONNULL_END
