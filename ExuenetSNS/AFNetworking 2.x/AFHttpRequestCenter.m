//
//  AFHttpRequestCenter.m
//  AFNetworkingDemo
//
//  Created by Cao JianRong on 14-9-3.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import "AFHttpRequestCenter.h"

static AFHttpRequestCenter *_sharedNetworkManager;

@implementation AFHttpRequestCenter
@synthesize shareOperationManager = _shareOperationManager;

//实例化
+ (AFHttpRequestCenter *)shareInstance
{
	@synchronized(self)
	{
		if (!_sharedNetworkManager) {
			_sharedNetworkManager=[[self alloc] init];
		}
	}
	return _sharedNetworkManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _shareOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:nil];
        _shareOperationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    }
    return self;
}

+ (void)prepareNetWork
{
    //检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"No Internet Connection");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WIFI");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                {  //如果返回的类型是WWAN  则在进一步判断网络类型。   注:此功能只能在iOS7下使用
                    CTTelephonyNetworkInfo *telephonyInfo = [CTTelephonyNetworkInfo new];
                    if ([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyEdge]
                        || [telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyGPRS])
                    {
                        NSLog(@"2G");
                    } else if([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyWCDMA]){
                        NSLog(@"3G");
                    } else if([telephonyInfo.currentRadioAccessTechnology isEqualToString:CTRadioAccessTechnologyLTE]) {
                        NSLog(@"4G");
                    } else {
                        NSLog(@"不清楚类型");;
                    }
                }
                    break;
                default:
                    NSLog(@"Unkown network status");
                    break;
        }
    }];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure isShowLoading:(BOOL) show
{
    //add loading
    if (show) {
        [self showLoadView];
    }
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *operation = nil;
    operation = [_shareOperationManager POST:URLString parameters:parameters success:success failure:failure];
    
    //if show = YES ,do not show ActivityIndicator
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:!show];
    
    return operation;
}


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure isShowLoading:(BOOL) show
{
    //add loading
    if (show) {
        [self showLoadView];
    }
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    AFHTTPRequestOperation *operation = nil;
    operation = [_shareOperationManager GET:URLString parameters:parameters success:success failure:failure];
    
    //if show = YES ,do not show ActivityIndicator
    [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:!show];
    
    return operation;
}

- (AFHTTPRequestOperation *)putStreamPost:(NSString *)URLString
                                 parameters:(id)parameters
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure isShowLoading:(BOOL) show
{
    if (show) {
        [self showLoadView];
    }
    
    URLString = [URLString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
        return nil;
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString : %@",jsonString);
    }
    
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString]];
    [request setValue:@"application/octet-stream" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:data];
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [request release];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    [_shareOperationManager.operationQueue addOperation:operation];
    [jsonString release];
    [operation release];
    return operation;
}

//显示or移除
-(void) showLoadView
{
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;

    if (loadBackground == nil) {
        loadBackground = [[UIImageView alloc] initWithFrame:CGRectMake(93, (iPhone568?160:120), 135, 100)];
        loadBackground.image = [UIImage imageNamed:@"load_back"];
    }
    
    if (loadSprite == nil) {
        loadSprite = [[UIImageView alloc] initWithFrame:CGRectMake(43, 13, 50, 50)];
        loadSprite.image = [UIImage imageNamed:@"load_sprite"];
        [loadBackground addSubview:loadSprite];
    }
    
    if (tipLabel == nil) {
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 135, 30)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:11];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"";
    }
    
    if ([tipLabel.text isEqualToString:@""]) {
        tipLabel.text = @"努力加载中，请稍后(^_^)";
    }
    
//    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:12.0f]};
//    CGSize size = [tipLabel.text boundingRectWithSize:CGSizeMake(280, 15) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    if (size.width > 100) {
//        loadBackground.frame = CGRectMake(160-size.width/2, (iPhone568?160:120), size.width, 100);
//        tipLabel.frame = CGRectMake(0, 70, size.width, 30);
//
//    }
    
    [tipLabel removeFromSuperview];
    [loadBackground addSubview:tipLabel];
    
    CABasicAnimation * rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotation.fromValue = [NSNumber numberWithDouble:0];
    rotation.toValue = [NSNumber numberWithDouble:-4*M_PI];
    rotation.duration = 1;
    rotation.repeatCount = INFINITY;
    [loadSprite.layer addAnimation:rotation forKey:@"rotation"];
    
    if (maskView == nil)
    {
        maskView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 66, 320,(iPhone568?568:480)-66)];
        maskView.backgroundColor = [UIColor clearColor];
        [maskView addSubview:loadBackground];
        maskView.userInteractionEnabled = YES;
    }
    
    [maskView removeFromSuperview];
    [keyWindow addSubview:maskView];
}


-(void) removeLoadView
{
    [loadSprite.layer removeAllAnimations];
    [maskView removeFromSuperview];
    tipLabel.text = @"";
}

-(void) setLoadText:(NSString *) text
{
    if (tipLabel == nil)
    {
        tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, 135, 30)];
        tipLabel.backgroundColor = [UIColor clearColor];
        tipLabel.font = [UIFont systemFontOfSize:11];
        tipLabel.textColor = [UIColor whiteColor];
        tipLabel.textAlignment = NSTextAlignmentCenter;
        tipLabel.text = @"";
    }
    
    tipLabel.text = text;
}

-(void) cancelAllOperation
{
    [_shareOperationManager.operationQueue cancelAllOperations];
    [self removeLoadView];
}

-(void) cancelOperation:(AFHTTPRequestOperation *) opertation
{
    if (opertation == nil)
    {
        return ;
    }
    [opertation cancel];
    opertation = nil;
    [self removeLoadView];
}

//检测网络是否存在
-(BOOL) isConnectedNetwork
{
    return [AFNetworkReachabilityManager sharedManager].reachable;
}

- (void)dealloc
{
    if (loadSprite)
    {
        [loadSprite release];
    }
    if (loadBackground)
    {
        [loadBackground release];
    }
    if (tipLabel)
    {
        [tipLabel release];
    }
    if (_shareOperationManager.operationQueue)
    {
        [_shareOperationManager.operationQueue cancelAllOperations];
    }
    if (_shareOperationManager)
    {
        [_shareOperationManager release];
    }
    [super dealloc];
}

@end
