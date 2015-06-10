//
//  VideoInfoCell.m
//  tudou
//
//  Created by jinzelu on 15/6/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "VideoInfoCell.h"
#import "UIImageView+WebCache.h"

@interface VideoInfoCell ()
{
    UIImageView *_picImage;
    UILabel *_userNameLabel;
    UILabel *_playItemsLabel;
    UILabel *_userDesLabel;
    UIButton *_dingyueBtn;
    UILabel *_subedNumLabel;
    
    UILabel *_titleLabel;
    UILabel *_descLabel;
}

@end

@implementation VideoInfoCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
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
    NSLog(@"cell width:%f",self.frame.size.width);
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 70)];
    [self addSubview:backView];
    //添加点击事件
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBackView:)];
    [backView addGestureRecognizer:tap];
    //
    _picImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 40, 40)];
    _picImage.layer.masksToBounds = YES;
    _picImage.layer.cornerRadius = 20;
    [backView addSubview:_picImage];
    //
    _userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+10, 5, 150, 20)];
    _userNameLabel.font = [UIFont systemFontOfSize:14];
    _userNameLabel.textColor = [UIColor blackColor];
    [backView addSubview:_userNameLabel];
    //
    _playItemsLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+10, 20+5, 150, 20)];
    _playItemsLabel.font = [UIFont systemFontOfSize:13];
    _playItemsLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:_playItemsLabel];
    //
    _userDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(50+10, 40+5, 150, 20)];
    _userDesLabel.font = [UIFont systemFontOfSize:13];
    _userDesLabel.textColor = [UIColor lightGrayColor];
    _userDesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [backView addSubview:_userDesLabel];
    //
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 70, screen_width, 0.5)];
    lineView.backgroundColor = RGB(200, 199, 204);
    [backView addSubview:lineView];
    //
    _dingyueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dingyueBtn.frame = CGRectMake(screen_width-10-70, 30, 70, 29);
    [_dingyueBtn setImage:[UIImage imageNamed:@"search_channel_subscribe_noPlay"] forState:UIControlStateNormal];
    [_dingyueBtn setImage:[UIImage imageNamed:@"search_channel_subscribed"] forState:UIControlStateSelected];
    [backView addSubview:_dingyueBtn];
    
    _subedNumLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width-10-70, 5, 70, 20)];
    _subedNumLabel.font = [UIFont systemFontOfSize:11];
    _subedNumLabel.backgroundColor = RGB(241, 241, 241);
    _subedNumLabel.textAlignment = NSTextAlignmentCenter;
    _subedNumLabel.textColor = [UIColor lightGrayColor];
    [backView addSubview:_subedNumLabel];
    
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 70+5, screen_width-30, 30)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    //
    _descLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, screen_width-30, 60)];
    _descLabel.font = [UIFont systemFontOfSize:13];
    _descLabel.textColor = [UIColor lightGrayColor];
    _descLabel.numberOfLines = 0;
    [self addSubview:_descLabel];
}

-(void)setVideoModel:(VideoDetailModel *)videoModel{
    _videoModel = videoModel;
    [_picImage sd_setImageWithURL:[NSURL URLWithString:videoModel.channel_pic] placeholderImage:[UIImage imageNamed:@"tudoulogo"]];
    _userNameLabel.text = videoModel.username;
    _playItemsLabel.text = [NSString stringWithFormat:@"播放：%@",videoModel.user_play_times];
    _userDesLabel.text = videoModel.user_desc;
    
    _subedNumLabel.text = [NSString stringWithFormat:@"%d人订阅",[videoModel.subed_num intValue]];
    CGSize contentSize = [videoModel.desc sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(screen_width-30, 60) lineBreakMode:NSLineBreakByTruncatingTail];
    _titleLabel.text = videoModel.title;
    _descLabel.text = videoModel.desc;
}

-(void)OnTapBackView:(UITapGestureRecognizer *)sender{
    NSLog(@"userId:%@",[_videoModel.userid stringValue]);
    [self.delegate didSelectOnInfoView:[_videoModel.userid stringValue]];
}

@end
