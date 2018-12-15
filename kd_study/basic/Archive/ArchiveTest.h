//
//  ArchiveTest.h
//  kd_study
//
//  Created by quding on 2018/10/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**

这里主要展示了如何使用：
    NSCoding协议
    NSCoder类
        - NSKeyedArchiver
        - NSKeyedUnarchiver

本地存储还有其他方案:
- plist文件 可以直接转化为 NSDictionary、NSArray
- NSUserDefaults
- NSCoder
- SQLite3
- CoreData

 */
@interface ArchiveTest : NSObject <NSCoding>

+ (void)test;

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSUInteger pageCount;


@end

NS_ASSUME_NONNULL_END
