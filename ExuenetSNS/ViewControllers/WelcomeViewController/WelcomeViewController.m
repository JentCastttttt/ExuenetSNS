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
#import "DiscGroupViewController.h"
#import "FriendsCircleViewController.h"
#import "ApplyCenterViewController.h"
#import "MyCenterViewController.h"
#import "LeftIndexViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self performSelector:@selector(showMainController:) withObject:nil afterDelay:1.0];
    [self.navigationController.navigationBar setHidden:YES];
    
    UIImageView *defaultImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    defaultImage.contentMode = UIViewContentModeScaleAspectFill;
    [defaultImage setImage:[UIImage imageNamed:@"Default"]];
    [self.view addSubview:defaultImage];
    [defaultImage release];
}

- (void)showMainController:(id)sender
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor colorFromString:@"ffffff"],NSForegroundColorAttributeName,nil];
    
    //主页
    IndexViewController *rootView = [[IndexViewController alloc] init];
    rootView.title = @"首页";
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:rootView];
    navi.navigationBar.titleTextAttributes = dict;
//    [navi.navigationBar setBackgroundImage:[UIImage imageNamed:@"3.png"] forBarMetrics:UIBarMetricsDefault];
    navi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    navi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    navi.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
    navi.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    navi.navigationBar.translucent = NO;
    [rootView release];
    
    DiscGroupViewController *discRoot = [[DiscGroupViewController alloc] init];
    discRoot.title = @"讨论组";
    UINavigationController *discNavi = [[UINavigationController alloc] initWithRootViewController:discRoot];
    discNavi.navigationBar.titleTextAttributes = dict;
    discNavi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    discNavi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    discNavi.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
    discNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    discNavi.navigationBar.translucent = NO;
    [discRoot release];

    FriendsCircleViewController *friRoot = [[FriendsCircleViewController alloc] init];
    friRoot.title = @"朋友圈";
    UINavigationController *friNavi = [[UINavigationController alloc] initWithRootViewController:friRoot];
    friNavi.navigationBar.titleTextAttributes = dict;
    friNavi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    friNavi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    friNavi.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
    friNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    friNavi.navigationBar.translucent = NO;
    [friRoot release];
    
    ApplyCenterViewController *appRoot = [[ApplyCenterViewController alloc] init];
    appRoot.title = @"应用中心";
    UINavigationController *appNavi = [[UINavigationController alloc] initWithRootViewController:appRoot];
    appNavi.navigationBar.titleTextAttributes = dict;
    appNavi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    appNavi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    appNavi.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
    appNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    appNavi.navigationBar.translucent = NO;
    [appRoot release];
    
    MyCenterViewController *myRoot = [[MyCenterViewController alloc] init];
    myRoot.title = @"我";
    UINavigationController *myNavi = [[UINavigationController alloc] initWithRootViewController:myRoot];
    myNavi.navigationBar.titleTextAttributes = dict;
    myNavi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    myNavi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    myNavi.tabBarItem.image = [UIImage imageNamed:@"icon_set_nomal"];
    myNavi.tabBarItem.selectedImage = [UIImage imageNamed:@"icon_set_click"];
    myNavi.navigationBar.translucent = NO;
    [myRoot release];
    
    NSArray *controlleItems = [NSArray arrayWithObjects:navi,discNavi,friNavi,appNavi,myNavi,nil];
    [navi release]; [discNavi release]; [friNavi release]; [appNavi release]; [myNavi release];
    
    UITabBarController *tab = [[UITabBarController alloc] init];
//    tab.tabBar.backgroundImage = [UIImage imageNamed:@"3.png"];//[UIColor colorWithRed:0.93 green:0.51 blue:0.39 alpha:1];
    tab.viewControllers = controlleItems;
    [tab.tabBar setTintColor:[UIColor colorWithRed:0.99 green:0.75 blue:0.38 alpha:1]];
    
    //左主页
    LeftIndexViewController *left = [[LeftIndexViewController alloc]init];
    
    WWSideslipViewController *slide = [[WWSideslipViewController alloc]initWithLeftView:left andMainView:tab andRightView:nil andBackgroundImage:[UIImage imageNamed:@"index_bg"]];
    //滑动速度系数
    [slide setSpeedf:0.5];
    //点击视图是是否恢复位置
    slide.sideslipTapGes.enabled = YES;
    
    [self.navigationController pushViewController:slide animated:NO];
    
    [tab release];
    
    [left release];
    
    [slide release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
