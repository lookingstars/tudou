//
//  SubscribeCell.h
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscribeModel.h"
#import "SubItemModel.h"


@class SubscribeCell;

@protocol SubscribeCellDelegate <NSObject>

@optional
-(void)didSelectSubscribeCell:(SubscribeCell *)subCell subItem:(SubItemModel *)subItem;

@end

@interface SubscribeCell : UITableViewCell

@property(nonatomic, assign) id<SubscribeCellDelegate> delegate;

@property(nonatomic, strong) SubscribeModel *subscribeM;


@end
