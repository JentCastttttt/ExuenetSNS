//
//  UIColor+extends.h
//  TextKitDemo
//
//  Created by Cao JianRong on 15-1-21.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <UIKit/UIKit.h>

// 扩展UIColor类
@interface UIColor (extends)

// 将十六进制的颜色值转为objective-c的颜色 例如  [UIColor colorFromString:@"ff8b3a"]
+ (UIColor *)colorFromString:(NSString *)hexColor;

// 将整数除以255.0之后进行颜色取值，方便书写
+ (UIColor *)colorWithScaleRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

// 获取随机颜色
+ (UIColor *)randomColor;

@end
