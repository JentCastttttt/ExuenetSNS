//
//  ForgorPasswordView.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "ForgorPasswordView.h"

@implementation ForgorPasswordView
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
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [bgView setImage:[UIImage imageNamed:@"index_bg"]];
    [self addSubview:bgView];
    [bgView release];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.delegate backToLogin:nil];
}

- (void)forgetPassword:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(forgetPassword:)]) {
        [self.delegate forgetPassword:sender];
    }
}

- (void)backToLogin:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(backToLogin:)]) {
        [self.delegate backToLogin:sender];
    }
}

@end
