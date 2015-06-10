//
//  ChannelModel.h
//  tudou
//
//  Created by jinzelu on 15/6/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChannelModel : NSObject

@property(nonatomic, strong) NSString *pic;
@property(nonatomic, strong) NSString *about_myself;
@property(nonatomic, strong) NSString *subed_count;
@property(nonatomic, strong) NSString *home_pic;
@property(nonatomic, strong) NSNumber *id;

@property(nonatomic, strong) NSString *view_count;
@property(nonatomic, strong) NSString *video_count;
@property(nonatomic, strong) NSNumber *totalPlaylistCount;
@property(nonatomic, strong) NSNumber *is_sub;
@property(nonatomic, strong) NSString *homeQrcode;

@property(nonatomic, strong) NSNumber *play_times;
@property(nonatomic, strong) NSString *nick;
@property(nonatomic, strong) NSString *sub_count;
@property(nonatomic, strong) NSString *homeUrl;
@property(nonatomic, strong) NSString *isVuser;

@end
