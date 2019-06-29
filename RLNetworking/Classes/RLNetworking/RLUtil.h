//
//  RLUtil.h
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/24.
//  Copyright © 2019 objective. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RLUtil : NSObject



#ifdef DEBUG
#define NSLog(args...) ExtendNSLog(__FILE__,__LINE__,__PRETTY_FUNCTION__,args);
#else
#define NSLog(x...)
#endif

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...);


#pragma mark — UserDefaults

/**
 - String(...) [NSString StringWithFormat] 重定义
 */
NSString *RLString(NSString *format, ...);

/**
 Desc:删除某某配置
 */
void RLRemoveObjectForKey(NSString *key);

/**
 Desc:写入UserDefault
 */
void RLWriteBool(BOOL value, NSString *key);
void RLWrite(id obj, NSString *key);

/**
 Desc:读取UserDefaust
 */
BOOL RLBoolForKey(NSString *key);
NSString *RLStringForKey(NSString *key);

@end

@interface NSString (URL)

- (NSURL *)url;

@end

@interface NSURL (String)

- (NSString *)string;

@end

@interface NSError (ErrorMessage)

/**
 Desc:根据code码返回中文信息。
 */
- (NSString *)errorMessage;

@end

NS_ASSUME_NONNULL_END
