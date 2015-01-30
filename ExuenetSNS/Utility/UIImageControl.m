//
//  UIImageControl.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-28.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "UIImageControl.h"

@implementation UIImageControl
@synthesize imageTitle;
@synthesize imageUrl;

- (id)init
{
    self = [super init];
    if (self) {
        frame = [self CGRectForOrientation];
        
        view = [[UIView alloc] initWithFrame:frame];
        view.backgroundColor = [UIColor blackColor];
        
        scrollerView = [[UIScrollView alloc] initWithFrame:frame];
        scrollerView.minimumZoomScale = 0.5;
        scrollerView.maximumZoomScale = 5.0;
        scrollerView.multipleTouchEnabled = YES;
        scrollerView.delegate = self;
        [view addSubview:scrollerView];
        [scrollerView release];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewHidden:)];
        [scrollerView addGestureRecognizer:tapGesture];
        [tapGesture release];
        
        contentView = [[UIImageView alloc] initWithFrame:frame];
        contentView.backgroundColor = [UIColor lightGrayColor];
        [scrollerView addSubview:contentView];
        [contentView release];
        
        failImage = nil;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [self init];
    if (self) {
        contentView.image = image;
        [self setImageSize:image.size];
        
    }
    return self;
}

- (id)initWithUrl:(NSString *)url andImageTitle:(NSString *)title
{
    self = [self init];
    if (self) {
        self.imageUrl = url;
        self.imageTitle = title;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [contentView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [contentView setImage:image];
            [self setImageSize:image.size];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            [contentView setImage:failImage];
        }];
//        [contentView setImageWithURL:[NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
    return self;
}

- (id)initWithUrl:(NSString *)url placeholderImage:(UIImage *)placeholderImage andImageTitle:(NSString*)title
{
    self = [self init];
    if (self) {
        self.imageUrl = url;
        self.imageTitle = title;
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
        [contentView setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            [contentView setImage:image];
            [self setImageSize:image.size];
        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
            if (failImage) {
                [contentView setImage:failImage];
            } else {
                [contentView setImage:placeholderImage];
            }
        }];
        
        
        [contentView setImageWithURL:[NSURL URLWithString:[imageUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]] placeholderImage:placeholderImage];
    }
    return self;
}

-(void) show
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self retain];
    UIWindow *mainWindow = [UIApplication sharedApplication].delegate.window;
    UIViewController *rootViewController = mainWindow.rootViewController;
    [rootViewController.view addSubview:view];
}

-(void) viewHidden:(UITapGestureRecognizer *)tap
{
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
    [view removeFromSuperview];
    [self release];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    contentView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return contentView;
}

- (void)setImageSize:(CGSize)iamgeSize
{
    CGRect contentFrame = frame;
//    CGFloat imageView_X = (iamgeSize.width > contentFrame.size.width) ? contentFrame.size.width : iamgeSize.width;
    CGFloat imageView_Y=(iamgeSize.height > contentFrame.size.height) ? contentFrame.size.height : iamgeSize.height;
    CGFloat origin;
    //保持图片的比例
    if(iamgeSize.width > contentFrame.size.width){
        origin = contentFrame.size.width/iamgeSize.width;
        imageView_Y = iamgeSize.height*origin;
    }
    if (imageView_Y > [UIScreen mainScreen].bounds.size.height) {
        contentView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, imageView_Y);
    } else {
        contentView.frame = CGRectMake(0, (contentFrame.size.height-imageView_Y)/2, [UIScreen mainScreen].bounds.size.width, imageView_Y);
        [scrollerView setContentSize:CGSizeMake(scrollerView.frame.size.width, imageView_Y)];
    }
}

-(CGRect)CGRectForOrientation
{
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return  [UIScreen mainScreen].bounds;
    } else {
        return [UIScreen mainScreen].bounds;
    }
}

- (void)setFailImage:(UIImage *)image
{
    if (!failImage) {
        [failImage release];
        failImage = nil;
    }
    
    failImage = [image retain];
}

-(void) dealloc
{
    [imageUrl release];
    [imageTitle release];
    [super dealloc];
}

@end
