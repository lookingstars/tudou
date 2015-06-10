//
//  ChannelItem.h
//  tudou
//
//  Created by jinzelu on 15/6/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelItem : NSObject

@property(nonatomic, strong) NSNumber *itemId;
@property(nonatomic, strong) NSNumber *totalTime;
@property(nonatomic, strong) NSString *picUrl_448x252;
@property(nonatomic, strong) NSString *playtimes_str;
@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *playtimes;
@property(nonatomic, strong) NSString *picUrl_200x112;
@property(nonatomic, strong) NSString *icode;
@property(nonatomic, strong) NSString *playUrl;
@property(nonatomic, strong) NSString *timeStr;//自定义新增


@end
