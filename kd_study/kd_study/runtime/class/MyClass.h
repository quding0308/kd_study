//
//  MyClass.h
//  kd_study
//
//  Created by quding on 2018/12/16.
//  Copyright © 2018 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass : NSObject <NSCopying, NSCoding>
@property (nonatomic, strong) NSArray *array;
@property (nonatomic, copy) NSString *string;
- (void)method1;
- (void)method2;
+ (void)classMethod1;
@end
