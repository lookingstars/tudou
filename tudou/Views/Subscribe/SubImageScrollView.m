//
//  SubImageScrollView.m
//  tudou
//
//  Created by jinzelu on 15/6/5.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "SubImageScrollView.h"
#import "SubscribeCardView.h"
#import "SubItemModel.h"

@interface SubImageScrollView()<SubscribeCardDelegate>
{
    
}

@end

@implementation SubImageScrollView


-(SubImageScrollView*)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.scrollView.contentSize = CGSizeMake(2*screen_width, frame.size.height);
        self.scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:self.scrollView];
        
        //card
        float cardWidth = (screen_width*2-5)/3;
        
        for (int i = 0; i < 3; i++) {
            SubscribeCardView *card = [[SubscribeCardView alloc] initWithFrame:CGRectMake(cardWidth*i, 0, cardWidth, frame.size.height)];
            card.tag = 20+i;
            [self.scrollView addSubview:card];
            card.delegate = self;
        }
    }
    return self;
}

-(void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    for (int i = 0; i < 3; i++) {
        SubItemModel *item = (SubItemModel *)dataArray[i];
        SubscribeCardView *card = (SubscribeCardView *)[self.scrollView viewWithTag:20+i];
        [card setSubItem:item];
    }
}

#pragma mark - SubscribeCardDelegate
-(void)didSelectSubImageCard:(SubscribeCardView *)subImageCard subItem:(SubItemModel *)subItem{
    NSLog(@"subScrollView=====select");
    [self.delegate didSelectSubScrollView:self subItem:subItem];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
