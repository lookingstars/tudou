//
//  SubscribeCell.m
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "SubscribeCell.h"
#import "SubImageScrollView.h"
#import "SubItemModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface SubscribeCell ()<SubImageScrollDelegate>
{
    NSMutableArray *_items;
    SubImageScrollView *_scrollV;
    UIImageView *_imageView;
    UILabel *_titleLabel;
    UILabel *_subedLabel;
    UIButton *_dingyueBtn;
}

@end

@implementation SubscribeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = navigationBarColor;
        _items = [[NSMutableArray alloc] init];
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
    UIView *backview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 210)];
    backview.backgroundColor = [UIColor whiteColor];
    [self addSubview:backview];
    
    //
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
    _imageView.layer.cornerRadius = 20;
    _imageView.layer.masksToBounds = YES;
    [backview addSubview:_imageView];
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 5, 120, 25)];
    _titleLabel.font = [UIFont systemFontOfSize:14];
    _titleLabel.textColor = [UIColor blackColor];
    [backview addSubview:_titleLabel];
    
    _subedLabel = [[UILabel alloc] initWithFrame:CGRectMake(65, 25, 120, 25)];
    _subedLabel.font = [UIFont systemFontOfSize: 12];
    _subedLabel.textColor = [UIColor lightGrayColor];
    [backview addSubview:_subedLabel];
    
    _dingyueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _dingyueBtn.frame = CGRectMake(screen_width-10-70, 10, 70, 29);
    [_dingyueBtn setImage:[UIImage imageNamed:@"search_channel_subscribe_noPlay"] forState:UIControlStateNormal];
    [_dingyueBtn setImage:[UIImage imageNamed:@"search_channel_subscribed"] forState:UIControlStateSelected];
    [backview addSubview:_dingyueBtn];
    
    //
    _scrollV = [[SubImageScrollView alloc] initWithFrame:CGRectMake(0, 55, screen_width, 155)];
    _scrollV.delegate = self;
    [backview addSubview:_scrollV];
    
}

-(void)setSubscribeM:(SubscribeModel *)subscribeM{
    _subscribeM = subscribeM;
    [_items removeAllObjects];
    for (int i = 0; i < subscribeM.last_item.count; i++) {
        SubItemModel *item = [SubItemModel objectWithKeyValues:subscribeM.last_item[i]];
        [_items addObject:item];
    }
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:subscribeM.image] placeholderImage:[UIImage imageNamed:@"rec_holder"]];
    _titleLabel.text = subscribeM.title;
    _subedLabel.text = [NSString stringWithFormat:@"订阅 %@", subscribeM.subed_count];
    [_scrollV setDataArray:_items];
}

#pragma mark - SubImageScrollDelegate
-(void)didSelectSubScrollView:(SubImageScrollView *)subScrollView subItem:(SubItemModel *)subItem{
    NSLog(@"");
    [self.delegate didSelectSubscribeCell:self subItem:subItem];
}


@end
