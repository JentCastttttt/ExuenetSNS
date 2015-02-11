//
//  NSString+extension.h
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-11.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <objc/runtime.h>

@interface NSString (extension)

/*!
 *  MD5加密 返回的是纯大写的字母，如要是纯小写，改为%02x即可
 *
 *  @return MD5加密后的字符串
 */
- (NSString *)md5HexDigest;

/*!
 *  进行URL编码，将特殊字符进行处理
 *
 *  @return 编码后的URL
 */
- (NSString *)urlEncodedString;

/*!
 *  进行URL解码，将特殊字符进行处理
 *
 *  @return 解码后的URL
 */
- (NSString *)urlDecodedString;

/*!
 *  去除NSString中的特殊字符、解码为XML文件
 *
 *  @return XML字符串
 */
- (NSString *)stringByDecodingXMLEntities;

/*!
 *  去除字符串中的特殊字符：\r,\n和空格
 *
 *  @return 不含特殊字符的字符串
 */
- (NSString *)stringRemoveWhiteAndEnter;

/*!
 *  将NSData进行Base64编码  得到一个字符串
 *
 *  @param data 编码的NSData
 *
 *  @return Base64编码后得到的字符串
 */
+ (NSString *)base64Encode:(NSData *)data;

/*!
 *  将NSString进行Base64解码  得到一个NSData对象
 *
 *  @param string 解码的字符串
 *
 *  @return Base64解码后得到的NSData
 */
+ (NSData *)base64Decode:(NSString *)string;

/*!
 *  将NSData进行解码得到NSString字符串
 *
 *  @param data 进行解码的NSData
 *
 *  @return 解码后得到的字符串
 */
+ (NSString *)base64DecodeFromNSData:(NSData *)data;

/*!
 *  将NSString从 Latin 编码重新进行UTF8编码
 *
 *  @param string Latin编码的字符串
 *
 *  @return UTF8编码的字符串
 */
+ (NSString *)latinEncode:(NSString*)string;

@end
