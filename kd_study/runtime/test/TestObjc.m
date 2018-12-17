//
//  TestObjc.m
//  RuntimeApp
//
//  Created by hour on 2018/7/6.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "TestObjc.h"

#import <objc/runtime.h>
#import <objc/message.h>

/**
 
 
 
 */
@interface TestObjc () {
    NSString *_name;
    
}

@end

@implementation TestObjc

+ (void)test {
    
    TestObjc *obj = [[TestObjc alloc] init];
    
    const char * name = object_getClassName(obj);
    Class cls = object_getClass(obj);
//    object_setClass(obj, cls);
    
    Ivar var = class_getInstanceVariable(cls, "_name");
    
    object_setIvar(obj, var, @"456");
    
    id value = object_getIvar(obj, var);
    
//    object_getIndexedIvars(obj);
//    object_getInstanceVariable()
//    object_copy
    
    
    
    NSLog(@"");
}

@end
