//
//  AppDelegate.m
//  TestObjC
//
//  Created by hour on 2018/11/29.
//  Copyright © 2018 hour. All rights reserved.
//

#import "AppDelegate.h"

#import <CommonCrypto/CommonCryptor.h>
#import "MyNetworkTest.h"

@interface AppDelegate ()

@property (nonatomic, assign) int keySize, blockSize;

@property (nonatomic, strong) MyNetworkTest *mytest;

@end

@implementation AppDelegate

// 加密字符串并返回base64编码字符串
- (NSString *)encryptString:(NSString *)string keyString:(NSString *)keyString iv:(NSData *)iv {
    
    self.keySize = 32;
    self.blockSize = 128;
    
    // 设置秘钥 将keyString转成二进制
    NSData *keyData = [keyString dataUsingEncoding:NSUTF8StringEncoding];
    uint8_t cKey[self.keySize];
    bzero(cKey, sizeof(cKey));
    [keyData getBytes:cKey length:self.keySize];
    
    // 设置iv
    uint8_t cIv[self.blockSize];
    bzero(cIv, self.blockSize);
    int option = 0;
    if (iv) {
        [iv getBytes:cIv length:self.blockSize];
        option = kCCOptionPKCS7Padding; // CBC加密
    } else {
        option = kCCOptionPKCS7Padding | kCCOptionECBMode;  // ECB加密
    }
    
    // 设置输出缓冲区 将原始数据转成二进制，并根据所使用的加密方式设置缓冲区
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + self.blockSize;
    void *buffer = malloc(bufferSize);
    
    // 开始加密
    size_t encryptedSize = 0;
    //加密解密都是它 -- CCCrypt
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt,
                                          kCCAlgorithmAES128,
                                          option,
                                          cKey,
                                          self.keySize,
                                          cIv,
                                          [data bytes],
                                          [data length],
                                          buffer,
                                          bufferSize,
                                          &encryptedSize);
    
    NSData *result = nil;
    if (cryptStatus == kCCSuccess) {
        result = [NSData dataWithBytesNoCopy:buffer length:encryptedSize];
    } else {
        free(buffer);
        NSLog(@"[错误] 加密失败|状态编码: %d", cryptStatus);
    }
    
    return [result base64EncodedStringWithOptions:0];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.mytest = [[MyNetworkTest alloc] init];
    [self.mytest start];
//    NSData *data = [@"0102030405060708" dataUsingEncoding:NSUTF8StringEncoding];
//    NSString *result = [self encryptString:@"hello" keyString:@"616263" iv:data];
    
    BOOL isDoubleLine = true;
    id dict = @{@"isDoubleLine":@(isDoubleLine)};
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
