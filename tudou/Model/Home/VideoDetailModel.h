//
//  VideoDetailModel.h
//  tudou
//
//  Created by jinzelu on 15/6/4.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoDetailModel : NSObject

@property(nonatomic, strong) NSString *total_vv;
@property(nonatomic, strong) NSNumber *duration;
@property(nonatomic, strong) NSNumber *total_comment;
@property(nonatomic, strong) NSString *img;
@property(nonatomic, strong) NSString *title;

@property(nonatomic, strong) NSString *play_url;
@property(nonatomic, strong) NSString *channel_pic;
@property(nonatomic, strong) NSString *cats;
@property(nonatomic, strong) NSString *plid;
@property(nonatomic, strong) NSString *isVuser;

@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSNumber *format_flag;
@property(nonatomic, strong) NSString *img_hd;
@property(nonatomic, strong) NSString *iid;

@property(nonatomic, strong) NSNumber *subed_num;
@property(nonatomic, strong) NSString *item_id;
@property(nonatomic, strong) NSString *user_desc;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, strong) NSString *user_play_times;

@property(nonatomic, strong) NSString *stripe_bottom;
@property(nonatomic, strong) NSNumber *cid;
@property(nonatomic, strong) NSNumber *userid;
@property(nonatomic, strong) NSNumber *total_fav;
@property(nonatomic, strong) NSNumber *limit;

@property(nonatomic, strong) NSString *item_media_type;


@end
