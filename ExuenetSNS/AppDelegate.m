//
//  AppDelegate.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "AppDelegate.h"
#import "WWSideslipViewController.h"
#import "IndexViewController.h"
#import "LeftIndexViewController.h"
#import "WelcomeViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
   
//  iOS系统的APNS使用。 区分iOS8之后 以为 iOS8之前的推送用法
//#ifdef __IPHONE_8_0
//    //ios8注册推送
//    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge
//                                                                                         |UIRemoteNotificationTypeSound
//                                                                                         |UIRemoteNotificationTypeAlert) categories:nil];
//    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//#else
//    //register to receive notifications
//    UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound;
//    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:myTypes];
//#endif
    
    if ([UIApplication instancesRespondToSelector:@selector(registerUserNotificationSettings:)])
    {
        //1.创建消息上面要添加的动作(按钮的形式显示出来)
        //接受按钮
        UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
        acceptAction.identifier = @"acceptAction"; //按钮的标示
        acceptAction.title = @"接受"; //按钮的标题
        acceptAction.activationMode = UIUserNotificationActivationModeForeground; //当点击的时候启动程序
        
        //拒绝按钮
        UIMutableUserNotificationAction *rejectAction = [[UIMutableUserNotificationAction alloc] init];
        rejectAction.identifier = @"rejectAction";
        rejectAction.title = @"拒绝";
        rejectAction.activationMode = UIUserNotificationActivationModeBackground; //当点击的时候不启动程序，在后台处理
        rejectAction.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
        rejectAction.destructive = YES;
        
        //2.创建动作(按钮)的类别集合
        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
        categorys.identifier = @"alert";
        NSArray *actions = @[acceptAction, rejectAction];
        [categorys setActions:actions forContext:UIUserNotificationActionContextMinimal];
        
        //3.创建UIUserNotificationSettings，并设置消息的显示类类型以及注册推送
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:[NSSet setWithObject:categorys]]];
        
        //用这两个方法判断是否注册成功
        // NSLog(@"currentUserNotificationSettings = %@",[[UIApplication sharedApplication] currentUserNotificationSettings]);
        //[[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
        
    }
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    WelcomeViewController *welcome = [[WelcomeViewController alloc] init];

    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:20.0f],NSFontAttributeName,[UIColor colorFromString:@"ffffff"],NSForegroundColorAttributeName,nil];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:welcome];
    navi.navigationBar.titleTextAttributes = dict;
    navi.navigationBar.tintColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1];
    navi.navigationBar.barTintColor = [UIColor colorWithRed:0.99 green:0.62 blue:0.36 alpha:1];
    [navi.navigationBar setHidden:YES];
    [welcome release];
    
    self.window.rootViewController = navi;
    [navi release];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

//#ifdef __IPHONE_8_0
//ios8需要调用内容
//- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
//{
//    //register to receive notifications
//    [application registerForRemoteNotifications];
//}
//
//- (void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void(^)())completionHandler
//{
//    //handle the actions
//    if ([identifier isEqualToString:@"declineAction"]){
//    }
//    else if ([identifier isEqualToString:@"answerAction"]){
//    }
//}
//
//#endif
//
//- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
//{
//    NSLog(@"设备令牌: %@", deviceToken);
//    NSString *tokeStr = [NSString stringWithFormat:@"%@",deviceToken];
//    if ([tokeStr length] == 0) {
//        return;
//    }
//}
//
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    NSLog(@"%@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
//    //以警告框的方式来显示推送消息
//    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"经过推送发送过来的消息"
//                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
//                                                       delegate:self
//                                              cancelButtonTitle:@"关闭"
//                                              otherButtonTitles:@"处理",nil];
//        [alert show];
//    }
//}
//
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
//    NSLog(@"注册推送服务时，发生以下错误： %@",error);
//}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    NSLog(@"%@", notificationSettings);
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void(^)())completionHandler
{
    //在非本App界面时收到本地消息，下拉消息会有快捷回复的按钮，点击按钮后调用的方法，根据identifier来判断点击的哪个按钮，notification为消息内容
    NSLog(@"----%@\n----%@\n----%@\n",identifier,notification,notification.userInfo);
    //处理完消息，最后一定要调用这个代码块
    if([identifier isEqualToString:@"rejectAction"]) {
        //设置快速回复
    }
    
    completionHandler();
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification*)notification
{
    NSLog(@"%@",[notification.userInfo objectForKey:@"key"]);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"接收到本地提醒 in app"
                          
                                                    message:notification.alertBody
                          
                                                   delegate:nil
                          
                                          cancelButtonTitle:@"确定"
                          
                                          otherButtonTitles:nil];
    
    [alert show];
    
    //这里，你就可以通过notification的useinfo，干一些你想做的事情了
    application.applicationIconBadgeNumber -= 1;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
