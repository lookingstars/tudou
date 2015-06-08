//
//  SubscribeCardView.h
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubItemModel.h"

@class SubscribeCardView;

@protocol SubscribeCardDelegate <NSObject>

@optional
-(void)didSelectSubImageCard:(SubscribeCardView *)subImageCard subItem:(SubItemModel *)subItem;

@end

@interface SubscribeCardView : UIView

@property(nonatomic, assign) id<SubscribeCardDelegate> delegate;
@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) SubItemModel *subItem;

@end
