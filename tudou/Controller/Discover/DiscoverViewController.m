//
//  DiscoverViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "DiscoverViewController.h"
#import "NetworkSingleton.h"
#import "DisResultModel.h"
#import "MJExtension.h"
#import "MJRefresh.h"

#import "ImageScrollCell.h"
#import "UIImageView+WebCache.h"
#import "VideoDetailViewController.h"

@interface DiscoverViewController ()<UITableViewDataSource,UITableViewDelegate,ImageScrollViewDelegate>
{
    NSMutableArray *_dataSource;
    NSMutableArray *_imageArray;
    
    UILabel *_searchLabel;
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    //
    _dataSource = [[NSMutableArray alloc] init];
    _imageArray = [[NSMutableArray alloc] init];
    
    //
    [self setNav];
    [self initTableViews];
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
    UIView *searchBgView = [[UIView alloc] initWithFrame:CGRectMake(10, 25, screen_width-10-10-30, 30)];
    searchBgView.backgroundColor = [UIColor whiteColor];
    searchBgView.layer.cornerRadius = 3;
    [self.view addSubview:searchBgView];
    //
    UIImageView *searchImg = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 17, 17)];
    searchImg.image = [UIImage imageNamed:@"ic_discover_search"];
    [searchBgView addSubview:searchImg];
    //
    _searchLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, searchBgView.frame.size.width-30, 30)];
    _searchLabel.textColor = [UIColor lightGrayColor];
    _searchLabel.text = @"大家都在搜:海贼王";
    _searchLabel.font = [UIFont systemFontOfSize:15];
    [searchBgView addSubview:_searchLabel];
    
    
    //二维码
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadBtn.frame = CGRectMake(screen_width-30, 30, 22, 22);
    [uploadBtn setImage:[UIImage imageNamed:@"ic_discover_QR-code"] forState:UIControlStateNormal];
//    [uploadBtn addTarget:self action:@selector(OnUploadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:uploadBtn];
}

-(void)initTableViews{
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
    
    //设置文字(也可不设置,默认的文字在MJRefreshConst中修改))
    [self.tableView.header setTitle:@"下拉刷新" forState:MJRefreshHeaderStateIdle];
    [self.tableView.header setTitle:@"松开刷新" forState:MJRefreshHeaderStatePulling];
    [self.tableView.header setTitle:@"刷新中" forState:MJRefreshHeaderStateRefreshing];
}

-(void)headerRefreshing{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self getDiscoverData];
    });
}
#pragma mark 刷新tableview
-(void)reloadTable{
    [self.tableView.header endRefreshing];
//    [self.tableView.footer endRefreshing];
}

-(void)getDiscoverData{
    NSString *urlStr = @"http://discover.api.3g.tudou.com/v4_7/rec_discover?guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pg=1&pid=c0637223f8b69b02&pz=30&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1";
    [[NetworkSingleton sharedManager] getDiscoverResult:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"发现查询成功");
        
        NSString *hotWord = [responseBody objectForKey:@"search_hot_word"];
        NSString *WordAd = [responseBody objectForKey:@"search_word_ad"];
        _searchLabel.text = [NSString stringWithFormat:@"%@:%@",WordAd,hotWord];
        
        [_dataSource removeAllObjects];
        NSMutableArray *resultArray = [responseBody objectForKey:@"results"];
        for (int i = 0; i < resultArray.count; i++) {
            DisResultModel *disM = [DisResultModel objectWithKeyValues:resultArray[i]];
            [_dataSource addObject:disM];
            if (i == 0) {
                [_imageArray removeAllObjects];
                NSMutableArray *imgArr = disM.items;
                for (int j = 0; j < imgArr.count; j++) {
                    NSString *picStr = [imgArr[j] objectForKey:@"image_640_210"];
                    [_imageArray addObject:picStr];
                }
            }
        }
        
        //
        [self.tableView reloadData];
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    } failureBlock:^(NSString *error){
        NSLog(@"发现查询失败：%@",error);
        [self performSelectorOnMainThread:@selector(reloadTable) withObject:nil waitUntilDone:YES];
    }];
}


#pragma mark - UITableViewDataSource
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 130;
    }else{
        return 40;
    }
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        static NSString *cellIndentifier = @"discoverCell0";
        ImageScrollCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[ImageScrollCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier frame:CGRectMake(0, 0, screen_width, 130)];
        }
        [cell setImageArray:_imageArray];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.imageScrollView.delegate = self;
        return cell;
    }else{
        static NSString *cellIndentifier = @"discoverCell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
            //
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, screen_width, 0.5)];
            lineView.backgroundColor = separaterColor;
            [cell.contentView addSubview:lineView];
        }
        DisResultModel *disM = (DisResultModel *)_dataSource[indexPath.row];
        cell.textLabel.text = disM.title;
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:disM.module_icon] placeholderImage:[UIImage imageNamed:@"home_GaoXiao"]];
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate

#pragma mark - ImageScrollViewDelegate
-(void)didSelectImageAtIndex:(NSInteger)index{
    NSLog(@"index:%ld",index);
    DisResultModel *disM = (DisResultModel *)_dataSource[0];
    NSString *code = [disM.items[index] objectForKey:@"video_id"];
    
    VideoDetailViewController *videoVC = [[VideoDetailViewController alloc] init];
    videoVC.iid = code;
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
