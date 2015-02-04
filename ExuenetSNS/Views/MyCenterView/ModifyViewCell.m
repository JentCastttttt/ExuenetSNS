//
//  ModifyViewCell.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//
//  用户个人中心的详情信息界面（年龄、学校、个性签名...）

#import "ModifyViewCell.h"

@implementation ModifyViewCell
@synthesize titleLabel;
@synthesize valueLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44.0)] autorelease];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.53 green:0.38 blue:0.68 alpha:1];
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self createInitView];
    }
    return self;
}

- (void)createInitView
{
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 43.0, kScreenWidth, 1.0)];
    img.backgroundColor = [UIColor colorWithRed:0.45 green:0.28 blue:0.61 alpha:1];
    [self addSubview:img];
    [img release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 15.0, 70.0, 14.5)];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    self.titleLabel = label;
    [self addSubview:label];
    [label release];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(75.0, 15.0, kScreenWidth - 30.0 - 75.0, 14.5)];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentRight;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:12.0f];
    self.valueLabel = label;
    [self addSubview:label];
    [label release];
}

@end
