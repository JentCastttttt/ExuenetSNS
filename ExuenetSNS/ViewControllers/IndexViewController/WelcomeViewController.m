//
//  WelcomeViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "WelcomeViewController.h"
#import "WWSideslipViewController.h"
#import "IndexViewController.h"
#import "LeftIndexViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(goIndex:) withObject:nil afterDelay:1.0];
    [self.navigationController.navigationBar setHidden:YES];
    
    UIImageView *defaultImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    [defaultImage setImage:[UIImage imageNamed:@"Default"]];
    [self.view addSubview:defaultImage];
    [defaultImage release];
}

- (void)goIndex:(id)sender
{
    //主页
    IndexViewController *rootView = [[IndexViewController alloc] init];
    rootView.title = @"首页";
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor colorFromString:@"ffffff"],NSForegroundColorAttributeName,nil];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rootView];
    navi.navigationBar.titleTextAttributes = dict;
    navi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    navi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    [rootView release];
    
    //左主页
    LeftIndexViewController *left = [[LeftIndexViewController alloc]init];
    
    WWSideslipViewController *slide = [[WWSideslipViewController alloc]initWithLeftView:left andMainView:navi andRightView:nil andBackgroundImage:[UIImage imageNamed:@"index_bg"]];
    //滑动速度系数
    [slide setSpeedf:0.5];
    //点击视图是是否恢复位置
    slide.sideslipTapGes.enabled = YES;
    
    [self.navigationController pushViewController:slide animated:NO];
    
    [left release];
    
    [slide release];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
