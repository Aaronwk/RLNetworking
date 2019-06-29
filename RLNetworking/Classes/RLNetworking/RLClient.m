//
//  RLConfiguration.m
//  RLNetworking_Example
//
//  Created by Aaron_wk on 2019/6/24.
//  Copyright © 2019 objective. All rights reserved.
//

#import "RLClient.h"
#import "RLNetworking.h"

@implementation RLClient



+ (void)configureBaseHost:(NSString *)host; {
    RLWrite(host, RLNetworkBaseUrlKey);
    RLConfigure.isBaseUrl = YES;
}

+ (void)configureTheDevelopmentWithHost:(NSString *)host post:(NSString *)post suffix:(NSString *)suffix {
    NSString *format = @"%@%@";
    NSString *url = RLString(format, host, post);
    RLWrite(url, RLNetworkBaseUrlDebugKey);
    RLWrite(suffix, RLNetworkUrlSuffixDebugKey);
}

+ (void)configureTheDistributionWithHost:(NSString *)host post:(NSString *)post suffix:(NSString *)suffix {
    NSString *format = @"%@%@";
    NSString *url = RLString(format, host, post);
    RLWrite(url, RLNetworkBaseUrlRelessKey);
    RLWrite(suffix, RLNetworkUrlSuffixRelessKey);
}

+ (void)applicationWillTerminate:(UIApplication *)application {
    RLRemoveObjectForKey(RLNetworkBaseUrlKey);
    RLRemoveObjectForKey(RLNetworkBaseUrlDebugKey);
    RLRemoveObjectForKey(RLNetworkBaseUrlRelessKey);
    RLRemoveObjectForKey(RLNetworkUrlSuffixDebugKey);
    RLRemoveObjectForKey(RLNetworkUrlSuffixRelessKey);
}

+ (void)setLogEnable:(BOOL)value {
    if(value){
        NSLog(@"开启日志");
    }else{
        NSLog(@"关闭日志");
    }
    RLConfigure.isLog = value;
}

@end
