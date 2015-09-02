//
//  DiscGroupViewController.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-1-30.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "DiscGroupViewController.h"

static NSString *const KVO_CONTEXT_ADDRESS_CHANGED = @"KVO_CONTEXT_ADDRESS_CHANGED";

@interface Person : NSObject

@property (nonatomic, retain) NSString *name;

@property (nonatomic, retain) NSString *sex;

@property (nonatomic, retain) NSString *fav;

@property (nonatomic, retain) Person *child;

@end

@implementation Person


@end

@interface DiscGroupViewController()<UIGestureRecognizerDelegate>
{
    Person *son;
    Person *wang;
}
@end

@implementation DiscGroupViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panMove:)];
    pan.delegate = self;
    [self.view addGestureRecognizer:pan];
    [pan release];

    son = [[Person alloc] init];
    son.name = @"caoI";
    son.sex = @"male";
    son.fav = @"basketball";
    
    
    wang = [[Person alloc] init];
    wang.name = @"yaofengqing";
    wang.sex = @"woman";
    wang.fav = @"TV";
    wang.child = son;
    
    [wang addObserver:self forKeyPath:@"child.fav" options:NSKeyValueObservingOptionNew context:KVO_CONTEXT_ADDRESS_CHANGED];

//    NSTimer *time = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(changFav) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:time forMode:NSDefaultRunLoopMode];

//    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(changFav) userInfo:nil repeats:YES];
    
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [self performSelector:@selector(changFav) withObject:nil afterDelay:3.0];
//}

- (void)changFav
{
//    [wang willChangeValueForKey:@"child.fav"];
    son.fav = [NSString stringWithFormat:@"%@,%@",wang.fav,son.fav];
//    [wang didChangeValueForKey:@"child.fav"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    NSLog(@"%@",keyPath);
    NSLog(@"%@",object);
    NSLog(@"%@",change);
    NSLog(@"%@",context);
}

- (void)panMove:(UIGestureRecognizer *)gesture
{
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            NSLog(@"begin");
            break;
        case UIGestureRecognizerStateChanged:
            NSLog(@"move");
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"end");
        default:
            break;
    }
}


@end
