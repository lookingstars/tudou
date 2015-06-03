//
//  HomeModel.h
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeModel : NSObject

@property(nonatomic, strong) NSString *search_default_word_for_ipad;
@property(nonatomic, strong) NSMutableArray *boxes;
@property(nonatomic, strong) NSMutableArray *banner;
@property(nonatomic, strong) NSString *index_channel_content_version;

@end
