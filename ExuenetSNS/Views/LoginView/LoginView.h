//
//  LoginView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewDelegate <NSObject>

- (void)loginInService:(id)sender;

- (void)forgotPassword:(id)sender;

- (void)regisiterNewUser:(id)sender;

@end

@interface LoginView : UIView<UITextFieldDelegate>
{
    UITextField *loginText;
    UITextField *pwdText;
    UIImageView *iconView;
    id<LoginViewDelegate> delegate;
}
@property (nonatomic, retain) UITextField *loginText;
@property (nonatomic, retain) UITextField *pwdText;
@property (nonatomic, retain) UIImageView *iconView;
@property (nonatomic, assign) id<LoginViewDelegate> delegate;
@end
