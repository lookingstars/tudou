//
//  SubscribeCardView.h
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubItemModel.h"

@interface SubscribeCardView : UIView

@property(nonatomic, strong) UIImageView *imageView;
@property(nonatomic, strong) UILabel *titleLabel;

@property(nonatomic, strong) SubItemModel *subItem;

@end
