//
//  TestCompare.h
//  kd_study
//
//  Created by hour on 2020/1/9.
//  Copyright © 2020 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TestCompare : NSObject

+ (void)test;

@end

NS_ASSUME_NONNULL_END

@interface TestCompareObj1 : NSObject<NSCopying, NSMutableCopying>

@property (nonnull, nonatomic) NSString *first;
@property (nonnull, nonatomic) NSString *second;

@end
