//
//  ClassmatesCell.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "ClassmatesCell.h"

@implementation ClassmatesCell
@synthesize icon;
@synthesize name;
@synthesize school;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        CGFloat height = frame.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"placeholder_horizontal"]];
        imageView.backgroundColor = [UIColor redColor];
        imageView.frame = CGRectMake(0, 0, height, height);
        imageView.layer.cornerRadius = height/2.0f;
        imageView.clipsToBounds = YES;
        self.icon = imageView;
        [self addSubview:imageView];
        [imageView release];
        
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(height + 3, 3.0, height - 3.0, 15.0)];
        lb.text = @"丽萨";
        lb.textColor = [UIColor colorWithRed:0.83 green:0.33 blue:0.24 alpha:1];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = [UIFont systemFontOfSize:9.0f];
        self.name = lb;
        [self addSubview:lb];
        [lb release];
        
        lb = [[UILabel alloc] initWithFrame:CGRectMake(height + 3.0, 17.0, height - 3.0, 15.0)];
        lb.text = @"德光中学";
        lb.textColor = [UIColor blackColor];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = [UIFont systemFontOfSize:7.0f];
        self.school = lb;
        [self addSubview:lb];
        [lb release];
    }
    return self;
}

-(void) dealloc
{
    [icon release];
    [name release];
    [school release];
    [super dealloc];
}
@end
