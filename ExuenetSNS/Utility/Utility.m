//
//  Utility.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "Utility.h"
#import <objc/runtime.h>

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

/*!
 *  获取class(可能包含父类)的所有属性名称以及属性类型
 *
 *  @param objClass     实例Class
 *  @param containSuper 是否获取父类的属性
 *
 *  @return class的属性名称以及属性类型的Dictionary
 */
+ (NSMutableDictionary *)getPropertyFromClass:(Class)objClass containSuperClass:(BOOL)containSuper
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(objClass, &outCount);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:outCount];
    NSMutableArray *typeArray = [NSMutableArray arrayWithCapacity:outCount];
    for (i = 0; i < outCount; i++)
    {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        if([propertyName isEqualToString:@"primaryKey"]||[propertyName isEqualToString:@"rowid"])
            continue;
        [propertyArray addObject:propertyName];
        NSString *propertyType = [NSString stringWithCString: property_getAttributes(property) encoding:NSUTF8StringEncoding];
        /*
         c char、  i int、  l long、  s short、  d double、  f float
         @ id //指针 对象
         ...  BOOL 获取到的表示 方式是 char
         .... ^i 表示  int*  一般都不会用到ƒ
         */
        
        if ([propertyType hasPrefix:@"T@"]) {
            [typeArray addObject:[propertyType substringWithRange:NSMakeRange(3, [propertyType rangeOfString:@","].location-4)]];
        } else if ([propertyType hasPrefix:@"Ti"]) {
            [typeArray addObject:@"int"];
        }  else if ([propertyType hasPrefix:@"Tf"]) {
            [typeArray addObject:@"float"];
        } else if([propertyType hasPrefix:@"Td"]) {
            [typeArray addObject:@"double"];
        } else if([propertyType hasPrefix:@"Tl"]) {
            [typeArray addObject:@"long"];
        } else if ([propertyType hasPrefix:@"Tc"]) {
            [typeArray addObject:@"char"];
        } else if([propertyType hasPrefix:@"Ts"]) {
            [typeArray addObject:@"short"];
        }
    }
    free(properties);
    id obj = [[objClass alloc] init];
    if(containSuper && [obj superclass] != [NSObject class])
    {
        NSMutableDictionary *tmpDic = [self getPropertyFromClass:[obj superclass] containSuperClass:containSuper];
        [propertyArray addObjectsFromArray:[tmpDic objectForKey:@"name"]];
        [typeArray addObjectsFromArray:[tmpDic objectForKey:@"type"]];
    }
    [obj release];
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:propertyArray,@"name",typeArray,@"type",nil];
}

+ (NSMutableDictionary *)getPropertyFromClass:(Class)objClass
{
    return [self getPropertyFromClass:objClass containSuperClass:NO];
}

/*!
 *  获取class(可能包含父类)的所有属性名称
 *
 *  @param objClass     实例Class
 *  @param containSuper 是否获取父类的属性名称
 *
 *  @return Obj的属性名称数组
 */
+ (NSMutableArray *)getClassProperty:(Class)objClass containSuperClass:(BOOL)containSuper
{
    return [[self getPropertyFromClass:objClass containSuperClass:containSuper] objectForKey:@"name"];
}

+ (NSMutableArray *)getClassProperty:(Class)class
{
    return [[self getPropertyFromClass:class] objectForKey:@"name"];
}

//!  获取对象的属性名称列表
+ (NSMutableArray *)getPropertyArray:(id)obj
{
    Class class = [obj class];
    return [self getClassProperty:class];
}

//!  获取对象的属性名称与值的字典
+ (NSMutableDictionary *)getPropertyDictionary:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *propertyArray = [Utility getPropertyArray:obj];
    for (NSString *name in propertyArray) {
        id value = [obj valueForKey:name];
        if (!value) {
            continue;
        }
        if (![value isKindOfClass:[NSString class]]&&![value isKindOfClass:[NSNumber class]]&&![value isKindOfClass:[NSArray class]]) {
            value = [Utility getPropertyDictionary:value];
        }
        [dic setObject:value forKey:name];
    }
    return dic;
}

//!  将字典转换为Json字符串
+ (NSString *)getStringFromDictionary:(NSDictionary*)dic
{
    NSError *error;
    if ([dic count]==0) {
        return nil;
    }
    
    NSData *data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",string);
    [string stringRemoveWhiteAndEnter];
    return [string autorelease];
}

//!  将对象的属性和值进行Json序列化
+ (NSString *)getJsonFromObject:(id)obj
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    NSArray *propertyArray = [Utility getPropertyArray:obj];
    for (NSString *name in propertyArray) {
        id value = [obj valueForKey:name];
        if (!value) {
            continue;
        }
        if (![value isKindOfClass:[NSString class]]&&![value isKindOfClass:[NSNumber class]]&&![value isKindOfClass:[NSArray class]]) {
            value = [Utility getJsonFromObject:value];
        }
        else if ([value isKindOfClass:[NSArray class]]) {
            NSMutableArray *array = [[NSMutableArray alloc] init];
            for (id arrayObj in (NSArray*)value) {
                if ([arrayObj isKindOfClass:[NSString class]]) {
                    [array addObject:arrayObj];
                } else {
                    [array addObject:[self getJsonFromObject:arrayObj]];
                }
                
            }
            [dic setObject:array forKey:name];
            [array release];
            continue;
        }
        [dic setObject:value forKey:name];
    }
    return [Utility getStringFromDictionary:dic];
}

//!  根据字典对对象进行初始化设值
+ (void)instantiationProperty:(id)obj withDictionary:(NSDictionary*)dic
{
    NSArray *propertyArray = [Utility getPropertyArray:obj];
    for (NSString *propertyName in propertyArray) {
        NSString *value = [dic objectForKey:propertyName];
        if (!value) {
            value = @"";
        }
        [obj setValue:value forKey:propertyName];
    }
}

@end
