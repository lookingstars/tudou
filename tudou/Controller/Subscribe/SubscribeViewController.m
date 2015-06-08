//
//  SubscribeViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "SubscribeViewController.h"
#import "NetworkSingleton.h"
#import "MJExtension.h"
#import "SubscribeModel.h"
#import "SubscribeCell.h"
#import "MJRefresh.h"

#import "VideoDetailViewController.h"

@interface SubscribeViewController ()<UITableViewDataSource,UITableViewDelegate,SubscribeCellDelegate>
{
    NSMutableArray *_dataSource;
}

@end

@implementation SubscribeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataSource = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setNav];
    [self initTableview];
    dispatch_async(dispatch_get_main_queue(), ^{
//        [self getData];
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
    //
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(screen_width/2-60, 30, 120, 30)];
//    titleLabel.font = [UIFont systemFontOfSize:14];
    titleLabel.text = @"订阅推荐";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    [backView addSubview:titleLabel];
}

-(void)initTableview{
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
    [self getData];
}
#pragma mark 刷新tableview
-(void)reloadTable{
    //    [self.tableView reloadData];
    [self.tableView.header endRefreshing];
//    [self.tableView.footer endRefreshing];
}

-(void)getData{
    [_dataSource removeAllObjects];
    NSString *urlStr = @"http://user.api.3g.tudou.com/v4_3/user/sub/update?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pg=1&pid=c0637223f8b69b02&pz=20&ty=0&u_item_size=3&update_time=0&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1";
    [[NetworkSingleton sharedManager] getClassifyResule:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"订阅 成功");
        NSMutableArray *array = [responseBody objectForKey:@"results"];
        for (int i = 0; i < array.count; i++) {
            SubscribeModel *subM = [SubscribeModel objectWithKeyValues:array[i]];
            [_dataSource addObject:subM];
            
            [self.tableView reloadData];
            [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
        }
    } failureBlock:^(NSString *error){
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
        NSLog(@"%@",error);
    }];
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 215;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"subscribeCell";
    SubscribeCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[SubscribeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    
    SubscribeModel *subM = [_dataSource objectAtIndex:indexPath.row];
    
    cell.delegate = self;
    [cell setSubscribeM:subM];
    
    
    return cell;
}


#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didselect");
}

#pragma mark - SubscribeCellDelegate
-(void)didSelectSubscribeCell:(SubscribeCell *)subCell subItem:(SubItemModel *)subItem{
    NSLog(@"delegate  didselect");
    VideoDetailViewController *videoVC = [[VideoDetailViewController alloc] init];
    videoVC.iid = subItem.code;
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
