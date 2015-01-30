//
//  UIImageControl.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImageView+AFNetworking.h"

@interface UIImageControl : NSObject<UIScrollViewDelegate>
{
    CGRect       frame;
    UIView       *view;
    UIScrollView *scrollerView;
    UIImageView  *contentView;
    NSString     *imageUrl;
    NSString     *imageTitle;
    UIImage      *failImage;
}
@property (nonatomic,retain) NSString        *imageUrl;
@property (nonatomic,retain) NSString        *imageTitle;

- (id)initWithImage:(UIImage *)image;

- (id)initWithUrl:(NSString *)url andImageTitle:(NSString*)title;

- (id)initWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage andImageTitle:(NSString*)title;

- (void)show;

- (void)setFailImage:(UIImage *)image;
@end
