//
//  ArchiveTest.m
//  kd_study
//
//  Created by quding on 2018/10/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import "ArchiveTest.h"

@implementation ArchiveTest

+ (void)test {
    //
    ArchiveTest *obj = [[ArchiveTest alloc] init];
    obj.name = @"234";
    obj.pageCount = 22;

    // 编码
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];

    // 解码
    ArchiveTest* t1 = (ArchiveTest *)[NSKeyedUnarchiver unarchiveObjectWithData:data];

    NSLog(@"");
}

/*
NSCoding 是一个简单的协议，有两个方法： -initWithCoder: 和 encodeWithCoder:。遵循NSCoding协议的类可以被序列化和反序列化，这样可以归档到磁盘上或分发到网络上。
 */
#pragma mark - NSCoding
// 解码 对应于 NSKeyedUnarchiver
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)decoder {
    self.name = [decoder decodeObjectForKey:@"name"];
    self.pageCount = [decoder decodeIntegerForKey:@"pageCount"];

    return self;
}

// 编码 对应于 NSKeyedArchiver
- (void)encodeWithCoder:(nonnull NSCoder *)decoder {
    [decoder encodeObject:self.name forKey:@"name"];
    [decoder encodeInteger:self.pageCount forKey:@"pageCount"];
}


@end
