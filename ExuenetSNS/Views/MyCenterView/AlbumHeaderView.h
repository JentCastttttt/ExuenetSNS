//
//  AlbumHeaderView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  我的相册头部视图

#import <UIKit/UIKit.h>

@interface AlbumHeaderView : UIView
{
    UIImageView *iconView;  //用户头像
    UIImageView *albumView; //背景图片
    UILabel     *titleLabel;//用户姓名
}
@property (nonatomic, retain) UIImageView *iconView;  //用户头像
@property (nonatomic, retain) UIImageView *albumView; //背景图片
@property (nonatomic, retain) UILabel     *titleLabel;//用户姓名
@end
