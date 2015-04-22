//
//  ActionViewController.m
//  ExuenetAction
//
//  Created by Cao JianRong on 15-4-9.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "ActionViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>

@interface ActionViewController ()

@property(strong,nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Get the item[s] we're handling from the extension context.
    
    // For example, look for an image and place it into an image view.
    // Replace this with something appropriate for the type[s] your extension supports.
    BOOL imageFound = NO;
    for (NSExtensionItem *item in self.extensionContext.inputItems) {
        for (NSItemProvider *itemProvider in item.attachments) {
            if ([itemProvider hasItemConformingToTypeIdentifier:(NSString *)kUTTypeImage]) {
                // This is an image. We'll load it, then place it in our image view.
                __weak UIImageView *imageView = self.imageView;
                [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *image, NSError *error) {
                    if(image) {
                        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                            [imageView setImage:image];
                        }];
                    }
                }];
                
                imageFound = YES;
                break;
            }
        }
        
        if (imageFound) {
            // We only handle one image, so stop looking for more.
            break;
        }
    }
}

//- (UIImage *)screenshot
//{
//    CGSize boundsSize = self.bounds.size;
//    CGFloat boundsWidth = self.bounds.size.width;
//    CGFloat boundsHeight = self.bounds.size.height;
//    
//    CGPoint offset = self.scrollView.contentOffset;
//    [self.scrollView setContentOffset:CGPointMake(0, 0)];
//    
//    CGFloat contentHeight = self.scrollView.contentSize.height;
//    NSMutableArray *images = [NSMutableArray array];
//    while (contentHeight > 0) {
//        UIGraphicsBeginImageContext(boundsSize);
//        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        [images addObject:image];
//        
//        CGFloat offsetY = self.scrollView.contentOffset.y;
//        [self.scrollView setContentOffset:CGPointMake(0, offsetY + boundsHeight)];
//        contentHeight -= boundsHeight;
//    }
//    [self.scrollView setContentOffset:offset];
//    
//    UIGraphicsBeginImageContext(self.scrollView.contentSize);
//    [images enumerateObjectsUsingBlock:^(UIImage *image, NSUInteger idx, BOOL *stop) {
//        [image drawInRect:CGRectMake(0, boundsHeight * idx, boundsWidth, boundsHeight)];
//    }];
//    UIImage *fullImage = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    return fullImage;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)done {
    // Return any edited content to the host app.
    // This template doesn't do anything, so we just echo the passed in items.
    [self.extensionContext completeRequestReturningItems:self.extensionContext.inputItems completionHandler:nil];
}

@end
