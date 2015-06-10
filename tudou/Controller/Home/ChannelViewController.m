//
//  ChannelViewController.m
//  tudou
//  频道详情
//  Created by jinzelu on 15/6/9.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ChannelViewController.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
#import "ChannelModel.h"
#import "UIImageView+WebCache.h"
#import "ChannelItem.h"
#import "ChannelItemCell.h"

#import "VideoDetailViewController.h"


@interface ChannelViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UIButton *_backBtn;
    UITableView *_tableView;
    
    ChannelModel *_channelModel;
    NSMutableArray *_channelItems;
    NSMutableArray *_segmentBtnArray;
}
@end

@implementation ChannelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    //初始化变量
    _channelModel = [[ChannelModel alloc] init];
    _segmentBtnArray = [[NSMutableArray alloc] init];
    _channelItems = [[NSMutableArray alloc] init];
    
    
    [self setNav];
    [self initNewTableView];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getChannelData];
        [self getNewestVideoData];
//        [self getHotestVideoData];
//        [self getPlaylistData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav{    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(15, 20, 30, 30);
    [_backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
}

-(void)initHeadViews{
    UIImageView *backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 130)];
    [backImageView sd_setImageWithURL:[NSURL URLWithString:_channelModel.home_pic] placeholderImage:[UIImage imageNamed:@"rec_holder"]];
    backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backImageView];
    //
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 85, 40, 40)];
    userImage.layer.masksToBounds = YES;
    userImage.layer.cornerRadius = 20;
    [userImage sd_setImageWithURL:[NSURL URLWithString:_channelModel.pic] placeholderImage:[UIImage imageNamed:@"tudoulogo"]];
    [self.view addSubview:userImage];
    //
    UILabel *nickNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 85, 150, 20)];
    nickNameLabel.font = [UIFont systemFontOfSize:13];
    nickNameLabel.textColor = [UIColor whiteColor];
    nickNameLabel.text = _channelModel.nick;
    [self.view addSubview:nickNameLabel];
    //
    UILabel *countLabel = [[UILabel alloc] initWithFrame:CGRectMake(55, 105, 180, 20)];
    countLabel.font = [UIFont systemFontOfSize:12];
    countLabel.textColor = [UIColor whiteColor];
    countLabel.text = [NSString stringWithFormat:@"播放: %@ | 订阅: %@",_channelModel.view_count,_channelModel.subed_count];
    [self.view addSubview:countLabel];
    //标题
    NSArray *titleArr = @[@"视频简介",@"视频",@"栏目",@"分享"];
    for(int i = 0; i < 4; i++){
        UIButton *segmengBtn = [[UIButton alloc] initWithFrame:CGRectMake(screen_width/4*i, 130, screen_width/4, 40)];
        segmengBtn.tag = 20+i;
        [segmengBtn setTitle:titleArr[i] forState:UIControlStateNormal];
        [segmengBtn setBackgroundColor:RGB(248, 248, 248)];
        [segmengBtn setTitleColor:navigationBarColor forState:UIControlStateSelected];
        [segmengBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [segmengBtn addTarget:self action:@selector(OnSegmentBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:segmengBtn];
        [_segmentBtnArray addObject:segmengBtn];
        if (i == 0) {
            segmengBtn.selected = YES;
        }
    }
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 169.5, screen_width, 0.5)];
    lineView.backgroundColor = separaterColor;
    [self.view addSubview:lineView];
    
}

-(void)initNewTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 170, screen_width, screen_height-170)];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

-(void)OnBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)OnSegmentBtn:(UIButton *)sender{
    NSLog(@"tag:%ld",(long)sender.tag);
    for (int i = 0; i < _segmentBtnArray.count; i++) {
        ((UIButton *)_segmentBtnArray[i]).selected = NO;
    }
    sender.selected = YES;
}

-(void)getChannelData{
//    http://user.api.3g.tudou.com/v4/channel/info?guid=7066707c5bdc38af1621eaf94a6fe779&id=344646570&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1_&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pid=c0637223f8b69b02&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
    NSString *urlStr = [NSString stringWithFormat:@"http://user.api.3g.tudou.com/v4/channel/info?guid=7066707c5bdc38af1621eaf94a6fe779&id=%@&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%@&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pid=c0637223f8b69b02&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1",_userId,OPERATOR];
    [[NetworkSingleton sharedManager] getChannelResule:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"频道查询成功");
        _channelModel = [ChannelModel objectWithKeyValues:responseBody];
        
        [self initHeadViews];
        [self.view bringSubviewToFront:_backBtn];
    } failureBlock:^(NSString *error){
        NSLog(@"频道查询失败：%@",error);
    }];
}

-(void)getNewestVideoData{
//    http://user.api.3g.tudou.com/v4/user/ugc_list?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1_&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&page_no=1&page_size=30&pid=c0637223f8b69b02&sort_desc_by=pub&user_ids=344646570&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
    NSString *urlStr = [NSString stringWithFormat:@"http://user.api.3g.tudou.com/v4/user/ugc_list?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%@&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&page_no=1&page_size=30&pid=c0637223f8b69b02&sort_desc_by=pub&user_ids=%@&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1",OPERATOR,_userId];
    [[NetworkSingleton sharedManager] getChannelResule:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"最新查询成功");
        NSMutableArray *items = [responseBody objectForKey:@"items"];
        for (int i = 0; i < items.count; i++) {
            ChannelItem *item = [ChannelItem objectWithKeyValues:items[i]];
            NSString *str = [self convertTime:([item.totalTime integerValue]/1000)];
            item.timeStr = str;
            [_channelItems addObject:item];
        }
        [_tableView reloadData];
        
    } failureBlock:^(NSString *error){
        NSLog(@"最新查询失败：%@",error);
    }];
}

-(void)getHotestVideoData{
//    http://user.api.3g.tudou.com/v4/user/ugc_list?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1_&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&page_no=1&page_size=30&pid=c0637223f8b69b02&sort_desc_by=7Quality&user_ids=344646570&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
    NSString *urlStr = [NSString stringWithFormat:@"http://user.api.3g.tudou.com/v4/user/ugc_list?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%@&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&page_no=1&page_size=30&pid=c0637223f8b69b02&sort_desc_by=7Quality&user_ids=%@&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1",OPERATOR,_userId];
    [[NetworkSingleton sharedManager] getChannelResule:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"最热查询成功");
    } failureBlock:^(NSString *error){
        NSLog(@"最热查询失败：%@",error);
    }];
}

-(void)getPlaylistData{
//    http://user.api.3g.tudou.com/v4_4/user/playlists?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E7%94%B5%E4%BF%A1_&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&page_no=1&page_size=30&pid=c0637223f8b69b02&user_id=344646570&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
    NSString *urlStr = [NSString stringWithFormat:@"http://user.api.3g.tudou.com/v4_4/user/playlists?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%@&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&page_no=1&page_size=30&pid=c0637223f8b69b02&user_id=%@&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1",OPERATOR,_userId];
    [[NetworkSingleton sharedManager] getChannelResule:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"栏目查询成功");
    } failureBlock:^(NSString *error){
        NSLog(@"栏目查询失败：%@",error);
    }];
}

-(NSString *)convertTime:(NSInteger)time{
    Float64 currentSeconds = time;
    int mins = currentSeconds/60.0;
    int hours = mins / 60.0f;
    int secs = fmodf(currentSeconds, 60.0);
    mins = fmodf(mins, 60.0f);
    
    NSString *hoursString = hours < 10 ? [NSString stringWithFormat:@"0%d", hours] : [NSString stringWithFormat:@"%d", hours];
    NSString *minsString = mins < 10 ? [NSString stringWithFormat:@"0%d", mins] : [NSString stringWithFormat:@"%d", mins];
    NSString *secsString = secs < 10 ? [NSString stringWithFormat:@"0%d", secs] : [NSString stringWithFormat:@"%d", secs];
    
    if (hours == 0) {
        return [NSString stringWithFormat:@"%@:%@",minsString, secsString];
    }else{
        return [NSString stringWithFormat:@"%@:%@:%@", hoursString,minsString, secsString];
    }
}


#pragma mark - UITableViewDataSource
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _channelItems.count;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"channelCell";
    ChannelItemCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[ChannelItemCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    ChannelItem *item = (ChannelItem *)_channelItems[indexPath.row];
    [cell setChannelItemM:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ChannelItem *item = (ChannelItem *)_channelItems[indexPath.row];
    VideoDetailViewController *videoVC = [[VideoDetailViewController alloc] init];
    videoVC.iid = item.icode;
    [self.navigationController pushViewController:videoVC animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
