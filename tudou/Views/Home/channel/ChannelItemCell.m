//
//  ChannelItemCell.m
//  tudou
//
//  Created by jinzelu on 15/6/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ChannelItemCell.h"
#import "UIImageView+WebCache.h"

@interface ChannelItemCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_pvLabel;
    UILabel *_timeLabel;
}

@end

@implementation ChannelItemCell

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
    //图
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 50)];
    [self addSubview:_imageView];
    //标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+80+10, 5, screen_width-100-10, 40)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    //播放次数
    _pvLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+80+10, 40, 150, 20)];
    _pvLabel.font = [UIFont systemFontOfSize:13];
    _pvLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_pvLabel];
    //时间
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 40, 80, 15)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_timeLabel];
    //
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, screen_width, 0.5)];
    lineView.backgroundColor = separaterColor;
    [self addSubview:lineView];
}

-(void)setChannelItemM:(ChannelItem *)channelItemM{
    _channelItemM = channelItemM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:channelItemM.picUrl_200x112] placeholderImage:[UIImage imageNamed:@"rec_holder"]];
    _titleLabel.text = channelItemM.title;
    _pvLabel.text = [NSString stringWithFormat:@"播放:%@",channelItemM.playtimes];
    _timeLabel.text = channelItemM.timeStr;
}

@end
