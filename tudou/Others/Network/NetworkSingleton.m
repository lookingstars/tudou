//
//  NetworkSingleton.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "NetworkSingleton.h"

@implementation NetworkSingleton

+(NetworkSingleton *)sharedManager{
    static NetworkSingleton *sharedNetworkSingleton = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate,^{
        sharedNetworkSingleton = [[self alloc] init];
    });
    return sharedNetworkSingleton;
}
-(AFHTTPRequestOperationManager *)baseHtppRequest{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setTimeoutInterval:TIMEOUT];
    
    return manager;
}

#pragma mark 获取土豆视频首页
-(void)getHomeResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"%@",responseObject);
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"失败");
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取视频详情页
-(void)getVideoDetailResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}

#pragma mark 获取分类信息
//http://api.3g.tudou.com/v4_5/recommended_channels?_e_=md5&_s_=b61ce6e69ffa8e45172adbb3b7e01fa6&_t_=1433404452&excludeNew=0&guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pg=1&pid=c0637223f8b69b02&pz=30&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
-(void)getClassifyResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock{
    AFHTTPRequestOperationManager *manager = [self baseHtppRequest];
    
    NSString *urlStr = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [manager GET:urlStr parameters:userInfo success:^(AFHTTPRequestOperation *operation, id responseObject){
        successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error){
        failureBlock(@"网络连接失败");
    }];
}





















@end
