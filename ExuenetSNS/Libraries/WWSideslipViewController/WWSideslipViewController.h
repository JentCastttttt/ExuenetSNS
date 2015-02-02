//
//  WWSideslipViewController.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  版权属于原作者

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, WWMenuStatus) {
    WWMenuStatusCenterOpen,
    WWMenuStatusLeftOpen,
    WWMenuStatusRightOpen
};

@interface WWSideslipViewController : UIViewController <UIGestureRecognizerDelegate>{
@private
    UIViewController *leftControl;
    UIViewController *mainControl;
    UIViewController *righControl;
    
    UIImageView * imgBackground;
    
    CGFloat scalef;
    
    WWMenuStatus status;   //0:显示中间主页 1:左主页 2:右主页
}

//滑动速度系数-建议在0.5-1之间。默认为0.5
@property (assign,nonatomic) CGFloat speedf;

//是否允许点击视图恢复视图位置。默认为yes
@property (strong) UITapGestureRecognizer *sideslipTapGes;

//初始化
-(instancetype)initWithLeftView:(UIViewController *)LeftView
                    andMainView:(UIViewController *)MainView
                   andRightView:(UIViewController *)RighView
                    andBackgroundImage:(UIImage *)image;

//恢复位置
-(void)showMainView;

//显示左视图
-(void)showLeftView;

//显示右视图
-(void)showRighView;



@end
