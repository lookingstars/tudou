//
//  VideoInfoCell.h
//  tudou
//
//  Created by jinzelu on 15/6/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoDetailModel.h"

@class VideoInfoCell;

@protocol VideoInfoDelegate <NSObject>

@optional
-(void)didSelectOnInfoView:(NSString *)userId;

@end

@interface VideoInfoCell : UITableViewCell

@property(nonatomic, strong) id<VideoInfoDelegate> delegate;
@property(nonatomic, strong) VideoDetailModel *videoModel;

@end
