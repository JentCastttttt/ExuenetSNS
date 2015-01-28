//
//  Utility.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

+ (NSString *)bundlePath:(NSString *)fileName;

+ (NSString *)documentsPath:(NSString *)fileName;

+ (NSString *)cachesPath:(NSString *)fileName;

+ (BOOL)createFileAtPath:(NSString *)path;

+ (BOOL)saveDictionaryToFile:(NSDictionary *)obj atPath:(NSString *)path;

+ (NSMutableDictionary *)readFileToDictionaryFromPath:(NSString *)path;

@end
