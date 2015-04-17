//
//  NotificationController.h
//  爪爪社区 WatchKit Extension
//
//  Created by Cao JianRong on 15-4-17.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@interface NotificationController : WKUserNotificationInterfaceController
@property (weak, nonatomic) IBOutlet WKInterfaceImage *noRainImage;
@property (weak, nonatomic) IBOutlet WKInterfaceImage *hasRain;

@end
