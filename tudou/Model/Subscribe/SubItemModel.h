//
//  SubItemModel.h
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubItemModel : NSObject

@property(nonatomic, strong) NSNumber *itemID;
@property(nonatomic, strong) NSString *formatTotalTime;
@property(nonatomic, strong) NSString *code;
@property(nonatomic, strong) NSNumber *totalTime;
@property(nonatomic, strong) NSNumber *pubDate;

@property(nonatomic, strong) NSString *playLink;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *userpic_220_220;
@property(nonatomic, strong) NSNumber *playNum;
@property(nonatomic, strong) NSString *bigPic;

@property(nonatomic, strong) NSNumber *limit;
@property(nonatomic, strong) NSString *picurl;
@property(nonatomic, strong) NSNumber *playtimes;
@property(nonatomic, strong) NSString *userpic;
@property(nonatomic, strong) NSString *formatPubDate;

@property(nonatomic, strong) NSString *type;
@property(nonatomic, strong) NSNumber *uid;

@end
