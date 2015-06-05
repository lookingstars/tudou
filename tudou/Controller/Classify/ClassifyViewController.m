//
//  ClassifyViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "ClassifyViewController.h"
#import "NetworkSingleton.h"

@interface ClassifyViewController ()

@end

@implementation ClassifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setNav];
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

-(void)OnUploadBtn:(UIButton *)sender{
    [self getData];
}

-(void)getData{
    NSString *urlStr = @"http://api.3g.tudou.com/v4_5/recommended_channels?excludeNew=0&guid=7066707c5bdc38af1621eaf94a6fe779&idfa=ACAF9226-F987-417B-A708-C95D482A732D&network=WIFI&operator=%E4%B8%AD%E5%9B%BD%E8%81%94%E9%80%9A_46001&ouid=10099212c9e3829656d4ea61e3858d53253b2f07&pg=1&pid=c0637223f8b69b02&pz=30&vdid=9AFEE982-6F94-4F57-9B33-69523E044CF4&ver=4.9.1";
    [[NetworkSingleton sharedManager] getClassifyResule:nil url:urlStr successBlock:^(id responseBody){
        NSLog(@"分类:%@",responseBody);
        NSMutableArray *array = [responseBody objectForKey:@"results"];
    } failureBlock:^(NSString *error){
        NSLog(@"%@",error);
    }];
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
