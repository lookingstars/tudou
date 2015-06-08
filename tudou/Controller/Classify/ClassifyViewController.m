//
//  ClassifyViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ClassifyViewController.h"
#import "NetworkSingleton.h"
#import "ClassifyModel.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"

@interface ClassifyViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_dataSource;
}

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    _dataSource = [[NSMutableArray alloc] init];

    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setNav];

    dispatch_async(dispatch_get_main_queue(), ^{
        [self getData];
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
    [backView addSubview:historyBtn];
    //
    UIButton *uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    uploadBtn.frame = CGRectMake(screen_width-90, 30, 22, 22);
    [uploadBtn setImage:[UIImage imageNamed:@"home_upload"] forState:UIControlStateNormal];
    [uploadBtn addTarget:self action:@selector(OnUploadBtn:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:uploadBtn];
}

-(void)initTableview{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, screen_width, screen_height-64-49) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"namei.jpg"]];
    [self.view addSubview:self.tableView];
}

-(void)OnUploadBtn:(UIButton *)sender{
    [self getData];
}

-(void)getData{
    [_dataSource removeAllObjects];
    NSString *urlStr = @"http://api.3g.tudou.com/v4_5/recommended_channels?excludeNew=0&guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pg=1&pid=c0637223f8b69b02&pz=30&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1";
    [[NetworkSingleton sharedManager] getClassifyResule:nil url:urlStr successBlock:^(id responseBody){
        [self initTableview];
        NSLog(@"分类 成功");
        NSMutableArray *array = [responseBody objectForKey:@"results"];
        for (int i = 0; i < array.count; i++) {
            ClassifyModel *classM = [ClassifyModel objectWithKeyValues:array[i]];
            [_dataSource addObject:classM];
            [self.tableView reloadData];
        }
    } failureBlock:^(NSString *error){
        NSLog(@"分类  %@",error);
    }];
}


#pragma mark - UITableViewDataSource
//
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}
//
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}
//
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIndentifier = @"classifyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
        
        UIImageView *newImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 20, 20)];
        newImage.contentMode = UIViewContentModeScaleAspectFit;
        newImage.tag = 100;
        [cell.contentView addSubview:newImage];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(46, 0, 100, 40)];
        titleLabel.tag = 101;
        [cell.contentView addSubview:titleLabel];
        
    }
    ClassifyModel *classM = [_dataSource objectAtIndex:indexPath.row];
    
    UIImageView *newImage = (UIImageView *)[cell.contentView viewWithTag:100];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    titleLabel.text = classM.name;
    [newImage sd_setImageWithURL:[NSURL URLWithString:classM.image_at_bottom] placeholderImage:[UIImage imageNamed:@"home_GaoXiao"]];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:classM.image_at_bottom] placeholderImage:[UIImage imageNamed:@"home_GaoXiao"]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = [UIColor clearColor];
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
