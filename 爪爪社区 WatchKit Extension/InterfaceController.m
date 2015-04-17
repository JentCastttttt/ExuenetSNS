//
//  InterfaceController.m
//  爪爪社区 WatchKit Extension
//
//  Created by Cao JianRong on 15-4-17.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "InterfaceController.h"


@interface InterfaceController()
{
    NSInteger rightNumber;
    float guessNumber;
}
- (IBAction)addNumber:(float)value;
@end


@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    NSLog(@"123");
    // Configure interface objects here.
    rightNumber = 5;
    guessNumber = 0.0;
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

- (IBAction)addNumber:(float)value {
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
                                                   
                                                   // next, get the lat/lon
//                                                   NSNumber *latitude = location[@"latitude"];
//                                                   NSNumber *longitude = location[@"longitude"];
//                                                   
//                                                   // and update our map
//                                                   MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
//                                                   CLLocationCoordinate2D coordinate = CLLocationCoordinate2DMake(latitude.doubleValue, longitude.doubleValue);
//                                                   
//                                                   // drop a pin where the user is currently
//                                                   [_mapView addAnnotation:coordinate withPinColor:WKInterfaceMapPinColorRed];
//                                                   
//                                                   // and give it a region to display
//                                                   MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
//                                                   [_mapView setRegion:region];
                                               }
                                               
                                               // the request failed
                                               else {
                                                   
                                               }
                                           }];
}

- (IBAction)notifyMeNow {
    
    UILocalNotification* notification = [UILocalNotification new];
    notification.alertTitle = @"Notification From WatchKit";
    notification.alertBody = @"Notification";
    
//    [WKInterfaceController presentLocalNotificationNow:notification completion:nil];
}

@end



