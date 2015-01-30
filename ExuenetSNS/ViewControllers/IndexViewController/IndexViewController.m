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

- (void)viewDidAppear:(BOOL)animated
{
//    [super viewDidAppear:animated];
    NSLog(@"%.2f",self.view.frame.size.height);
}

- (void)viewWillAppear:(BOOL)animated
{
//    [super viewWillAppear:animated];
    NSLog(@"%.2f",self.view.frame.size.height);
}

- (void)loadView
{
    [super loadView];
    NSLog(@"load");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%.2f",self.view.frame.size.height);
    
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    NSLog(@"1233");
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@"123");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    LeftIndexViewController *index = [[LeftIndexViewController alloc] init];
    index.title = @"next";
    [self.navigationController pushViewController:index animated:YES];
    [index release];
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
