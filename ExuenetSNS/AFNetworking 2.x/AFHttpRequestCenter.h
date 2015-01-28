//
//  AFHttpRequestCenter.h
//  AFNetworkingDemo
//
//  Created by Cao JianRong on 14-9-3.
//  Copyright (c) 2014年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import "AFNetworking.h"
#import "AFNetworkActivityIndicatorManager.h"

@interface AFHttpRequestCenter : NSObject
{
    UIImageView *loadSprite;    //加载动画
    UIImageView *loadBackground; //加载背景
    UILabel *tipLabel;   //加载提示语
    UIImageView *maskView;  //蒙板
    AFHTTPRequestOperationManager *_shareOperationManager;   //请求队列
}
@property (nonatomic, retain) AFHTTPRequestOperationManager *shareOperationManager;

/*!
 *  单例进行实例化
 *
 *  @return 唯一的实例
 */
+ (AFHttpRequestCenter *)shareInstance;

/*!
 *  判断网络类型
 */
+ (void)prepareNetWork;

/*!
 *  集成调用AFNetworking的原始POST请求方式
 *
 *  @param URLString  请求URL
 *  @param parameters 请求参数
 *  @param success    成功返回
 *  @param failure    失败返回
 *  @param show       是否显示蒙板
 *
 *  @return 请求Operation
 */
- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure isShowLoading:(BOOL) show;

/*!
 *  集成调用AFNetworking的原始GET请求方式
 *
 *  @param URLString  请求URL
 *  @param parameters 请求参数
 *  @param success    成功返回
 *  @param failure    失败返回
 *  @param show       是否显示蒙板
 *
 *  @return 请求Operation
 */
- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure isShowLoading:(BOOL) show;

/*!
 *  集成调用AFNetworking的POST请求方式、请求类型为application/octet-stream  而不是application/form
 *
 *  @param URLString  请求URL
 *  @param parameters 请求参数
 *  @param success    成功返回
 *  @param failure    失败返回
 *  @param show       是否显示蒙板
 *
 *  @return 请求Operation
 */
- (AFHTTPRequestOperation *)putStreamPost:(NSString *)URLString
                                 parameters:(id)parameters
                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure isShowLoading:(BOOL) show;

//显示连接等待蒙板
-(void) showLoadView;

//移除连接等待蒙板
-(void) removeLoadView;

//设置显示蒙板时的提示语
-(void) setLoadText:(NSString *) text;

//暂停所有请求
-(void) cancelAllOperation;

//暂停某一个特定请求
-(void) cancelOperation:(AFHTTPRequestOperation *) opertation;

//检测网络是否存在
-(BOOL) isConnectedNetwork;


@end
