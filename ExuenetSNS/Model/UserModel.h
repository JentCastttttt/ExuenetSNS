//
//  UserModel.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-3.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
{
    NSString *icon;
    NSString *name;
    NSString *exuenetName;
    NSString *school;
    NSString *sex;
    NSString *area;
    NSString *signFasion;
}
@property (nonatomic, retain)NSString *icon;
@property (nonatomic, retain)NSString *name;
@property (nonatomic, retain)NSString *exuenetName;
@property (nonatomic, retain)NSString *school;
@property (nonatomic, retain)NSString *sex;
@property (nonatomic, retain)NSString *area;
@property (nonatomic, retain)NSString *signFasion;
@end
