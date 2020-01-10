//
//  MyNetworkTest.m
//  TestObjC
//
//  Created by hour on 2019/9/6.
//  Copyright © 2019 hour. All rights reserved.
//

#import "MyNetworkTest.h"

#import <AFNetworking/AFNetworking.h>

@interface MyNetworkTest () <NSURLSessionDataDelegate>

@property (nonatomic, strong) NSURLSession *urlSession;

@end

@implementation MyNetworkTest

- (void)start {
//    NSURL *url = [NSURL URLWithString:@"https://www.jianshu.com/p/4b5d2d47833d"];
//    NSURL *url = [NSURL URLWithString:@"https://expired.badssl.com/"];
//    NSURL *url = [NSURL URLWithString:@"https://untrusted-root.badssl.com/"];
    NSURL *url = [NSURL URLWithString:@"https://blog.quding0308.com/"];
    
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
    
    NSSet *certificates = [AFSecurityPolicy certificatesInBundle:[NSBundle mainBundle]];
    [policy setPinnedCertificates:certificates];
    
    
    NSURLSessionDataTask *task = [self.urlSession dataTaskWithURL:url];
    [task resume];
}

- (NSURLSession *)urlSession {
    if (_urlSession == nil) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        _urlSession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:NSOperationQueue.mainQueue];
    }
    return _urlSession;
}

#pragma mark - NSURLSessionTaskDelegate & NSURLSessionDataDelegate
// https 证书校验
- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler {
    NSLog(@"=== session didReceiveChallenge");
    NSLog(@"%@", challenge.protectionSpace.authenticationMethod);
    
    // 1.从服务器返回的受保护空间中拿到证书的类型
    // 2.判断服务器返回的证书是否是服务器信任的
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSLog(@"是服务器信任的证书");
        // 3.根据服务器返回的受保护空间创建一个证书
        //         void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *)
        //         代理方法的completionHandler block接收两个参数:
        //         第一个参数: 代表如何处理证书
        //         第二个参数: 代表需要处理哪个证书
        //创建证书
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 4.证书
        completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
//        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
        
    } else {
        // 默认处理 允许 NSURLSession 使用不安全的 SSL 连接
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    [self URLSession:session didReceiveChallenge:challenge completionHandler:completionHandler];
}

// 重定向回调
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
willPerformHTTPRedirection:(NSHTTPURLResponse *)response
        newRequest:(NSURLRequest *)request
 completionHandler:(void (^)(NSURLRequest * _Nullable))completionHandler {
    NSLog(@"=== willPerformHTTPRedirection");
}

// 接收到响应
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
didReceiveResponse:(NSURLResponse *)response
 completionHandler:(void (^)(NSURLSessionResponseDisposition disposition))completionHandler {
    NSLog(@"=== didReceiveResponse");
    
    completionHandler(NSURLSessionResponseAllow);
}

// 接收到返回的数据
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
    didReceiveData:(NSData *)data {
    NSLog(@"=== didReceiveData");
}

// 本地缓存(当 didReceiveData 调用完成后，如果本地做缓存，则会调用)
- (void)URLSession:(NSURLSession *)session
          dataTask:(NSURLSessionDataTask *)dataTask
 willCacheResponse:(NSCachedURLResponse *)proposedResponse
 completionHandler:(void (^)(NSCachedURLResponse * _Nullable cachedResponse))completionHandler {
    NSLog(@"=== willCacheResponse");
    completionHandler(proposedResponse);
}

// 请求完成
- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error {
    NSLog(@"=== didCompleteWithError");
}

@end
