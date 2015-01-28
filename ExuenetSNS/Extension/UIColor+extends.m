//
//  UIColor+extends.m
//  TextKitDemo
//
//  Created by Cao JianRong on 15-1-21.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "UIColor+extends.h"

@implementation UIColor (extends)

+ (UIColor *)colorFromString:(NSString *) hexColor
{
    unsigned int redInt_, greenInt_, blueInt_;
    NSRange rangeNSRange_;
    rangeNSRange_.length = 2;  // 范围长度为2
    
    // 取红色的值
    rangeNSRange_.location = 0;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&redInt_];
    
    // 取绿色的值
    rangeNSRange_.location = 2;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&greenInt_];
    
    // 取蓝色的值
    rangeNSRange_.location = 4;
    [[NSScanner scannerWithString:[hexColor substringWithRange:rangeNSRange_]] scanHexInt:&blueInt_];
    
    return [UIColor colorWithRed:(float)(redInt_/255.0f) green:(float)(greenInt_/255.0f) blue:(float)(blueInt_/255.0f) alpha:1.0f];
}

+ (UIColor *)colorWithScaleRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha
{
    if(alpha >= 1.0) {
        alpha = 1.0;
    }
    
    if (alpha <= 0.0) {
        alpha = 0.0;
    }
    
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:alpha];
}

+ (UIColor *)randomColor
{
    CGFloat red = (CGFloat)arc4random_uniform(255)/255.0f;
    CGFloat green = (CGFloat)arc4random_uniform(255)/255.0f;
    CGFloat blue = (CGFloat)arc4random_uniform(255)/255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

@end
