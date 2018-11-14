//
//  CopyTest.m
//  kd_study
//
//  Created by quding on 2018/10/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import "CopyTest.h"

@interface CopyTest () 

@end

@implementation CopyTest

+ (void)test {

    // =======
    NSArray *arr = @[@"11", @"22", @"33"];
    NSDictionary *dict = @{@"name" : @"Peter"};


    [arr copy];
    // 等价于
    [arr copyWithZone:nil];

    [arr mutableCopy];
    // 等价于
    [arr mutableCopyWithZone:nil];

    // 浅拷贝=========
    NSArray *arr1 = @[@"11", @"22", @"33"];


    // 元素不拷贝，只是 每个元素对象的引用计数+1
    NSArray *t1 = [[NSArray alloc] initWithArray:arr copyItems:NO];
    // 等价于 (只会调用NSArray 的 copyWithZone:，元素是指针拷贝)
    NSArray *t2 = [arr1 copyWithZone:nil];

    // 深拷贝==========
    // copyItems:YES 则数组中的每个元素都会收到 copyWithZone: 的消息，如果没有遵循NSCopying，则会报错
    [[NSArray alloc] initWithArray:arr copyItems:YES];
    [[NSDictionary alloc] initWithDictionary:dict copyItems:YES];

    // archive unarchive 时，也是深拷贝 需要每个object 都支持 NSCopying
    // 归档 archive
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:arr];
    // 解档 unarchive
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];


    NSLog(@"");
}

// NSCopying
- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    return self;
}


// NSMutableCopying
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return self;
}



@end
