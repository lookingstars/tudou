//
//  SubImageScrollView.h
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubItemModel.h"

@class SubImageScrollView;

@protocol SubImageScrollDelegate <NSObject>

@optional
-(void)didSelectSubScrollView:(SubImageScrollView *)subScrollView subItem:(SubItemModel *)subItem;

@end

@interface SubImageScrollView : UIView

@property(nonatomic, assign) id<SubImageScrollDelegate> delegate;
@property(nonatomic, strong) UIScrollView *scrollView;
@property(nonatomic, strong) NSArray *dataArray;

@end
