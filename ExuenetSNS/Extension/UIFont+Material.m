//
//  UIFont+Material.m
//  ExuenetSNS
//
//  Created by JianRongCao on 15/9/1.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "UIFont+Material.h"


@implementation UIFont (Material)


+ (UIFont *)helveticamFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Helvetica-Light" size:fontSize];
}

+ (UIFont *)boldHelveticamSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Helvetica-Bold" size:fontSize];
}

+ (UIFont *)italicBoldHelveticamSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont fontWithName:@"Helvetica-BoldOblique" size:fontSize];
}

+ (void)printAllFont
{
    NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
    NSArray *fontNames;
    NSInteger iFamily, iFont;
    for (iFamily=0; iFamily<[familyNames count]; ++iFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:iFamily]);
        fontNames = [[NSArray alloc] initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:iFamily]]];
        for (iFont=0; iFont<[fontNames count]; ++iFont)
        {
            NSLog(@"    Font name: %@", [fontNames objectAtIndex:iFont]);
        }
    }
}

@end
