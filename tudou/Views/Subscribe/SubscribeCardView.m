//
//  SubscribeCardView.m
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "SubscribeCardView.h"
#import "UIImageView+WebCache.h"

@implementation SubscribeCardView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, frame.size.width-5, frame.size.height-30)];
        [self addSubview:self.imageView];
        
        //
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, frame.size.height-30, frame.size.width-5, 30)];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        [self addSubview:self.titleLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImageCard:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

-(void)setSubItem:(SubItemModel *)subItem{
    _subItem = subItem;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:subItem.picurl] placeholderImage:[UIImage imageNamed:@"rec_holder"]];
    self.titleLabel.text = subItem.title;
}

-(void)OnTapImageCard:(UITapGestureRecognizer *)sender{
    NSLog(@"SubCard====select");
    [self.delegate didSelectSubImageCard:self subItem:self.subItem];
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
