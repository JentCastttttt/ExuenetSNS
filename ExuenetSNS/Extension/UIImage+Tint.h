//
//  UIImage+Tint.h
//  ecmc
//
//  Created by hangqian on 14-10-27.
//  Copyright (c) 2014年 cp9. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(extend)

- (UIImage *) imageWithTintColor:(UIColor *)tintColor;
- (UIImage *) imageWithGradientTintColor:(UIColor *)tintColor;

@end
