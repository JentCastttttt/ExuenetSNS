//
//  DataCenter.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

//数据中心，用于保存一些整个应用全局的标志或者数据
#import "UserModel.h"

@interface DataCenter : NSObject
{
    UserModel *userInfo;
}
@property (nonatomic, retain) UserModel *userInfo;


+(DataCenter*)shareInstance;

@end
