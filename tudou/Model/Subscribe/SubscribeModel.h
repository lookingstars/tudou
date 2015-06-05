//
//  SubscribeModel.h
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubscribeModel : NSObject

@property(nonatomic, strong) NSNumber *video_count;
@property(nonatomic, strong) NSString *Description;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *channelized_type;
@property(nonatomic, strong) NSString *subed_count;

@property(nonatomic, strong) NSMutableArray *last_item;
@property(nonatomic, strong) NSString *podcast_user_id;
@property(nonatomic, strong) NSString *isVuser;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *avatar;

//+(NSDictionary *)replacedKeyFromPropertyName;

@end
