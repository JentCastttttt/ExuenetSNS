//
//  SettingInterfaceController.m
//  watchKitDemo
//
//  Created by Cao JianRong on 15-4-17.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "SettingInterfaceController.h"


@interface SettingInterfaceController()

@end


@implementation SettingInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"%@",context);
    // Configure interface objects here.
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    [self.settingView setRowTypes:@[@"settingIdentifier",@"contentIdentifier",@"settingIdentifier",@"contentIdentifier",@"settingIdentifier"]];
    NSInteger number = [self.settingView numberOfRows];
    for (int i = 0; i < number; i++) {
        switch (i%2) {
            case 0:
            {
                IconWithNameRowModel *model = [self.settingView rowControllerAtIndex:i];
                [model.iconView setImageNamed:@"1.png"];
                [model.nameLabel setText:[NSString stringWithFormat:@"用户%d",i]];
            }
                break;
            case 1:
            {
                ContentModel *model = [self.settingView rowControllerAtIndex:i];
                NSMutableAttributedString *atttibuteString = [[NSMutableAttributedString alloc] initWithString:@"文文笨笨撒的发生的发生的发顺丰文文笨笨撒的发生的发生的发顺丰文文笨笨撒的发生的发生的发顺丰文文笨笨撒的发生的发生的发顺丰文文笨笨撒的发生的发生的发顺丰"];
                [atttibuteString setAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]} range:NSMakeRange(0, atttibuteString.length)];
                [atttibuteString setAttributes:@{NSForegroundColorAttributeName:[UIColor yellowColor]} range:NSMakeRange(0, 5)];
                [model.contentLabel setAttributedText:atttibuteString];
            }
                break;
            default:
                break;
        }
    }
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

@end



