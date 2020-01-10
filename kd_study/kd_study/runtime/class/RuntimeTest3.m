//
//  RuntimeTest3.m
//  kd_study
//
//  Created by hour on 2019/6/24.
//  Copyright © 2019 hour. All rights reserved.
//

#import "RuntimeTest3.h"

#import <UIKit/UIKit.h>

#import <objc/runtime.h>

struct hello {
    uint8_t a;
    uint16_t b;
    uint8_t c;
};

@interface RuntimeTest3 () {
//    int32_t age;
//    int8_t age1;
//    int8_t age2;
//    NSString *firstName;
//    NSString *lastName;
    
    __strong id ivar0;
    __weak id ivar1;
    __weak id ivar2;
}

@end

@implementation RuntimeTest3

- (instancetype)init
{
    self = [super init];
    if (self) {
//        name = @"name";
//        _name = @"_name";
    }
    return self;
}

// 创建一个新的 class 并 初始化一个实例
+ (void)test {
     size_t size1 = sizeof(struct hello);

    RuntimeTest3 *test3 = [[RuntimeTest3 alloc] init];

//    Ivar firstName = class_getInstanceVariable(RuntimeTest3.class, "firstName");
//    ptrdiff_t offfset1 = ivar_getOffset(firstName);
//
//    Ivar lastName = class_getInstanceVariable(RuntimeTest3.class, "lastName");
//    ptrdiff_t offfset2 = ivar_getOffset(lastName);

//    Ivar age = class_getInstanceVariable(RuntimeTest3.class, "age");
//    ptrdiff_t offfset3 = ivar_getOffset(age);

    Ivar age1 = class_getInstanceVariable(RuntimeTest3.class, "age1");
    ptrdiff_t offfset4 = ivar_getOffset(age1);
//
//    Ivar age2 = class_getInstanceVariable(RuntimeTest3.class, "age2");
//    ptrdiff_t offfset5 = ivar_getOffset(age2);

    size_t size =  class_getInstanceSize(RuntimeTest3.class);
//
    NSLog(@"");
//    NSString *name = [test3 valueForKey:@"name"];
    
    /**
     获取值的顺序为：
        getName_method
        name_method
        isName_method
        _getName_method
        _name_method
        _name
        name
     */
    
    Class DQRuntimeClass = objc_allocateClassPair(RuntimeTest3.class, "DQRuntimeClass", 0);
    
    // alignment 传固定值 log2(sizeof(pointer_type))
    BOOL succ = class_addIvar(DQRuntimeClass, "_name", sizeof(NSString *), log2(sizeof(NSString **)), @encode(NSString *));
    
    succ = class_addIvar(DQRuntimeClass, "_age", sizeof(NSUInteger), log2(sizeof(NSUInteger)), @encode(NSUInteger));
    
    objc_registerClassPair(DQRuntimeClass);
    
    
//    id obj = class_createInstance(DQRuntimeClass, 0);
    id obj = [[DQRuntimeClass alloc] init];
    
    [obj setValue:@"Peter" forKey:@"name"];
    id value = [obj valueForKey:@"name"];
//    [obj setValue:@"1" forKey:@"key"];
//    value = [obj valueForKey:@"key"];
    
    Ivar var = class_getInstanceVariable(DQRuntimeClass, "age");
    object_setIvar(obj, var, @(18));
    
    const uint8_t * strongLayout = class_getIvarLayout(RuntimeTest3.class);
    
    const uint8_t * weakLayout = class_getIvarLayout(RuntimeTest3.class);
    
//    id age = [obj valueForKey:@"age"];
    
    NSLog(@"");
}

- (NSString *)getName {
    return @"getName_method";
}

- (NSString *)name {
    return @"name_method";
}

- (NSString *)isName {
    return @"isName_method";
}

- (NSString *)_getName {
    return @"_getName_method";
}

- (NSString *)_name {
    return @"_name_method";
}

- (NSString *)_isName {
    return @"_isName_method";
}
@end
