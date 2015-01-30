//
//  RegisiterView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RegisiterViewDelegate <NSObject>

- (void)regisiterUser:(id)sender;

- (void)backToLoginView:(id)sender;

@end

@interface RegisiterView : UIView<UITextFieldDelegate>
{
    UITextField *loginText;
    UITextField *pwdText;
    id<RegisiterViewDelegate> delegate;
}
@property (nonatomic, retain) UITextField *loginText;
@property (nonatomic, retain) UITextField *pwdText;
@property (nonatomic, assign) id<RegisiterViewDelegate> delegate;
@end
