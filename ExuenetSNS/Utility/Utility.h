//
//  Utility.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (void)showLoginViewController;

+ (NSString *)bundlePath:(NSString *)fileName;

+ (NSString *)documentsPath:(NSString *)fileName;

+ (NSString *)cachesPath:(NSString *)fileName;

+ (BOOL)createFileAtPath:(NSString *)path;

+ (BOOL)saveDictionaryToFile:(NSDictionary *)obj atPath:(NSString *)path;

+ (NSMutableDictionary *)readFileToDictionaryFromPath:(NSString *)path;

+ (void)showAlertMessage:(NSString *)msg;

/*!
 *  获取class(可能包含父类)的所有属性名称以及属性类型
 *
 *  @param objClass     实例Class
 *  @param containSuper 是否获取父类的属性
 *
 *  @return class的属性名称以及属性类型的Dictionary
 */
+ (NSMutableDictionary *)getPropertyFromClass:(Class)objClass containSuperClass:(BOOL)containSuper;

+ (NSMutableDictionary *)getPropertyFromClass:(Class)objClass;

/*!
 *  获取class(可能包含父类)的所有属性名称
 *
 *  @param objClass     实例Class
 *  @param containSuper 是否获取父类的属性名称
 *
 *  @return Obj的属性名称数组
 */
+ (NSMutableArray *)getClassProperty:(Class)objClass containSuperClass:(BOOL)containSuper;

+ (NSMutableArray *)getClassProperty:(Class)objClass;

//!  获取对象的属性名称列表
+ (NSMutableArray *)getPropertyArray:(id)obj;

//!  获取对象的属性名称与值的字典
+ (NSMutableDictionary *)getPropertyDictionary:(id)obj;

//!  将字典转换为Json字符串
+ (NSString *)getStringFromDictionary:(NSDictionary*)dic;

//!  将对象的属性和值进行Json序列化
+ (NSString *)getJsonFromObject:(id)obj;

//!  根据字典对对象进行初始化设值
+ (void)instantiationProperty:(id)obj withDictionary:(NSDictionary*)dic;

@end
