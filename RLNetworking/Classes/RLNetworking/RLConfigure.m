//
//  RLConfigure.m
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/24.
//  Copyright © 2019 objective. All rights reserved.
//

#import "RLConfigure.h"
#import "RLNetworking.h"

@implementation RLConfigure

@dynamic baseUrl;
@dynamic suffix;
@dynamic isLog;
static BOOL _isBaseUrl;
static BOOL _isLog;

+ (NSURL *)baseUrl {
    if(RLConfigure.isBaseUrl) {
        return RLStringForKey(RLNetworkBaseUrlKey).url;
    }
    RLRemoveObjectForKey(RLNetworkBaseUrlKey);
#if DEBUG
    return RLStringForKey(RLNetworkBaseUrlDebugKey).url;
#else
    return RLStringForKey(RLNetworkBaseUrlRelessKey).url;
#endif
}

+ (NSString *)suffix {
#if DEBUG
    return RLStringForKey(RLNetworkUrlSuffixDebugKey);
#else
    return RLStringForKey(RLNetworkUrlSuffixRelessKey);
#endif
}

+ (BOOL)isBaseUrl {
    return _isBaseUrl;
}

+ (void)setIsBaseUrl:(BOOL)isBaseUrl {
    _isBaseUrl = isBaseUrl;
}

+ (BOOL)isLog {
    return _isLog;
}

+ (void)setIsLog:(BOOL)isLog {
    _isLog = isLog;
}

@end
