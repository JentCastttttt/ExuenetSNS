//
//  HeadIconCell.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  用户个人信息详情界面头像界面

#import <UIKit/UIKit.h>

@interface HeadIconCell : UITableViewCell
{
    UILabel *titleLabel;
    UIImageView *iconView;
}
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UIImageView *iconView;
@end
