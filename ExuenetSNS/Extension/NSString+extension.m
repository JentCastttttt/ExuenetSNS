//
//  NSString+extension.m
//  ExuenetSNS
//
//  Created by Cao JianRong on 15-2-11.
//  Copyright (c) 2015年 Cao JianRong. All rights reserved.
//

#import "NSString+extension.h"

@implementation NSString (extension)

/*!
 *  MD5加密 返回的是纯大写的字母，如要是纯小写，改为%02x即可
 *
 *  @return MD5加密后的字符串
 */
- (NSString *)md5HexDigest
{
    const char *cStr = [self UTF8String];//转换成utf-8
    unsigned char result[16];//开辟一个16字节（128位：md5加密出来就是128位/bit）的空间（一个字节=8字位=8个二进制数）
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result);
    /*
     extern unsigned char *CC_MD5(const void *data, CC_LONG len, unsigned char *md)官方封装好的加密方法
     把cStr字符串转换成了32位的16进制数列（这个过程不可逆转） 存储到了result这个空间中
     */
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
    /*
     x表示十六进制，%02X  意思是不足两位将用0补齐，如果多余两位则不影响
     NSLog("%02X", 0x888);  //888
     NSLog("%02X", 0x4); //04
     */
}

/*!
 *  进行URL编码，将特殊字符进行处理
 *
 *  @return 编码后的URL
 */
- (NSString *)urlEncodedString
{
    NSString * encodedString = (NSString*) CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8 );
    
    return [encodedString autorelease];
}

/*!
 *  进行URL解码，将特殊字符进行处理
 *
 *  @return 解码后的URL
 */
- (NSString *)urlDecodedString
{
    NSString * decodedString = [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]; ;
    return decodedString;
}

/*!
 *  去除NSString中的特殊字符、解码为XML文件
 *
 *  @return XML字符串
 */
- (NSString *)stringByDecodingXMLEntities
{
    NSUInteger myLength = [self length];
    NSUInteger ampIndex = [self rangeOfString:@"&" options:NSLiteralSearch].location;
    
    // Short-circuit if there are no ampersands.
    if (ampIndex == NSNotFound) {
        return self;
    }
    // Make result string with some extra capacity.
    NSMutableString *result = [NSMutableString stringWithCapacity:(myLength * 1.25)];
    // First iteration doesn't need to scan to & since we did that already, but for code simplicity's sake we'll do it again with the scanner.
    NSScanner *scanner = [NSScanner scannerWithString:self];
    [scanner setCharactersToBeSkipped:nil];
    NSCharacterSet *boundaryCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@" \t\n\r;"];
    do {
        // Scan up to the next entity or the end of the string.
        NSString *nonEntityString;
        if ([scanner scanUpToString:@"&" intoString:&nonEntityString]) {
            [result appendString:nonEntityString];
        }
        if ([scanner isAtEnd]) {
            return result;
        }
        // Scan either a HTML or numeric character entity reference.
        if ([scanner scanString:@"&amp;" intoString:NULL])
            [result appendString:@"&"];
        else if ([scanner scanString:@"&apos;" intoString:NULL])
            [result appendString:@"'"];
        else if ([scanner scanString:@"&quot;" intoString:NULL])
            [result appendString:@"\""];
        else if ([scanner scanString:@"&lt;" intoString:NULL])
            [result appendString:@"<"];
        else if ([scanner scanString:@"&gt;" intoString:NULL])
            [result appendString:@">"];
        else if ([scanner scanString:@"&#" intoString:NULL]) {
            BOOL gotNumber;
            unsigned charCode;
            NSString *xForHex = @"";
            
            // Is it hex or decimal?
            if ([scanner scanString:@"x" intoString:&xForHex]) {
                gotNumber = [scanner scanHexInt:&charCode];
            }
            else {
                gotNumber = [scanner scanInt:(int*)&charCode];
            }
            if (gotNumber) {
                [result appendFormat:@"%c", charCode];
                [scanner scanString:@";" intoString:NULL];
            }
            else {
                NSString *unknownEntity = @"";
                [scanner scanUpToCharactersFromSet:boundaryCharacterSet intoString:&unknownEntity];
                [result appendFormat:@"&#%@%@", xForHex, unknownEntity];
                //[scanner scanUpToString:@";" intoString:&unknownEntity];
                //[result appendFormat:@"&#%@%@;", xForHex, unknownEntity];
                NSLog(@"Expected numeric character entity but got &#%@%@;", xForHex, unknownEntity);
            }
        } else {
            NSString *amp;
            [scanner scanString:@"&" intoString:&amp];      //an isolated & symbol
            [result appendString:amp];
        }
    }
    while (![scanner isAtEnd]);
    return result;
}

/*!
 *  去除字符串中的特殊字符：\r,\n和空格
 *
 *  @return 不含特殊字符的字符串
 */
- (NSString *)stringRemoveWhiteAndEnter
{
    NSString *str = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    str = [str stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    return str;
}

/*!
 *  将NSData进行Base64编码  得到一个字符串
 *
 *  @param data 编码的NSData
 *
 *  @return Base64编码后得到的字符串
 */
+ (NSString *)base64Encode:(NSData *)data
{
    NSString *base64String = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64String;
}

/*!
 *  将NSString进行Base64解码  得到一个NSData对象
 *
 *  @param string 解码的字符串
 *
 *  @return Base64解码后得到的NSData
 */
+ (NSData *)base64Decode:(NSString *)string
{
    NSData *base64Data = [[[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters] autorelease];
    return base64Data;
}

/*!
 *  将NSData进行解码得到NSString字符串
 *
 *  @param data 进行解码的NSData
 *
 *  @return 解码后得到的字符串
 */
+ (NSString *)base64DecodeFromNSData:(NSData *)data
{
    NSString *base64Decoded = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] autorelease];
    NSLog(@"Decoded: %@", base64Decoded);
    return base64Decoded;
}

/*!
 *  将NSString从 Latin 编码重新进行UTF8编码
 *
 *  @param string Latin编码的字符串
 *
 *  @return UTF8编码的字符串
 */
+ (NSString *)latinEncode:(NSString*)string
{
    const char *c = [string cStringUsingEncoding:NSISOLatin1StringEncoding];
    return [NSString stringWithCString:c encoding:NSUTF8StringEncoding];
}

- (id)objectAtIndex:(NSUInteger)index
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (id)objectAtIndexedSubscript:(NSUInteger)idx
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (NSUInteger)count
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return 0;
}

- (BOOL)containsObject:(id)anObject
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return NO;
}

- (id)firstObject
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (id)lastObject
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (id)valueForKey:(NSString *)key
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (id)objectForKey:(NSString *)key
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (NSArray *)allKeys
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}

- (NSArray *)allValues
{
#ifdef DEBUG
    NSAssert(NO, @"接口返回非法数据");
#endif
    return nil;
}


@end
