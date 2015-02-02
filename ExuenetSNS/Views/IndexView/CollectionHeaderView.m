//
//  CollectionHeaderView.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-2.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "CollectionHeaderView.h"

@implementation CollectionHeaderView
@synthesize section;
@synthesize nameLabel;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        [line release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, 150.0, 20.0)];
        label.text = @"讨论组";
        label.textColor = [UIColor colorWithRed:0.55 green:0.33 blue:0.79 alpha:1];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:13.0f];
        self.nameLabel = label;
        [self addSubview:label];
        [label release];
        
        label = [[UILabel alloc] initWithFrame:CGRectMake(155.0, 5.0, kScreenWidth - 160.0, 20.0)];
        label.text = @"更多";
        label.textAlignment = NSTextAlignmentRight;
        label.textColor = [UIColor colorWithRed:0.55 green:0.33 blue:0.79 alpha:1];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:12.0f];
        [self addSubview:label];
        [label release];
        
        UIButton *more = [UIButton buttonWithType:UIButtonTypeCustom];
        more.frame = CGRectMake(label.frame.origin.x + 50.0, 0, label.frame.size.width - 50.0, 30.0);
        more.backgroundColor = [UIColor clearColor];
        [more addTarget:self action:@selector(clicked:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:more];
        
        line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29.5, kScreenWidth, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        [line release];
    }
    return self;
}

- (void)clicked:(id)sender
{
    headerClickedBlock clickBlock = [block retain];
    if (clickBlock) {
        clickBlock(self.section);
    }
    [clickBlock release];
}

- (void)headerClickedAtSection:(headerClickedBlock)completion
{
    block = [completion copy];
}

- (void)dealloc
{
    [nameLabel release];
    [super dealloc];
}

@end
