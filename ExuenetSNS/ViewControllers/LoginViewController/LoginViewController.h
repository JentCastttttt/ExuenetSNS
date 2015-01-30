//
//  LoginViewController.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "BaseViewController.h"
#import "LoginView.h"
#import "RegisiterView.h"
#import "ForgorPasswordView.h"

@interface LoginViewController : BaseViewController<LoginViewDelegate,RegisiterViewDelegate,ForgorPasswordViewDelegate>
{
    LoginView *loginView;
    RegisiterView *regisiterView;
    ForgorPasswordView *forgetView;
}

@end
