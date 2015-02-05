//
//  AlbumHeaderView.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "AlbumHeaderView.h"

@implementation AlbumHeaderView
@synthesize avatarView;
@synthesize albumView;
@synthesize titleLabel;

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
    self.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kAlbumHeight)];
    [bgView setImage:[UIImage imageNamed:@"Default"]];
    [bgView whenTapped:^{
        albumClickBlock block = [albumBlock retain];
        if (block) {
            block();
        }
        [block release];
    }];
    self.albumView = bgView;
    [self addSubview:bgView];
    [bgView release];
    
    bgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 75.0, kAlbumHeight - 35.0, 70.0, 70.0f)];
    [bgView setImage:[UIImage imageNamed:@"Default"]];
    bgView.layer.cornerRadius = bgView.frame.size.height/2.0;
    bgView.layer.borderWidth = 4.0f;
    bgView.layer.borderColor = [UIColor colorWithRed:0.43 green:0.27 blue:0.6 alpha:1].CGColor;
    bgView.clipsToBounds = YES;
    self.avatarView = bgView;
    [bgView whenTapped:^{
        avatarClickBlock block = [avatarBlock retain];
        if (block) {
            block(self.avatarView.image);
        }
        [block release];
    }];
    [self addSubview:bgView];
    [bgView release];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, kAlbumHeight - 15, kScreenWidth - bgView.frame.size.width - 5.0, 15.0)];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentRight;
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont systemFontOfSize:13.0f];
    name.text = @"安吉丽娜.朱莉";
    self.titleLabel = name;
    [self addSubview:name];
    [name release];
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(10, bgView.frame.origin.y + bgView.frame.size.height, 45, 19.0)];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentRight;
    name.backgroundColor = [UIColor redColor];
    name.font = [UIFont systemFontOfSize:17.0f];
    name.text = @"今天";
    [self addSubview:name];
    [name release];
    
    UIButton *sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.frame = CGRectMake(name.frame.origin.x + name.frame.size.width + 5, name.frame.origin.y, 100, 70);
    [sendButton setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(requestAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
//    
//    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1.0, kScreenWidth, 1.0)];
//    line.backgroundColor = [UIColor colorWithRed:0.45 green:0.28 blue:0.61 alpha:1];
//    [self addSubview:line];
//    [line release];
}

- (void)requestAlbum:(id)sender
{
    requestAlbumBlock block = [reqBlock retain];
    if (block) {
        block();
    }
    [block release];
}

//! 查看当前用户的头像
- (void)examineAlbumWithCompletion:(avatarClickBlock)completion
{
    avatarBlock = [completion copy];
}

//！ 更换当前背景图片
- (void)changeAlbumWithCompletion:(albumClickBlock)completion
{
    albumBlock = [completion copy];
}

//! 发送新的状态消息
- (void)requestAlbumPhotoWithCompletion:(void (^)(void))completion
{
    reqBlock = [completion copy];
}

- (void)dealloc
{
    [avatarView release];
    [albumView release];
    [titleLabel release];
    [super dealloc];
}

@end
