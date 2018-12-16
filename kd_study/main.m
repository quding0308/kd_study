//
//  main.m
//  kd_study
//
//  Created by hour on 2018/8/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "KDLockTest.h"
#import "RuntimeTest.h"
#import "RuntimeTest2.h"


int main(int argc, char * argv[]) {
    @autoreleasepool {
//        [[[NSObject alloc] init] isKindOfClass:RuntimeTest.class];
//        [RuntimeTest test3];
        [RuntimeTest2 test];

        NSArray *a = [NSMutableArray arrayWithObjects:@"224", @"223", nil];
        NSArray *b = [NSMutableArray arrayWithObjects:@"223", @"224", nil];

        if (a == b) {
            NSLog(@"==");
        }
        if ([a isEqual:b]) {
            NSLog(@"isEqual");
        }

        NSUInteger hash1 = [RuntimeTest hash];

        NSUInteger hash2 = [RuntimeTest hash];

        id obj1 = [[RuntimeTest alloc] init];
        NSUInteger hash3 = [obj1 hash];
        NSUInteger address = (NSUInteger )obj1;

        id obj2 = [[RuntimeTest alloc] init];
        NSUInteger hash4 = [obj2 hash];

        if ([obj1 isEqual:obj2]) {
            NSLog(@"isEqual");
        }

//        [KDLockTest test];
//        [RuntimeTest test];
//        [RuntimeTest test2];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


@implementation NSString (util)

- (BOOL)isEqual:(id)object {
    if (self == object) return YES;

    if (!object || ![object isKindOfClass: [self class]]) return NO;

    return [self isEqualToString:object];
}

@end
