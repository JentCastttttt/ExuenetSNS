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
    
    regisiterView = [[RegisiterView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    regisiterView.delegate = self;
    [self.view addSubview:regisiterView];
    [regisiterView release];
    
    forgetView = [[ForgorPasswordView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight)];
    forgetView.delegate = self;
    [self.view addSubview:forgetView];
    [forgetView release];
    
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
    [UIView animateWithDuration:0.5 animations:^{
        loginView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
        forgetView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)regisiterNewUser:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        loginView.frame = CGRectMake(-kScreenWidth, 0, kScreenWidth, kScreenHeight);
        regisiterView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
    
}

- (void)regisiterUser:(id)sender
{
    
}

- (void)backToLoginView:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        loginView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        regisiterView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {

    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)forgetPassword:(id)sender
{
    
}

- (void)backToLogin:(id)sender
{
    [UIView animateWithDuration:0.5 animations:^{
        loginView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        forgetView.frame = CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight);
    } completion:^(BOOL finished) {
        
    }];
}

@end
