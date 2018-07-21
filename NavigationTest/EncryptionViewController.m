//
//  EncryptionViewController.m
//  NavigationTest
//
//  Created by 王欣 on 2018/5/31.
//  Copyright © 2018年 王欣. All rights reserved.
//

#import "EncryptionViewController.h"
#import <CommonCrypto/CommonCrypto.h>

@interface EncryptionViewController ()

@end

@implementation EncryptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"加密";
    UIImage * image = [UIImage imageNamed:@"ChatHead"];
    NSData * data  = UIImagePNGRepresentation(image);
    NSData * newdata = [self encryptData:data key:[@"key" dataUsingEncoding:NSUTF8StringEncoding]];
    NSData * encoderData = [self decryptData:newdata key:[@"key" dataUsingEncoding:NSUTF8StringEncoding]];
    
    UIImage *newImage = [[UIImage alloc]initWithData:encoderData];
    NSLog(@"%@",newImage);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/****************************Base64.m类实现文件内容****************************/
-(NSString *)base64EncodedStringWithData:(NSData *)data
{
    //判断是否传入需要加密数据参数
    if ((data == nil) || (data == NULL)) {
        return nil;
    } else if (![data isKindOfClass:[NSData class]]) {
        return nil;
    }
    
    //判断设备系统是否满足条件
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] <= 6.9) {
        return nil;
    }
    
    //使用系统的API进行Base64加密操作
    NSDataBase64EncodingOptions options;
    options = NSDataBase64EncodingEndLineWithLineFeed;
    return [data base64EncodedStringWithOptions:options];
}

- (NSData *)base64DecodeDataWithString:(NSString *)string
{
    //判断是否传入需要加密数据参数
    if ((string == nil) || (string == NULL)) {
        return nil;
    } else if (![string isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    //判断设备系统是否满足条件
    if ([[[UIDevice currentDevice] systemVersion] doubleValue] <= 6.9) {
        return nil;
    }
    
    //使用系统的API进行Base64解密操作
    NSDataBase64DecodingOptions options;
    options = NSDataBase64DecodingIgnoreUnknownCharacters;
    return [[NSData alloc] initWithBase64EncodedString:string options:options];
}



/**
 *  AES128 + ECB + PKCS7
 *  @param data 要加密的原始数据
 *  @param key  加密 key
 *  @return  加密后数据
 */
- (NSData *)encryptData:(NSData *)data key:(NSData *)key
{
    //判断解密的流数据是否存在
    if ((data == nil) || (data == NULL)) {
        return nil;
    } else if (![data isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([data length] <= 0) {
        return nil;
    }
    
    //判断解密的Key是否存在
    if ((key == nil) || (key == NULL)) {
        return nil;
    } else if (![key isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([key length] <= 0) {
        return nil;
    }
    
    //setup key
    NSData *result = nil;
    unsigned char cKey[kCCKeySizeAES128];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:kCCKeySizeAES128];
    
    //setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    //do encrypt
    size_t encryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES128,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
    }
    return result;
}


/**
 *  AES128 + ECB + PKCS7
 *  @param data 要解密的原始数据
 *  @param key  解密 key
 *  @return  解密后数据
 */
- (NSData *)decryptData:(NSData *)data key:(NSData *)key
{
    //判断解密的流数据是否存在
    if ((data == nil) || (data == NULL)) {
        return nil;
    } else if (![data isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([data length] <= 0) {
        return nil;
    }
    
    //判断解密的Key是否存在
    if ((key == nil) || (key == NULL)) {
        return nil;
    } else if (![key isKindOfClass:[NSData class]]) {
        return nil;
    } else if ([key length] <= 0) {
        return nil;
    }
    
    //setup key
    NSData *result = nil;
    unsigned char cKey[kCCKeySizeAES128];
    bzero(cKey, sizeof(cKey));
    [key getBytes:cKey length:kCCKeySizeAES128];
    
    //setup output buffer
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    
    //do decrypt
    size_t decryptedSize = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt,
                                          kCCAlgorithmAES128,
                                          kCCOptionECBMode|kCCOptionPKCS7Padding,
                                          cKey,
                                          kCCKeySizeAES128,
                                          nil,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &decryptedSize);
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:decryptedSize];
    } else {
        free(buffer);
    }
    return result;
}



@end
