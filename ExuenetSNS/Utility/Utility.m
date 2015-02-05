//
//  Utility.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (void)showLoginViewController
{
    LoginViewController *login = [[LoginViewController alloc] init];
    login.title = @"登录";
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:login animated:YES completion:^{}];
    [login release];
}

//TODO:文件在项目中的目录
+ (NSString *)bundlePath:(NSString *)fileName
{
    return [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:fileName];
}

//TODO:文件在沙盒Documents下的目录
+ (NSString *)documentsPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [[paths lastObject] stringByAppendingPathComponent:fileName];
    return documentsDirectory;
}

//TODO:文件在沙盒缓存下的目录
+ (NSString *)cachesPath:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cacheDirectory = [[paths lastObject] stringByAppendingPathComponent:fileName];
    return cacheDirectory;
}

//TODO:创建文件夹到某个目录下，如果不存在，则创建
+ (BOOL)createFileAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL fileExist = false;
    NSError *error = nil;
    if (![manager fileExistsAtPath:path isDirectory:&fileExist]) {
        if (![manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]) {
            return NO;
        }
    }
    return YES;
}

//TODO:保存对象为指定目录下的任意类型文件(一般用作保存NSDictionary对象)
+ (BOOL)saveDictionaryToFile:(NSDictionary *)obj atPath:(NSString *)path
{
    if (![self createFileAtPath:path]) {
        return NO;
    }
    
    return [NSKeyedArchiver archiveRootObject:obj toFile:path];
}

//TODO:读取指定目录下的文件到NSDictionary
+ (NSMutableDictionary *)readFileToDictionaryFromPath:(NSString *)path
{
    NSMutableDictionary *obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return obj;
}

/*!
 *  显示警告提示框
 *
 *  @param msg 提示语
 */
+ (void)showAlertMessage:(NSString *)msg
{
    if (![msg isKindOfClass:[NSString class]]) {
        return ;
    }
    
    if ([msg length] == 0) {
        return ;
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
    [alert release];
}

@end
