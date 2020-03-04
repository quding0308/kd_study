//
//  TestClass.m
//  RuntimeApp
//
//  Created by hour on 2018/7/6.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "TestClass.h"

#import <objc/runtime.h>
#import <objc/message.h>

#import "KDUtil.h"

/**
 
 */
@implementation TestClass

+ (void)test {
//    Class cls = NSClassFromString(@"TestClass");
    [self createClass];
    
    SEL sel_hello = @selector(hello);
//    objc_msgSend(self, sel_hello );
//    ((void(*)(objc_object *, SEL))objc_msgSend)(this, SEL_dealloc);
    
    NSLog(@"");
}

+ (void)createClass {
    Class cls = objc_allocateClassPair([NSObject class], "CreateClass", 0);
    
//    char *c = @encode(NSString);
    
//    [self addMethod:cls];
    
    [self addIvar:cls];
    
    objc_registerClassPair(cls);
        
    [self addProperty:cls];
    
    [KDUtil kd_logIvar:cls];
    
    size_t size = class_getInstanceSize(cls);
    
    // allocating memory for the class in the default malloc memory zone
    id obj = class_createInstance(cls, 0);
    
    Ivar var = class_getInstanceVariable(cls, "age");
    object_setIvar(obj, var, @12);
    id age = object_getIvar(obj, var);
    
//    id v1 = [obj valueForKey:@"age"];
//    id v2 = [obj valueForKey:@"_runtimeProperty"];
//    [obj setValue:@"22" forKey:@"_runtimeProperty"];
//    id v3 = [obj valueForKey:@"_runtimeProperty"];

    [KDUtil kd_logObjSize:obj];
    NSLog(@"");
}

+ (void)addIvar:(Class)cls {
    BOOL succ = NO;
    succ = class_addIvar(cls, "age", 4, 0, "i");
    succ = class_addIvar(cls, "name", 8, 0, "{NSString=#}");
    succ = class_addIvar(cls, "grade", 8, 0, "{NSString=#}");
    
    //    [KDUtil kd_logIvar:cls];
}

+ (void)addProperty:(Class)cls {
    objc_property_attribute_t type = {"T", "@\"NSString\""};
    objc_property_attribute_t ownership = {"C", ""}; // C = copy
    objc_property_attribute_t isAtomic = {"N", ""}; // N = nonatomic
    objc_property_attribute_t backingivar  = {"V", "_runtimeProperty"};
    objc_property_attribute_t attrs[] = {type, ownership, isAtomic, backingivar};
    BOOL succ = class_addProperty(cls, "runtimeProperty", attrs, 4);
    
    [KDUtil kd_logProperties:cls];
    NSLog(@"");
}

+ (void)addMethod:(Class)cls {
//    class_addMethod(cls, @selector(runtimeProperty), (IMP) runtimePropertyGetterIMP, "@@:");
//    class_addMethod(cls, @selector(setRuntimeProperty), (IMP) runtimePropertySetterIMP, "v@:@");
}

- (void)hello {
    if (!self) {
//        self = [super init];
        NSLog(@"");
    }
    
    
    
    
}


@end
