//
//  ForgorPasswordView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ForgorPasswordViewDelegate <NSObject>

- (void)forgetPassword:(id)sender;

- (void)backToLogin:(id)sender;

@end

@interface ForgorPasswordView : UIView
{
    id<ForgorPasswordViewDelegate> delegate;
}
@property (nonatomic, assign) id<ForgorPasswordViewDelegate> delegate;
@end
