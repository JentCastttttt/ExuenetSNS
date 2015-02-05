//
//  AlbumHeaderView.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  我的相册头部视图

#import <UIKit/UIKit.h>

typedef void(^avatarClickBlock)(UIImage *icon);

typedef void(^albumClickBlock)(void);

typedef void(^requestAlbumBlock)(void);

@interface AlbumHeaderView : UIView
{
    UIImageView *albumView; //背景图片
    UIImageView *avatarView;  //用户头像
    UILabel     *titleLabel;//用户姓名
    avatarClickBlock avatarBlock;
    albumClickBlock albumBlock;
    requestAlbumBlock reqBlock;
}
@property (nonatomic, retain) UIImageView *albumView;  //用户头像
@property (nonatomic, retain) UIImageView *avatarView; //背景图片
@property (nonatomic, retain) UILabel     *titleLabel;//用户姓名

//! 查看当前用户的头像
- (void)examineAlbumWithCompletion:(avatarClickBlock)completion;
//- (void)examineAlbumWithCompletion:(void (^)(UIImage *icon))completion;

//! 更改当前用户背景
- (void)changeAlbumWithCompletion:(albumClickBlock)completion;

//! 发送新的状态消息
- (void)requestAlbumPhotoWithCompletion:(albumClickBlock)completion;

@end
