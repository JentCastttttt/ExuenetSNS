//
//  IconWithNameRowModel.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-4-17.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WatchKit/WatchKit.h>

@interface IconWithNameRowModel : NSObject
@property (weak, nonatomic) IBOutlet WKInterfaceImage *iconView;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *nameLabel;

@end
