//
//  MineViewController.m
//  tudou
//
//  Created by jinzelu on 15/6/3.
//  Copyright (c) 2015年 jinzelu. All rights reserved.
//

#import "MineViewController.h"
#import <sys/sysctl.h>
#import <mach/mach.h>

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setNav];
    [self initViews];
    
    [self availableMemory];
    [self usedMemory];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setNav{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 147)];
    [backImage setImage:[UIImage imageNamed:@"morentu"]];
    [self.view addSubview:backImage];
    //
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 107, screen_width, 40)];
    backView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"titlebar"]];
    [self.view addSubview:backView];
    //
    //设置
    UIButton *settingBtn = [[UIButton alloc] initWithFrame:CGRectMake(screen_width-30, 30, 22, 22)];
    [settingBtn setImage:[UIImage imageNamed:@"mine_setting_icon"] forState:UIControlStateNormal];
    [self.view addSubview:settingBtn];
    //消息
    UIButton *msgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    msgBtn.frame = CGRectMake(screen_width-60, 30, 22, 22);
    [msgBtn setImage:[UIImage imageNamed:@"ic_my_msg"] forState:UIControlStateNormal];
//    [msgBtn addTarget:self action:@selector(OnHisBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:msgBtn];
    //头像
    UIImageView *userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 30, 50, 50)];
    userImage.layer.masksToBounds = YES;
    userImage.layer.cornerRadius = 25;
    userImage.image = [UIImage imageNamed:@"default_head"];
    [self.view addSubview:userImage];
    
    //登陆
    UILabel *loginLable = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImage.frame)+10, 30, 100, 30)];
    loginLable.textColor = [UIColor whiteColor];
    loginLable.font = [UIFont systemFontOfSize:14];
    loginLable.text = @"马上登陆";
    [self.view addSubview:loginLable];
    //
    UILabel *msgLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(userImage.frame)+10, 60, 100, 20)];
    msgLabel.text = @"登陆后更精彩";
    msgLabel.textColor = [UIColor whiteColor];
    msgLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:msgLabel];
}

-(void)initViews{
    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 150, screen_width, screen_height-150-49)];
    [backImage setImage:[UIImage imageNamed:@"cache_no_data"]];
    backImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:backImage];
    //
    NSArray *titleArrar = @[@"历史",@"收藏",@"上传",@"特权"];
    NSArray *picArray = @[@"myview_lishi",@"myview_collect",@"myview_upload",@"myview_tequan"];
    for (int i = 0; i < 4; i++) {
        UIButton *segmentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        segmentBtn.frame = CGRectMake(screen_width/4*i, 107, screen_width/4, 40);
        [segmentBtn setImage:[UIImage imageNamed:picArray[i]] forState:UIControlStateNormal];
        [segmentBtn setTitle:titleArrar[i] forState:UIControlStateNormal];
        segmentBtn.tag = 30+i;
//        [segmentBtn setFont:[UIFont systemFontOfSize:14]];
        [self.view addSubview:segmentBtn];
    }
}

-(double)availableMemory{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS) {
        return NSNotFound;
    }
    double size = (((vm_page_size*vmStats.free_count)/1024.0)/1024.0);
    NSLog(@"大小：%f",size);
    return size;
}

- (double)usedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    double size = taskInfo.resident_size / 1024.0 / 1024.0;
    NSLog(@"已用：%f",size);
    
    return size;
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
