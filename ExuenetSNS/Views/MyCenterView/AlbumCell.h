//
//  AlbumCell.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  我的相册列表

#import <UIKit/UIKit.h>

@interface AlbumCell : UITableViewCell
{
    UILabel *dateLabel;
    UIImageView *borderView;
    UILabel *contentLabel;
}
@property (nonatomic, retain) UILabel *dateLabel;
@property (nonatomic, retain) UIImageView *borderView;
@property (nonatomic, retain) UILabel *contentLabel;
@end
