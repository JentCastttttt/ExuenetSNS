//
//  IndexViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "IndexViewController.h"
#import "LeftIndexViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface IndexViewController ()

@end

@implementation IndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%.2f",self.view.frame.size.height);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.title = @"登录";
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:^{}];
    [login release];
}

@end
