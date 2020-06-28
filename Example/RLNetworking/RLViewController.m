//
//  RLViewController.m
//  RLNetworking
//
//  Created by objective on 06/24/2019.
//  Copyright (c) 2019 objective. All rights reserved.
//

#import "RLViewController.h"
#import "RLNetworking.h"


@interface RLViewController ()


@end

@implementation RLViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(RLConfigure.isLog){
        NSLog(@"日志状态开启");
//        NSLog(@"%@", RLConfigure.baseUrl);
    }else{
        NSLog(@"日志状态关闭");
    }
    [RLNetwork rl_request:^(RLParameter * _Nonnull parameter) {
        parameter.url = @"http://sk.cri.cn/am846/1564073621.ts?wsApp=HLS&wsMonitor=0";
        parameter.requestMethod = RLGet;
        parameter.timeOut = 10;
//        parameter.path = @"getSet";
//        parameter.param = @{@"type":@"1", @"name":@"carry"};
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable response) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
