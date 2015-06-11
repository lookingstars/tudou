//
//  DisResultModel.h
//  tudou
//
//  Created by jinzelu on 15/6/11.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisResultModel : NSObject

@property(nonatomic, strong) NSNumber *group_number;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSMutableArray *items;
@property(nonatomic, strong) NSString *skip_url;
@property(nonatomic, strong) NSString *sub_title;

@property(nonatomic, strong) NSString *module_icon;
@property(nonatomic, strong) NSString *sub_type;
@property(nonatomic, strong) NSNumber *group_location;


@end
