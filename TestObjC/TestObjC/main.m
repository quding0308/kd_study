//
//  main.m
//  TestObjC
//
//  Created by hour on 2018/11/29.
//  Copyright © 2018 hour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include "test_c.h"

#import "HelloWorld.h"

NSObject *obj1 = nil;

#import <CommonCrypto/CommonCryptor.h>


NSData *aes_cbc_256(NSData *inData,NSData *key,CCOperation coType)
{
    NSData *retData = nil;
    if (!inData || !key) {
        return nil;
    }
    
    if (key.length!=32) {
        return nil;
    }
    
    
    NSUInteger dataLength = [inData length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus;
    
    　　//ecb 模式不需要使用 iv，cbc模式需要，当cbc模式时，如果不传iv，则默任全0
    Byte iv[16] = {0};
    for (int i = 0; i < 16; i++) {
        iv[i] = 1;
    }
    //加密
    if (coType==kCCEncrypt) {
        cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,//使用AES算法
                              kCCOptionPKCS7Padding,
                              key.bytes, kCCKeySizeAES256,
                              iv,
                              [inData bytes], dataLength,
                              buffer, bufferSize,
                              &numBytesEncrypted);
    }
    
    //解密
    else if(coType ==kCCDecrypt)
    {
        cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                              kCCOptionPKCS7Padding,
                              key.bytes, kCCKeySizeAES256,
                              iv,
                              [inData bytes], dataLength,
                              buffer, bufferSize,
                              &numBytesEncrypted);
    }
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    
    return retData;
}

int main(int argc, char * argv[]) {
    @autoreleasepool {

//        NSObject *obj = [NSObject new];
//
//        obj1 = obj;
//
//        NSObject *obj2 = obj;
//        HelloWorld *obj = [[HelloWorld alloc] init];
//        [obj hello1];
        
        Byte bkey[32] = {0};
        for (int i = 0; i < 32; i++) {
            bkey[i] = 12;
        }
        NSData *dkey = [NSData dataWithBytes:bkey length:32];
//        NSLog(@"key:%@",dkey);
//        for (int i = 0; i < 32; i++) {
//            printf("十六进制 --> %X\n", bkey[i]);
//            printf("十进制 --> %d\n", bkey[i]);
//        }
        
//        void * keyStart = NULL;
//        [dkey getBytes:keyStart length: dkey.length];
//        for (int i = 0; i < dkey.length; i++) {
//            printf("十六进制 --> %X\n", keyStart+1);
//            printf("十进制 --> %d\n", keyStart+1);
//        }
//
//        [dkey enumerateByteRangesUsingBlock:^(const void * _Nonnull bytes, NSRange byteRange, BOOL * _Nonnull stop) {
//            printf("十六进制 --> %X\n", bytes);
//            printf("十进制 --> %d\n", bytes);
//        }];
        
        NSString *srcStr = @"RealJt你好";
        NSData *srcData = [srcStr dataUsingEncoding:NSUTF8StringEncoding];
        NSLog(@"src:%@",srcData);
        NSData *encData = aes_cbc_256(srcData, dkey, kCCEncrypt);
        NSLog(@"enc:%@",encData);
        
        NSString *str = [encData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];

        
        NSData *decData = aes_cbc_256(encData, dkey, kCCDecrypt);
//        NSLog(@"dec:%@",decData);
//        NSString *str1 = [[NSString alloc] initWithData:decData encoding:NSUTF8StringEncoding];
        
        if (memcmp(srcData.bytes, decData.bytes, srcData.length)==0) {
            NSLog(@"test PASS");
        }
        else
        {
            NSLog(@"NO PASS");
        }
        
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    
    
}
