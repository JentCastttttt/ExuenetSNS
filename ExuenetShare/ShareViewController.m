//
//  ShareViewController.m
//  ExuenetShare
//
//  Created by Cao JianRong on 15-4-8.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "ShareViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "ListViewController.h"

@interface ShareViewController ()
{
    NSString *urlString;
}

@end

@implementation ShareViewController

- (BOOL)isContentValid {
    // Do validation of contentText and/or NSExtensionContext attachments here
//    NSExtensionItem *item = [self.extensionContext.inputItems firstObject];
//    if (!item) {
//        return NO;
//    }
//    NSItemProvider *itemProvider = [[item attachments] firstObject];
//    if (!itemProvider) {
//        return NO;
//    }
//    
//    if (([itemProvider hasItemConformingToTypeIdentifier:@"public.image"] || [itemProvider hasItemConformingToTypeIdentifier:@"public.url"]) && self.contentText) {
//        return YES;
//    }
    return YES;
}

- (void)viewDidLoad
{
    NSExtensionItem *item = [self.extensionContext.inputItems firstObject];
    
    NSLog(@"%d",[self.extensionContext.inputItems count]);
    
    NSArray *attatch = [item attachments];
    
    NSItemProvider *itemProvider = [attatch firstObject];
    
    if([itemProvider hasItemConformingToTypeIdentifier:(NSString*)kUTTypeURL])
    {
        NSLog(@"xxxxxxxx");
        [itemProvider loadItemForTypeIdentifier:(NSString*)kUTTypeURL options:nil completionHandler:^(NSURL* imageUrl, NSError *error) {
            NSLog(@"xxxxxxx123 = %@",imageUrl.absoluteString); //获取分享的URL
            urlString = imageUrl.absoluteString;
            NSLog(@"%@---%@",urlString,self.contentText);
        }];
    }
    if([itemProvider hasItemConformingToTypeIdentifier:(NSString*)kUTTypeImage]) {
        NSLog(@"image");
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeImage options:nil completionHandler:^(UIImage *items, NSError *error) {
            NSLog(@"%.2f-%.2f----%@",items.size.width,items.size.height,self.contentText);
        }];
    }
  
//    这样可以直接进入下一个界面，从而进行自定义的分享
//
//    ListViewController * listVC = [[ListViewController alloc] init];
//    
//    [self pushConfigurationViewController:listVC];
}

- (void)didSelectPost {
    // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
    // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
    NSArray *itemArray = [NSArray arrayWithArray:self.extensionContext.inputItems];
    
    NSLog(@"%d",[self.extensionContext.inputItems count]);
    
    NSExtensionItem *item = [itemArray firstObject];
    
    NSExtensionItem *outputItem = [item copy];
    //完成一些自己的操作 保存，添加 http请求
    UIAlertController * alter = [UIAlertController alertControllerWithTitle:@"分享提示" message:self.contentText preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:alter animated:YES completion:^{
        
    }];
    
    NSArray *attatch = [outputItem attachments];
    
    NSItemProvider *itemProvider = [attatch firstObject];
    
    if([itemProvider hasItemConformingToTypeIdentifier:(NSString*)kUTTypeImage]) {
        NSLog(@"image");
        [itemProvider loadItemForTypeIdentifier:(NSString *)kUTTypeJPEG options:nil completionHandler:^(UIImage *items, NSError *error) {
            NSLog(@"%.2f-%.2f",items.size.width,items.size.height);
        }];
    }
    
    outputItem.attributedContentText = [[NSAttributedString alloc] initWithString:self.contentText attributes:nil];
    
    NSArray * outPutitems= @[outputItem];
    
    [self.extensionContext completeRequestReturningItems:outPutitems completionHandler:nil];
}

- (NSArray *)configurationItems {
    // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
    SLComposeSheetConfigurationItem *oneItem = [[SLComposeSheetConfigurationItem alloc]init];
    oneItem.title = @"点击按钮";
    oneItem.valuePending = YES;
    oneItem.tapHandler = ^(void)
    {
        ListViewController * listVC = [[ListViewController alloc] init];
        
        [self pushConfigurationViewController:listVC];
    };
    return @[oneItem];
}

@end
