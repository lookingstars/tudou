//
//  HomeViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "HomeViewController.h"
#import "NetworkSingleton.h"
#import <CommonCrypto/CommonDigest.h> // Need to import for CC_MD5 access
#import "MJExtension.h"
#import "HomeModel.h"
#import "BoxesModel.h"
#import "VideosModel.h"
#import "BannerModel.h"
#import "VideoDetailViewController.h"

#import "ImageScrollCell.h"
#import "HomeBoxCell.h"
#import "HomeVideoBoxCell.h"
#import "MJRefresh.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate,ImageScrollViewDelegate,HomeBoxDelegate>
{
    NSMutableArray *_dataSource;
    NSMutableArray *_boxesSource;
    NSMutableArray *_bannerSource;
    NSMutableArray *_headImageArray;
}
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    _boxesSource = [[NSMutableArray alloc] init];
    _bannerSource = [[NSMutableArray alloc] init];
    _headImageArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    [self setNav];
    [self initTableView];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
//        [self getHomeData];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav{
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 64)];
    backView.backgroundColor = navigationBarColor;
    [self.view addSubview:backView];
    
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 20+10, 65, 24)];
    logoImage.image = [UIImage imageNamed:@"home_logo"];
    [backView addSubview:logoImage];
    //搜索
    UIButton *searchBtn = [[UIButton alloc] initWithFrame:CGRectMake(screen_width-30, 30, 22, 22)];
    [searchBtn setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
    [backView addSubview:searchBtn];
    //历史
    UIButton *historyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    historyBtn.frame = CGRectMake(screen_width-60, 30, 22, 22);
    [historyBtn setImage:[UIImage imageNamed:@"home_history"] forState:UIControlStateNormal];
    [historyBtn addTarget:self action:@selector(OnHisBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:historyBtn];
    //
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadBtn.frame = CGRectMake(screen_width-90, 30, 22, 22);
    [uploadBtn setImage:[UIImage imageNamed:@"home_upload"] forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(OnUploadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:uploadBtn];
    
    //
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-50, 30, 120, 30)];
    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"钻石会员尊享版";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:titleLabel];
}

-(void)initTableView{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self setupRefresh];
}

-(void)setupRefresh{
    //1.下拉刷新
    [self.tableView addLegendHeaderWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    //2.进入自动刷新
    [self.tableView.header beginRefreshing];
    //3.上拉刷新
    //    [self.tableView addFooterWithTarget:self action:@selector(footerRefreshing)];
    //    [self.tableView addLegendFooterWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    
    //设置文字(也可不设置,默认的文字在MJRefreshConst中修改))
    [self.tableView.header setTitle:@"下拉刷新" forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"松开刷新" forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"刷新中" forState:MJRefreshHeaderStateRefreshing];
    
    //    [self.tableView.footer setTitle:@"点击或上拉加载更多" forState:MJRefreshFooterStateIdle];
    //    [self.tableView.footer setTitle:@"加载中..." forState:MJRefreshFooterStateRefreshing];
    //    [self.tableView.footer setTitle:@"没有更多" forState:MJRefreshFooterStateNoMoreData];
}

-(void)headerRefreshing{
    [self getHomeData];
}
#pragma mark 刷新tableview
-(void)reloadTable{
    //    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
    //    [self.tableView.footer endRefreshing];
}

-(void)OnUploadBtn:(UIButton *)sender{
    NSString *str = [self md5:@"1"];
    NSLog(@"%@",str);
    [self getHomeData];
}

-(void)OnHisBtn:(UIButton *)sender{
    [self getHistoryData];
}


- (NSString *)md5:(NSString *)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
            ]; 
    
}

-(void)getHomeData{
    NSString *url = @"http://api.3g.tudou.com/v4/home?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&ios=1&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pg=1&pid=c0637223f8b69b02&pz=30&show_url=1&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1";
    NSLog(@"首页url:%@",url);
    [[NetworkSingleton sharedManager] getHomeResule:nil url:url successBlock:^(id responseBody){
        NSLog(@"首页 成功");
        [_headImageArray removeAllObjects];
        HomeModel *homeModel = [HomeModel objectWithKeyValues:responseBody];
        NSMutableArray *boxesArray = [[NSMutableArray alloc] init];
        NSMutableArray *bannerArray = [[NSMutableArray alloc] init];
        for (int i = 0; i < homeModel.boxes.count; i ++) {
            BoxesModel *boxesModel = [BoxesModel objectWithKeyValues:homeModel.boxes[i]];
            boxesModel.height = [self getHeight:boxesModel];
            [boxesArray addObject:boxesModel];
        }
        for (int j = 0; j < homeModel.banner.count; j++) {
            BannerModel *bannerModel =[BannerModel objectWithKeyValues:homeModel.banner[j]];
            [bannerArray addObject:bannerModel];
            [_headImageArray addObject:bannerModel.small_img];
        }
        
        _boxesSource = boxesArray;
        _bannerSource = bannerArray;
        [self.tableView reloadData];
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    } failureBlock:^(NSString *error){
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
        NSLog(@"%@",error);
    }];
}

-(void)getHistoryData{
    //http://user.api.3g.tudou.com/user/viewrecord/get?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&isAlbum=0&isPay=0&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pageNo=1&pageSize=30&pid=c0637223f8b69b02&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1
    NSString *urlStr = @"http://user.api.3g.tudou.com/user/viewrecord/get?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&isAlbum=0&isPay=0&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pageNo=1&pageSize=30&pid=c0637223f8b69b02&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1";
    [[NetworkSingleton sharedManager] getHistoryResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"查询历史记录成功");
    } failureBlock:^(NSString *error){
        NSLog(@"查询历史记录失败：%@",error);
    }];
}

-(float)getHeight:(BoxesModel *)boxes{
    float height = 0;
    height = height + 40;
    if ([boxes.display_type intValue] == 1) {
        //
//        height = height + boxes.videos.count/2*150;
        height = height + 2*150;
        
        return height+5;
    }else if([boxes.display_type intValue] == 2){
        //
//        height = height + boxes.videos.count/3*230;
        height = height + 2*230;
        return height+5;
    }else{
        return height+5;
    }
    return height;
}


#pragma mark - UITableViewDataSource
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"总行数：%ld",_boxesSource.count+_bannerSource.count);
    if(_bannerSource.count>0){
        return _boxesSource.count+1;
    }else{
        return 0;
    }
    
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 180;
    }else{
        CGFloat height = ((BoxesModel *)_boxesSource[indexPath.row-1]).height;
        return height;
    }
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIndentifier0 = @"imageScrollCell0";
        ImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier0];
        if (cell == nil) {
            cell = [[ImageScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier0];
        }
        if (_headImageArray.count>0) {
            [cell setImageArray:_headImageArray];
        }
        cell.imageScrollView.delegate = self;
        
        return cell;
    }else{
        BoxesModel *box = _boxesSource[indexPath.row-1];
        if ([box.display_type intValue] == 1) {
            static NSString *cellIndentifier1 = @"cardCell1";
            HomeBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier1];
            if (cell == nil) {
                cell = [[HomeBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier1];
            }
            cell.delegate = self;
            [cell setBoxes:_boxesSource[indexPath.row-1]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else if([box.display_type intValue] == 2){
            static NSString *cellIndentifier2 = @"cardCell2";
            HomeVideoBoxCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier2];
            if(cell == nil){
                cell = [[HomeVideoBoxCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier2];
            }
            [cell setBoxes:box];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }else{
            return nil;
        }
        
    }
}

#pragma mark - UITableViewDelegate




#pragma mark - ImageScrollViewDelegate
-(void)didSelectImageAtIndex:(NSInteger)index{
    NSLog(@"index:%ld",index);
}

#pragma mark - HomeBoxDelegate
-(void)didSelectHomeBox:(VideosModel *)video{
    NSLog(@"homebox video:%@",video);
    VideoDetailViewController *videoVC = [[VideoDetailViewController alloc] init];
    videoVC.iid = video.iid;
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
