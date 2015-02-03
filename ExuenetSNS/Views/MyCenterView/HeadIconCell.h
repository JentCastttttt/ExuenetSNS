//
//  HeadIconCell.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadIconCell : UITableViewCell
{
    UILabel *titleLabel;
    UIImageView *iconView;
}
@property (nonatomic, retain)UILabel *titleLabel;
@property (nonatomic, retain)UIImageView *iconView;
@end
