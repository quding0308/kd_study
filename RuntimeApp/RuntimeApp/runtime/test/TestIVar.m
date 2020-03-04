//
//  TestIVar.m
//  RuntimeApp
//
//  Created by hour on 2018/8/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import "TestIVar.h"

#import <objc/runtime.h>
#import <objc/message.h>

/**
 struct objc_ivar_list *ivars;// 变量列表
 
 typedef struct objc_ivar *Ivar;
 
 struct objc_ivar {
     char *ivar_name;   // 变量名
     char *ivar_type;   // 变量类型
     int ivar_offset;   // 偏移量，对成员变量寻址时使用
 }
 
 */
@interface TestIVar () {
    
    NSString *_name;
    
//    static NSString *_staticName;
}

@end

@implementation TestIVar

+ (void)test {
    Class cls = NSClassFromString(@"TestIVar");
    
    Ivar classVar = class_getClassVariable(cls, "_staticName");
    Ivar instanceVar = class_getInstanceVariable(cls, "_name");

    const char *name = ivar_getName(instanceVar);
    const char *type = ivar_getTypeEncoding(instanceVar);
    ptrdiff_t offset = ivar_getOffset(instanceVar);
    
    NSLog(@"");
}

@end
