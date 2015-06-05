//
//  HomeBoxCell.h
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BoxesModel.h"
#import "VideosModel.h"

@class HomeBoxCell;

@protocol HomeBoxDelegate <NSObject>

@optional
-(void)didSelectHomeBox:(VideosModel *)video;

@end

@interface HomeBoxCell : UITableViewCell

@property(nonatomic, strong) BoxesModel *boxes;
@property(nonatomic, assign) id<HomeBoxDelegate> delegate;

@end
