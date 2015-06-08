//
//  RecommendModel.h
//  tudou
//
//  Created by jinzelu on 15/6/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendModel : NSObject

@property(nonatomic, strong) NSNumber *total_pv;
@property(nonatomic, strong) NSString *pubdate;
@property(nonatomic, strong) NSString *img_16_9;
@property(nonatomic, strong) NSString *pv_pr;
@property(nonatomic, strong) NSNumber *duration;

@property(nonatomic, strong) NSString *pv;
@property(nonatomic, strong) NSNumber *total_comment;
@property(nonatomic, strong) NSString *img;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *state;

@property(nonatomic, strong) NSString *cats;
@property(nonatomic, strong) NSString *username;
@property(nonatomic, strong) NSMutableArray *tags;
@property(nonatomic, strong) NSString *img_hd;
@property(nonatomic, strong) NSString *itemCode;

@property(nonatomic, strong) NSString *total_down;
@property(nonatomic, strong) NSString *total_up;
@property(nonatomic, strong) NSString *desc;
@property(nonatomic, strong) NSString *stripe_bottom;
@property(nonatomic, strong) NSString *userid;

@property(nonatomic, strong) NSNumber *total_fav;
@property(nonatomic, strong) NSString *reputation;
@property(nonatomic, strong) NSString *limit;

@property(nonatomic, strong) NSString *time;



@end
