//
//  LoginView.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "LoginView.h"

@implementation LoginView
@synthesize loginText;
@synthesize pwdText;
@synthesize iconView;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self createInitView];
    }
    return self;
}

- (void)createInitView
{
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.frame];
    [bgView setImage:[UIImage imageNamed:@"index_bg"]];
    [self addSubview:bgView];
    [bgView release];
    
    
    CGFloat cornerRadius = 80.0f;
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - cornerRadius)/2.0, 70, cornerRadius, cornerRadius)];
    icon.layer.cornerRadius = cornerRadius/2.0;
    icon.layer.borderColor = [UIColor whiteColor].CGColor;
    icon.layer.borderWidth = 2.0f;
    self.iconView = icon;
    [self addSubview:icon];
    [icon release];
    
    
    CGFloat boundsOffset = 30;
    UIView *nameView = [[UIView alloc] initWithFrame:CGRectMake(boundsOffset, icon.frame.origin.y + icon.frame.size.height + 15, kScreenWidth - boundsOffset*2, 40)];
    nameView.layer.cornerRadius = 3.0f;
    nameView.backgroundColor = [UIColor colorWithWhite:0.75 alpha:0.75];
    [self addSubview:nameView];
    [nameView release];
    
    UIImageView *nameIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7.5, 25, 25)];
    nameIcon.backgroundColor = [UIColor redColor];
    [nameView addSubview:nameIcon];
    [nameIcon release];
    
    UITextField *nameField = [[UITextField alloc] initWithFrame:CGRectMake(50, 7.5, nameView.frame.size.width - 70, 25)];
    nameField.placeholder = @"用户名";
    nameField.delegate = self;
    nameField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    nameField.font = [UIFont systemFontOfSize:13.0f];
    nameField.borderStyle = UITextBorderStyleNone;
    self.loginText = nameField;
    [nameView addSubview:nameField];
    [nameField release];
    
    
    UIView *pwdView = [[UIView alloc] initWithFrame:CGRectMake(boundsOffset, nameView.frame.origin.y + nameView.frame.size.height + 10, nameView.frame.size.width, nameView.frame.size.height)];
    pwdView.layer.cornerRadius = 3.0f;
    pwdView.backgroundColor = [UIColor colorWithWhite:0.75 alpha:0.75];
    [self addSubview:pwdView];
    [pwdView release];
    
    UIImageView *pwdIcon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 7.5, 25, 25)];
    pwdIcon.backgroundColor = [UIColor redColor];
    [pwdView addSubview:pwdIcon];
    [pwdIcon release];
    
    UITextField *pdField = [[UITextField alloc] initWithFrame:CGRectMake(50, 7.5, nameView.frame.size.width - 70, 25)];
    pdField.placeholder = @"密码";
    pdField.delegate = self;
    pdField.clearsOnBeginEditing = YES;
    pdField.secureTextEntry = YES;
    pdField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    pdField.font = [UIFont systemFontOfSize:13.0f];
    pdField.borderStyle = UITextBorderStyleNone;
    pdField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.pwdText = pdField;
    [pwdView addSubview:pdField];
    [pdField release];
    
    UIButton *loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    loginButton.frame = CGRectMake(boundsOffset, pwdView.frame.origin.y + pwdView.frame.size.height + 15, pwdView.frame.size.width, pwdView.frame.size.height);
    [loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [loginButton setBackgroundColor:[UIColor colorWithRed:0.98 green:0.67 blue:0.23 alpha:1]];
    [loginButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [loginButton addTarget:self action:@selector(loginInService:) forControlEvents:UIControlEventTouchUpInside];
    loginButton.layer.cornerRadius = 3.0f;
    [self addSubview:loginButton];
    
    UIButton *forgot = [UIButton buttonWithType:UIButtonTypeCustom];
    forgot.frame = CGRectMake(boundsOffset, loginButton.frame.origin.y + loginButton.frame.size.height, 55, pwdView.frame.size.height);
    [forgot setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgot setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [forgot setBackgroundColor:[UIColor clearColor]];
    [forgot.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [forgot addTarget:self action:@selector(forgotPassword:) forControlEvents:UIControlEventTouchUpInside];
    forgot.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:forgot];
    
    UIButton *regisiter = [UIButton buttonWithType:UIButtonTypeCustom];
    regisiter.frame = CGRectMake(boundsOffset, forgot.frame.origin.y + forgot.frame.size.height + 50, pwdView.frame.size.width, pwdView.frame.size.height);
    [regisiter setTitle:@"注册账号" forState:UIControlStateNormal];
    [regisiter setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [regisiter setBackgroundColor:[UIColor colorWithRed:0.98 green:0.67 blue:0.23 alpha:0.35]];
    [regisiter.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
    [regisiter addTarget:self action:@selector(regisiterNewUser:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:regisiter];
}

- (void)loginInService:(id)sender
{
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginInService:)]) {
        [self.delegate loginInService:sender];
    }
}

- (void)forgotPassword:(id)sender
{
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(forgotPassword:)]) {
        [self.delegate forgotPassword:sender];
    }
}

- (void)regisiterNewUser:(id)sender
{
    [self endEditing:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(regisiterNewUser:)]) {
        [self.delegate regisiterNewUser:sender];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([textField.text length] >= 15) {
        return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;  //donot display the menu
    return NO;
}

- (void)dealloc
{
    [loginText release];
    [pwdText release];
    [iconView release];
    [super dealloc];
}

@end
