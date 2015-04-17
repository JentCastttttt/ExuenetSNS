//
//  SettingInterfaceController.h
//  watchKitDemo
//
//  Created by Cao JianRong on 15-4-17.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import "IconWithNameRowModel.h"
#import "ContentModel.h"

@interface SettingInterfaceController : WKInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceTable *settingView;

@end
