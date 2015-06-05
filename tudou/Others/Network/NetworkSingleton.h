//
//  NetworkSingleton.h
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//请求超时
#define TIMEOUT 30

typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlock)(NSString *error);



@interface NetworkSingleton : NSObject

+(NetworkSingleton *)sharedManager;
-(AFHTTPRequestOperationManager *)baseHtppRequest;

#pragma mark 获取土豆视频首页
-(void)getHomeResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取视频详情页
-(void)getVideoDetailResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取分类信息
-(void)getClassifyResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;

#pragma mark 获取订阅信息
-(void)getSubScribeResule:(NSDictionary *)userInfo url:(NSString *)url successBlock:(SuccessBlock)successBlock failureBlock:(FailureBlock)failureBlock;


@end
