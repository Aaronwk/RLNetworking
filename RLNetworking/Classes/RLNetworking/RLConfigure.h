//
//  RLConfigure.h
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/24.
//  Copyright © 2019 objective. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLConfigure : NSObject

/**
 Desc:读取BaseUrl.所有配置的最终请求地址。
 */
@property (strong, nonatomic, class, readonly) NSURL *baseUrl;

/**
 Desc:读取BaseUrl.请求地址后缀。
 */
@property (strong, nonatomic, class, readonly) NSString *suffix;

/**
 Desc:是否在console输出log信息
 */
@property (assign, nonatomic, class) BOOL isLog;

/**
 Desc:是否配置过BaseUrl
 */
@property (assign, nonatomic, class) BOOL isBaseUrl;



@end

NS_ASSUME_NONNULL_END
