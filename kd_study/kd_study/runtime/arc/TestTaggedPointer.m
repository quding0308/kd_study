//
//  TestTaggedPointer.m
//  RuntimeApp
//
//  Created by hour on 2018/9/8.
//  Copyright © 2018 hour. All rights reserved.
//

#import "TestTaggedPointer.h"

@interface TestTaggedPointer () {
    NSNumber *_number;
}

@end

@implementation TestTaggedPointer

+ (void)test {
    TestTaggedPointer *obj = [[TestTaggedPointer alloc] init];
    [obj hello];
}

- (void)hello {
    int a = 1 << 63;
    int b = a >> 1;
    
    
    
    NSNumber *number1 = @1;
    NSNumber *number2 = @2;
    NSNumber *number3 = @3;
    NSNumber *number4 = number3;
    NSNumber *numberFFFF = @(0xFFFF);
    
    _number = number3;
    
    NSNumber *numberLager = @(MAXFLOAT);
    
    NSLog(@"number1 pointer is %p", number1);
    NSLog(@"number2 pointer is %p", number2);
    NSLog(@"number3 pointer is %p", number3);
    NSLog(@"ffff pointer is %p", numberFFFF);
    NSLog(@"numberLager pointer is %p", numberLager);
}

@end
