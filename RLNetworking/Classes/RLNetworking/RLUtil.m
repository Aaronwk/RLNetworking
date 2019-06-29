//
//  RLUtil.m
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/24.
//  Copyright © 2019 objective. All rights reserved.
//

#import "RLUtil.h"
#import "RLNetworking.h"

@implementation RLUtil

void ExtendNSLog(const char *file, int lineNumber, const char *functionName, NSString *format, ...)
{
    va_list ap;
    
    va_start (ap, format);
    
    if (![format hasSuffix: @"\n"])
    {
        format = [format stringByAppendingString: @"\n"];
    }
    
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    
    va_end (ap);
    
    NSString *fileName = [[NSString stringWithUTF8String:file] lastPathComponent];
    fprintf(stderr, "(%s) (%s:%d) %s",
            functionName, [fileName UTF8String],
            lineNumber, [body UTF8String]);
}


#pragma mark - -------- String Format ---------
/**
 - String(...) [NSString StringWithFormat] 重定义
 */
NSString *RLString(NSString *format, ...) {
    va_list ap;
    va_start (ap, format);
    NSString *body = [[NSString alloc] initWithFormat:format arguments:ap];
    va_end (ap);
    return body;
}

/**
 Desc:删除某某配置
 */
void RLRemoveObjectForKey(NSString *key) {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 Desc:写入UserDefaust
 */
void RLWriteBool(BOOL value, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
void RLWrite(id obj, NSString *key) {
    [[NSUserDefaults standardUserDefaults] setObject:obj forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 Desc:读取UserDefaust
 */
BOOL RLBoolForKey(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}
NSString *RLStringForKey(NSString *key) {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}


@end

@implementation NSString (URL)

- (NSURL *)url {
    return [NSURL URLWithString:self];
}

@end

@implementation NSURL (String)

- (NSString *)string {
    return RLString(@"%@", self);
}

@end

@implementation NSError (ErrorMessage)

- (NSString *)errorMessage {
    
    NSString *errorMesg;
    switch (self.code) {
        case -1://NSURLErrorUnknown
            errorMesg = @"未知错误";
            break;
        case -999://NSURLErrorCancelled
            errorMesg = @"无效的URL地址";
            break;
        case -1000://NSURLErrorBadURL
            errorMesg = @"无效的URL地址";
            break;
        case -1001://NSURLErrorTimedOut
            errorMesg = @"网络不给力，请稍后再试";
            break;
        case -1002://NSURLErrorUnsupportedURL
            errorMesg = @"不支持的URL地址";
            break;
        case -1003://NSURLErrorCannotFindHost
            errorMesg = @"找不到服务器";
            break;
        case -1004://NSURLErrorCannotConnectToHost
            errorMesg = @"连接不上服务器";
            break;
        case -1103://NSURLErrorDataLengthExceedsMaximum
            errorMesg = @"请求数据长度超出最大限度";
            break;
        case -1005://NSURLErrorNetworkConnectionLost
            errorMesg = @"网络连接异常";
            break;
        case -1006://NSURLErrorDNSLookupFailed
            errorMesg = @"DNS查询失败";
            break;
        case -1007://NSURLErrorHTTPTooManyRedirects
            errorMesg = @"HTTP请求重定向";
            break;
        case -1008://NSURLErrorResourceUnavailable
            errorMesg = @"资源不可用";
            break;
        case -1009://NSURLErrorNotConnectedToInternet
            errorMesg = @"无网络连接";
            break;
        case -1010://NSURLErrorRedirectToNonExistentLocation
            errorMesg = @"重定向到不存在的位置";
            break;
        case -1011://NSURLErrorBadServerResponse
            errorMesg = @"服务器响应异常";
            break;
        case -1012://NSURLErrorUserCancelledAuthentication
            errorMesg = @"用户取消授权";
            break;
        case -1013://NSURLErrorUserAuthenticationRequired
            errorMesg = @"需要用户授权";
            break;
        case -1014://NSURLErrorZeroByteResource
            errorMesg = @"零字节资源";
            break;
        case -1015://NSURLErrorCannotDecodeRawData
            errorMesg = @"无法解码原始数据";
            break;
        case -1016://NSURLErrorCannotDecodeContentData
            errorMesg = @"无法解码内容数据";
            break;
        case -1017://NSURLErrorCannotParseResponse
            errorMesg = @"无法解析响应";
            break;
        case -1018://NSURLErrorInternationalRoamingOff
            errorMesg = @"国际漫游关闭";
            break;
        case -1019://NSURLErrorCallIsActive
            errorMesg = @"被叫激活";
            break;
        case -1020://NSURLErrorDataNotAllowed
            errorMesg = @"数据不被允许";
            break;
        case -1021://NSURLErrorRequestBodyStreamExhausted
            errorMesg = @"请求体";
            break;
        case -1100://NSURLErrorFileDoesNotExist
            errorMesg = @"文件不存在";
            break;
        case -1101://NSURLErrorFileIsDirectory
            errorMesg = @"文件是个目录";
            break;
        case -1102://NSURLErrorNoPermissionsToReadFile
            errorMesg = @"无读取文件权限";
            break;
        case -1200://NSURLErrorSecureConnectionFailed
            errorMesg = @"安全连接失败";
            break;
        case -1201://NSURLErrorServerCertificateHasBadDate
            errorMesg = @"服务器证书失效";
            break;
        case -1202://NSURLErrorServerCertificateUntrusted
            errorMesg = @"不被信任的服务器证书";
            break;
        case -1203://NSURLErrorServerCertificateHasUnknownRoot
            errorMesg = @"未知Root的服务器证书";
            break;
        case -1204://NSURLErrorServerCertificateNotYetValid
            errorMesg = @"服务器证书未生效";
            break;
        case -1205://NSURLErrorClientCertificateRejected
            errorMesg = @"客户端证书被拒";
            break;
        case -1206://NSURLErrorClientCertificateRequired
            errorMesg = @"需要客户端证书";
            break;
        case -2000://NSURLErrorCannotLoadFromNetwork
            errorMesg = @"无法从网络获取";
            break;
        case -3000://NSURLErrorCannotCreateFile
            errorMesg = @"无法创建文件";
            break;
        case -3001:// NSURLErrorCannotOpenFile
            errorMesg = @"无法打开文件";
            break;
        case -3002://NSURLErrorCannotCloseFile
            errorMesg = @"无法关闭文件";
            break;
        case -3003://NSURLErrorCannotWriteToFile
            errorMesg = @"无法写入文件";
            break;
        case -3004://NSURLErrorCannotRemoveFile
            errorMesg = @"无法删除文件";
            break;
        case -3005://NSURLErrorCannotMoveFile
            errorMesg = @"无法移动文件";
            break;
        case -3006://NSURLErrorDownloadDecodingFailedMidStream
            errorMesg = @"下载解码数据失败";
            break;
        case -3007://NSURLErrorDownloadDecodingFailedToComplete
            errorMesg = @"下载解码数据失败";
            break;
    }
    return errorMesg;
}

@end

static inline void rl_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (WFUnicode)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];
    
    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (WFUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        rl_swizzleSelector(class, @selector(description), @selector(rl_description));
        rl_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(rl_descriptionWithLocale:));
        rl_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(rl_descriptionWithLocale:indent:));
    });
}

- (NSString *)rl_description {
    return [[self rl_description] stringByReplaceUnicode];
}

- (NSString *)rl_descriptionWithLocale:(nullable id)locale {
    return [[self rl_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)rl_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self rl_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (WFUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        rl_swizzleSelector(class, @selector(description), @selector(rl_description));
        rl_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(rl_descriptionWithLocale:));
        rl_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(rl_descriptionWithLocale:indent:));
    });
}

- (NSString *)rl_description {
    return [[self rl_description] stringByReplaceUnicode];
}

- (NSString *)rl_descriptionWithLocale:(nullable id)locale {
    return [[self rl_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)rl_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self rl_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (WFUnicode)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        rl_swizzleSelector(class, @selector(description), @selector(rl_description));
        rl_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(rl_descriptionWithLocale:));
        rl_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(rl_descriptionWithLocale:indent:));
    });
}

- (NSString *)rl_description {
    return [[self rl_description] stringByReplaceUnicode];
}

- (NSString *)rl_descriptionWithLocale:(nullable id)locale {
    return [[self rl_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)rl_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self rl_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
