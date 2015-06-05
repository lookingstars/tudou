//
//  HomeVideoBoxCell.m
//  tudou
//
//  Created by jinzelu on 15/6/4.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "HomeVideoBoxCell.h"
#import "UIImageView+WebCache.h"
#import "ImageCardView.h"
#import "MJExtension.h"

@interface HomeVideoBoxCell ()
{
    UILabel *_titleLabel;
    UIImageView *_imageView;
    ImageCardView *_cardView1;
    ImageCardView *_cardView2;
    ImageCardView *_cardView3;
    ImageCardView *_cardView4;
    ImageCardView *_cardView5;
    ImageCardView *_cardView6;
}

@end

@implementation HomeVideoBoxCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = navigationBarColor;
        [self initViews];
    }
    return self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initViews{
    //背景
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 5, screen_width, 40+230+230)];
    backView.backgroundColor = [UIColor whiteColor];
    [self addSubview:backView];
    //头
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 40)];
    [backView addSubview:headView];
    //
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 30)];
    [backView addSubview:_imageView];
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, 0, 100, 40)];
    _titleLabel.textColor = navigationBarColor;
    [headView addSubview:_titleLabel];
    //
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5, 38, screen_width-10, 1)];
    lineView.backgroundColor = navigationBarColor;
    [backView addSubview:lineView];
    //图
    _cardView1 = [[ImageCardView alloc] initWithFrame:CGRectMake(0, 40, (screen_width-5)/3, 230)];
    _cardView2 = [[ImageCardView alloc] initWithFrame:CGRectMake((screen_width-5)/3, 40, (screen_width-5)/3, 230)];
    _cardView3 = [[ImageCardView alloc] initWithFrame:CGRectMake((screen_width-5)*2/3, 40, (screen_width-5)/3, 230)];
    
    _cardView4 = [[ImageCardView alloc] initWithFrame:CGRectMake(0, 40+230, (screen_width-5)/3, 230)];
    _cardView5 = [[ImageCardView alloc] initWithFrame:CGRectMake((screen_width-5)/3, 40+230, (screen_width-5)/3, 230)];
    _cardView6 = [[ImageCardView alloc] initWithFrame:CGRectMake((screen_width-5)*2/3, 40+230, (screen_width-5)/3, 230)];
    
    [backView addSubview:_cardView1];
    [backView addSubview:_cardView2];
    [backView addSubview:_cardView3];
    [backView addSubview:_cardView4];
    [backView addSubview:_cardView5];
    [backView addSubview:_cardView6];
}

-(void)setBoxes:(BoxesModel *)boxes{
    _titleLabel.text = boxes.title;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:boxes.index_page_channel_icon] placeholderImage:nil];
    VideosModel *video1 = [VideosModel objectWithKeyValues:boxes.videos[0]];
    VideosModel *video2 = [VideosModel objectWithKeyValues:boxes.videos[1]];
    VideosModel *video3 = [VideosModel objectWithKeyValues:boxes.videos[2]];
    VideosModel *video4 = [VideosModel objectWithKeyValues:boxes.videos[3]];
    VideosModel *video5 = [VideosModel objectWithKeyValues:boxes.videos[4]];
    VideosModel *video6 = [VideosModel objectWithKeyValues:boxes.videos[5]];
    [_cardView1 setVideo:video1];
    [_cardView2 setVideo:video2];
    [_cardView3 setVideo:video3];
    [_cardView4 setVideo:video4];
    [_cardView5 setVideo:video5];
    [_cardView6 setVideo:video6];
    
}

@end
