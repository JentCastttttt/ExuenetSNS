//
//  UserModel.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
@synthesize icon;
@synthesize name;
@synthesize exuenetName;
@synthesize school;
@synthesize sex;
@synthesize area;
@synthesize signFasion;

- (void)dealloc
{
    [icon release];
    [name release];
    [exuenetName release];
    [school release];
    [sex release];
    [area release];
    [signFasion release];
    [super dealloc];
}

@end
