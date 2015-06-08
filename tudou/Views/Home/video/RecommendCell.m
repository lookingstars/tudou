//
//  RecommendCell.m
//  tudou
//
//  Created by jinzelu on 15/6/8.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "RecommendCell.h"
#import "UIImageView+WebCache.h"

@interface RecommendCell ()
{
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_pvLabel;
    UILabel *_timeLabel;
}

@end

@implementation RecommendCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //
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
    //
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 80, 50)];
    [self addSubview:_imageView];
    //
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+80+10, 5, screen_width-100-10, 40)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.numberOfLines = 2;
    _titleLabel.textColor = [UIColor blackColor];
    [self addSubview:_titleLabel];
    //
    _pvLabel = [[UILabel alloc] initWithFrame:CGRectMake(10+80+10, 40, 150, 20)];
    _pvLabel.font = [UIFont systemFontOfSize:13];
    _pvLabel.textColor = [UIColor lightGrayColor];
    [self addSubview:_pvLabel];
    //
    _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(13, 40, 80, 15)];
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textColor = [UIColor whiteColor];
    [self addSubview:_timeLabel];
    //
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, screen_width, 0.5)];
    lineView.backgroundColor = separaterColor;
    [self addSubview:lineView];
    
}

-(void)setRecommendM:(RecommendModel *)recommendM{
    _recommendM = recommendM;
    [_imageView sd_setImageWithURL:[NSURL URLWithString:recommendM.img] placeholderImage:[UIImage imageNamed:@"rec_holder"]];
    _titleLabel.text = recommendM.title;
    _pvLabel.text = recommendM.pv_pr;
    _timeLabel.text = recommendM.time;
}

@end
