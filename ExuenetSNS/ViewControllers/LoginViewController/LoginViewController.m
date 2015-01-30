//
//  LoginViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "LoginViewController.h"

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    loginView = [[LoginView alloc] initWithFrame:self.view.frame];
    loginView.delegate = self;
    [self.view addSubview:loginView];
    [loginView release];
}

- (void)loginInService:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)forgotPassword:(id)sender
{
    
}

- (void)regisiterNewUser:(id)sender
{
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
