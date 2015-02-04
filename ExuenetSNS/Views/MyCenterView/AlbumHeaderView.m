//
//  AlbumHeaderView.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-4.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "AlbumHeaderView.h"

@implementation AlbumHeaderView
@synthesize iconView;
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
    
}

- (void)dealloc
{
    [iconView release];
    [albumView release];
    [titleLabel release];
    [super dealloc];
}

@end
