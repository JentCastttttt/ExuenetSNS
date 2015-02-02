//
//  CollectionCell.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "CollectionCell.h"

@implementation CollectionCell
@synthesize icon;
@synthesize name;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat width = frame.size.width;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder_horizontal"]];
        imageView.backgroundColor = [UIColor redColor];
        imageView.frame = CGRectMake(0, 0, width, width);
        self.icon = imageView;
        [self addSubview:imageView];
        [imageView release];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, width + 2.5, width, 13.0)];
        lb.text = @"语文天地";
        lb.textAlignment = NSTextAlignmentCenter;
        lb.textColor = [UIColor blackColor];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = [UIFont systemFontOfSize:11.0f];
        self.name = lb;
        [self addSubview:lb];
        [lb release];
    }
    return self;
}

-(void) dealloc
{
    [icon release];
    [name release];
    [super dealloc];
}

@end
