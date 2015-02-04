//
//  HeadIconCell.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  用户个人信息详情界面头像界面

#import "HeadIconCell.h"

@implementation HeadIconCell
@synthesize titleLabel;
@synthesize iconView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 90.0)] autorelease];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.53 green:0.38 blue:0.68 alpha:1];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self createInitView];
    }
    return self;
}

- (void)createInitView
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 89.0, kScreenWidth, 1.0)];
    img.backgroundColor = [UIColor colorWithRed:0.45 green:0.28 blue:0.61 alpha:1];
    [self addSubview:img];
    [img release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 37.5, 70.0, 14.5)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    self.titleLabel = label;
    [self addSubview:label];
    [label release];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenWidth - 75.0 - 30.0, 7.5, 75.0, 75.0)];
    icon.clipsToBounds = YES;
    icon.layer.cornerRadius = 75.0/2.0;
    icon.layer.borderWidth = 4.0f;
    icon.layer.borderColor = [UIColor colorWithRed:0.43 green:0.27 blue:0.6 alpha:1].CGColor;
    [icon setImage:[UIImage imageNamed:@"1.png"]];
    self.iconView = icon;
    [self addSubview:icon];
    [icon release];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
