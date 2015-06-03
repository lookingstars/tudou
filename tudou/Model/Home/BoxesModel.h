//
//  Boxes.h
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BoxesModel : NSObject

@property(nonatomic, strong) NSMutableArray *videos;
@property(nonatomic, strong) NSNumber *ipad_display_type;
@property(nonatomic, strong) NSString *index_page_channel_icon;
@property(nonatomic, strong) NSNumber *display_type;
@property(nonatomic, strong) NSString *index_page_channel_icon_for_ipad;

@property(nonatomic, strong) NSNumber *video_count_for_ipad_index_page;
@property(nonatomic, strong) NSString *cid;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *sub_title;
@property(nonatomic, strong) NSString *redirect_type;

@property(nonatomic, strong) NSString *url_for_more_link;
@property(nonatomic, strong) NSString *is_podcast;

@property(nonatomic, assign) float height;

@end
