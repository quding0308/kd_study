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

#import <math.h>
#import <semaphore.h>

static void *kStaticKey = &kStaticKey;

NSString* (*fp)(void);

NSString *name(void) {
    return ({
        @"221";
    });
}

static NSObject *weakObj;
static id __weak weakObj1;

int main(int argc, char * argv[]) {
    printf("%@", kStaticKey);
    
    NSObject *obj = [[NSObject alloc] init];
    
    weakObj = obj;
    weakObj1 = weakObj;
    NSLog(@"%@", weakObj);
    NSLog(@"=== %@", weakObj1);

    obj = nil;
    weakObj = [[NSObject alloc] init];
    NSLog(@"%@", weakObj);
    NSLog(@"=== %@", weakObj1);

    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
    return 0;
}
