//
//  LocationModel.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "LocationModel.h"

@implementation LocationModel

@synthesize country = _country;
@synthesize state = _state;
@synthesize city = _city;
@synthesize district = _district;
@synthesize street = _street;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;

- (void)dealloc
{
    [_country release];
    [_state release];
    [_city release];
    [_district release];
    [_street release];
    [super dealloc];
}

@end
