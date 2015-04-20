//
//  InterfaceController.m
//  爪爪社区 WatchKit Extension
//
//  Created by Cao JianRong on 15-4-17.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "InterfaceController.h"
#import "MMWormhole.h"

@interface InterfaceController()
{
    NSInteger rightNumber;
    float guessNumber;
}
@property (nonatomic, strong) MMWormhole *wormhole;

- (IBAction)addNumber:(float)value;

@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"123");
    // Configure interface objects here.
    rightNumber = 5;
    guessNumber = 0.0;
    
    // Initialize the wormhole
    self.wormhole = [[MMWormhole alloc] initWithApplicationGroupIdentifier:@"group.com.mutualmobile.wormhole"
                                                         optionalDirectory:@"wormhole"];
    
    // Obtain an initial value for the selection message from the wormhole
    id messageObject = [self.wormhole messageWithIdentifier:@"selection"];
    NSString *string = [messageObject valueForKey:@"selectionString"];
    
    if (string != nil) {
        [self.numberLabel setText:string];
    }
    
    // Listen for changes to the selection message. The selection message contains a string value
    // identified by the selectionString key. Note that the type of the key is included in the
    // name of the key.
    [self.wormhole listenForMessageWithIdentifier:@"selection" listener:^(id messageObject) {
        NSString *string = [messageObject valueForKey:@"selectionString"];
        
        if (string != nil) {
            [self.numberLabel setText:string];
        }
    }];
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)guessThisNumber:(id)sender
{
    if (rightNumber == guessNumber) {
        [self.numberLabel setText:[NSString stringWithFormat:@"You Guess is:%.0f right",guessNumber]];
        [self.numberLabel setTextColor:[UIColor greenColor]];
    } else {
        [self.numberLabel setText:[NSString stringWithFormat:@"You Guess is:%.0f wrong",guessNumber]];
        [self.numberLabel setTextColor:[UIColor redColor]];
    }
    
    [self pushControllerWithName:@"settingController" context:@"sasdf"];
}

// Pass messages each time a button is tapped using the identifier button
// The messages contain a single number value with the buttonNumber key
- (IBAction)addNumber:(float)value {
    //发送一个Message通知给宿主App.
    [self.wormhole passMessageObject:@{@"buttonNumber" : @(1)} identifier:@"button"];
    
    NSLog(@"%.0f",value);
    guessNumber = value;
    [self.numberLabel setText:[NSString stringWithFormat:@"You Guess is:%.0f",value]];
    [self pushControllerWithName:@"listController" context:@"sasdf"];
}

- (void)handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)localNotification
{
    NSLog(@"Loading action:%@",identifier);
}

- (void)handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)remoteNotification
{
    NSLog(@"Loading action:%@",identifier);
}

- (void)handleUserActivity:(NSDictionary *)userInfo
{
    NSLog(@"userInfo:%@",userInfo);
}

- (IBAction)notifyMe {
    
    UILocalNotification* notification = [UILocalNotification new];
    notification.alertTitle = @"Notification From WatchKit";
    notification.alertBody = @"Notification";
    notification.fireDate = [[NSDate date] dateByAddingTimeInterval:5.0];
    
    [self requestLocationFromPhone];
    
}

//不打开宿主App，将宿主App获取到的数据返回给Apple Watch. 从而进行相应的处理
- (void) requestLocationFromPhone
{
    [WKInterfaceController openParentApplication:@{@"request":@"location"}
                                           reply:^(NSDictionary *replyInfo, NSError *error) {
                                               
                                               // the request was successful
                                               if(error == nil) {
                                                   
                                                   // get the serialized location object
                                                   NSDictionary *location = replyInfo[@"location"];
                                                   
                                                   // pull out the speed (it's an NSNumber)
                                                   NSNumber *speed = location[@"speed"];
                                                   
                                                   // and convert it to a string for our label
                                                   NSString *speedString = [NSString stringWithFormat:@"Speed: %g", speed.doubleValue];
                                                   
                                                   // update our label with the newest location's speed
                                                   [self.numberLabel setText:speedString];
                                               }
                                               
                                               // the request failed
                                               else {
                                                   
                                               }
                                           }];
}

@end