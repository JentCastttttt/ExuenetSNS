//
//  ModifyViewCell.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  用户个人中心的详情信息界面（年龄、学校、个性签名...）

#import <UIKit/UIKit.h>

@interface ModifyViewCell : UITableViewCell
{
    UILabel *titleLabel;
    UILabel *valueLabel;
}
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UILabel *valueLabel;
@end
