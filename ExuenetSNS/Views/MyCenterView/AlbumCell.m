//
//  AlbumCell.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "AlbumCell.h"

@implementation AlbumCell
@synthesize dateLabel;
@synthesize borderView;
@synthesize contentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:0.48 green:0.31 blue:0.65 alpha:1];
        self.selectedBackgroundView = [[[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 44.0)] autorelease];
        self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.53 green:0.38 blue:0.68 alpha:1];
        
        [self createInitView];
    }
    return self;
}

- (void)createInitView
{
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 55, 15)];
    date.text = @"23十二月";
    date.font = [UIFont systemFontOfSize:11.0f];
    date.backgroundColor = [UIColor clearColor];
    date.textColor = [UIColor blackColor];
    self.dateLabel = date;
    [self addSubview:date];
    [date release];
    
    UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(60, 5, kScreenWidth - 65, 34)];
    border.backgroundColor = [UIColor colorWithRed:0.76 green:0.55 blue:0.73 alpha:1];
    self.borderView = border;
    [self addSubview:border];
    [border release];
    
    UIImageView *icon = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 24, 24)];
    [icon setImage:[UIImage imageNamed:@"1.png"]];
    [border addSubview:icon];
    [icon release];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(35, 5, border.frame.size.width - 40, 14)];
    label.text = @"asdl;fjal;sdjfl;ajsdkl;fjkl;asjklf;ja;lsskdjfl;asd";
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:11.0f];
    label.textColor = [UIColor blackColor];
    self.contentLabel = label;
    [border addSubview:label];
    [label release];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)dealloc
{
    [dateLabel release];
    [borderView release];
    [contentLabel release];
    [super dealloc];
}

@end
