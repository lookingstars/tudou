//
//  VideoDetailViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/4.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "VideoDetailViewController.h"
#import "JZVideoPlayerView.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
#import "VideoDetailModel.h"
#import "VideoInfoCell.h"


#define VIDEO_URL @"http://www.tudou.com/programs/view/html5embed.action?code="

@interface VideoDetailViewController ()<JZPlayerViewDelegate,UITableViewDataSource,UITableViewDelegate>
{
    JZVideoPlayerView *_jzPlayer;
    VideoDetailModel *_videoDM;
    UIWebView *_webView;
    UIButton *_backBtn;
    
    UITableView *_infoTableView;
}

@end

@implementation VideoDetailViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _videoDM = [[VideoDetailModel alloc] init];
    
    NSLog(@"宽度：%f",self.view.frame.size.width);
    
    [self initWebView];
    [self setNav];
    [self getVideoDetailData];
    
    [self initInfoTableView];

    dispatch_async(dispatch_get_main_queue(), ^{
//        [self initJZPlayer];
//        [self initWebView];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 20)];
    backView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:backView];
    
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(15, 20, 30, 30);
    [_backBtn addTarget:self action:@selector(OnBackBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [self.view addSubview:_backBtn];
}

-(void)initWebView{
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 220)];
    [self.view addSubview:_webView];
    
//    [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://www.tudou.com/programs/view/html5embed.action?code=j787D24B6kU"]]];
}

-(void)initInfoTableView{
    _infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, screen_width, screen_height-220) style:UITableViewStylePlain];
    _infoTableView.delegate = self;
    _infoTableView.dataSource = self;
    _infoTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    _infoTableView.backgroundColor = [UIColor redColor];
//    _infoTableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"namei.jpg"]];
    
    [self.view addSubview:_infoTableView];
}

//视频链接不对
-(void)initJZPlayer{
    //http://www.tudou.com/programs/view/html5embed.action?code=j787D24B6kU
    NSURL *url = [NSURL URLWithString:@"http://www.tudou.com/programs/view/html5embed.action?code=j787D24B6kU"];
    _jzPlayer = [[JZVideoPlayerView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 300) contentURL:url];
    _jzPlayer.delegate = self;
    [self.view addSubview:_jzPlayer];
    [_jzPlayer play];
}

-(void)getVideoDetailData{
//    http://api.3g.tudou.com/v4/play/detail?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&iid=j787D24B6kU&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pid=c0637223f8b69b02&show_playlist=1&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
//    NSString *urlStr = [NSString stringWithFormat:@"%@guid=%@&idfa=%@&iid=%@&network=%@&operator=%@&ouid=%@&pid=%@&show_playlist=%@&vdid=%@&ver=%@",PLAY_URL,GUID,IDFA,@"j787D24B6kU",NETWORK,OPERATOR,OUID,PID,@"1",VDID,VER];
    NSString *urlStr = [NSString stringWithFormat:@"%@guid=%@&idfa=%@&iid=%@&network=%@&operator=%@&ouid=%@&pid=%@&show_playlist=%@&vdid=%@&ver=%@",PLAY_URL,GUID,IDFA,self.iid,NETWORK,OPERATOR,OUID,PID,@"1",VDID,VER];
    NSLog(@"urlStr:%@",urlStr);
    
    [[NetworkSingleton sharedManager] getVideoDetailResule:nil url:urlStr successBlock:^(id responseBody){
//        NSLog(@"视频详情：%@",responseBody);
        VideoDetailModel *videoDM = [VideoDetailModel objectWithKeyValues:[responseBody objectForKey:@"detail"]];
        _videoDM = videoDM;
        NSString *urlStr = [NSString stringWithFormat:@"%@%@",VIDEO_URL,_videoDM.iid];
        [_webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlStr]]];
        [_infoTableView reloadData];
    } failureBlock:^(NSString *error){
        NSLog(@"%@",error);
    }];
}

-(void)OnBackBtn:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];
}



#pragma mark - JZPlayerViewDelegate
-(void)JZOnBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"videoCell1";
    VideoInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[VideoInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    [cell setVideoModel:_videoDM];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor clearColor];
//    cell.contentView.backgroundColor = [UIColor clearColor];
    
    return cell;
}

#pragma mark - UITableViewDelegate

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
