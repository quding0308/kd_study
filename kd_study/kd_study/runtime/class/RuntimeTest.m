//
//  RuntimeTest.m
//  kd_study
//
//  Created by quding on 2018/12/15.
//  Copyright © 2018 hour. All rights reserved.
//

#import "RuntimeTest.h"

#import <objc/objc.h>
#import <objc/runtime.h>

#import "MyClass.h"

/*
 一个 instance 占用的内存大小：
    isa指针 8 byte
    变量(需要考虑对齐)

 案例1：一共 48 byte
     int a;
     double b;
     float c;
     NSString *_name;
     NSNumber *_number;

 案例2：一共 40 byte
 int a;
 float c;
 double b;
 NSString *_name;
 NSNumber *_number;
 */

typedef void(^Block)(void);


@interface RuntimeTest () {
    int a;
    double b;
    float c;
    NSString *_name;
    NSNumber *_number;
}

@end

@implementation RuntimeTest

//- (NSUInteger)hash {
//    return 100;
//}

+ (void)initialize {
    NSLog(@"");
}

+ (void)test {
    Class cls = RuntimeTest.class;

    Class superCls = class_getSuperclass(cls);
    BOOL isMeta =  class_isMetaClass(cls);
    size_t instanceSize = class_getInstanceSize(cls);

    int version = class_getVersion(cls);
    class_setVersion(cls, 20);
    int version1 = class_getVersion(cls);

    /// ivars
    Ivar varB = class_getInstanceVariable(cls, "a");
    Ivar varB1 = class_getClassVariable(cls, "b");

    ptrdiff_t offset = ivar_getOffset(varB);

//    char* b_name = varB->ivar_name;

//    BOOL class_addIvar ( Class cls, const char *name, size_t size, uint8_t alignment, const char *types ); //这个只能够向在runtime时创建的类添加成员变量

//    Ivar * class_copyIvarList ( Class cls, unsigned int *outCount ); //必须使用free()来释放这个数组

//    Method helloMethod = class_getInstanceMethod(cls, @selector(@"hello"));
//    Method hello2 = class_getClassMethod(cls, @selector(@"hello"));

    IMP imp = class_getMethodImplementation(cls, @selector(hello));
    imp();

    SEL sel = sel_registerName("hello");


    /// block   block 与 IMP 之间建立联系

//    Block block = ^() {
//        NSLog(@"block");
//    };

    void(^block)(void) = ^() {
        NSLog(@"block");
    };
    IMP impBlock = imp_implementationWithBlock(block);  // 函数指针指向 block



    NSLog(@"");
}

+ (void)test2 {

    MyClass *myClass = [[MyClass alloc] init];
    unsigned int outCount = 0;
    Class cls = myClass.class;
    // 类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"==========================================================");
    // 父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"==========================================================");
    // 是否是元类
    NSLog(@"MyClass is %@ a meta-class", (class_isMetaClass(cls) ? @"" : @"not"));
    NSLog(@"==========================================================");
    Class meta_class = objc_getMetaClass(class_getName(cls));
    NSLog(@"%s's meta-class is %s", class_getName(cls), class_getName(meta_class));
    NSLog(@"==========================================================");
    // 变量实例大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"==========================================================");
    // 成员变量
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    Ivar string = class_getInstanceVariable(cls, "_string");
    if (string != NULL) {
        NSLog(@"instace variable %s", ivar_getName(string));
        NSLog(@"instace variable %s", ivar_getName(string));
    }
    NSLog(@"==========================================================");
    // 属性操作
    objc_property_t * properties = class_copyPropertyList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"property's name: %s", property_getName(property));
    }
    free(properties);
    objc_property_t array = class_getProperty(cls, "array");
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }
    NSLog(@"==========================================================");
    // 方法操作
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);
    Method method1 = class_getInstanceMethod(cls, @selector(method1));
    if (method1 != NULL) {
        NSLog(@"method %s", method_getName(method1));
    }
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));
    if (classMethod != NULL) {
        NSLog(@"class method : %s", method_getName(classMethod));
    }
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, @selector(method3WithArg1:arg2:)) ? @"" : @" not");
    IMP imp = class_getMethodImplementation(cls, @selector(method1));
    imp();
    NSLog(@"==========================================================");
    // 协议
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &outCount);
    Protocol * protocol;
    for (int i = 0; i < outCount; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));
    NSLog(@"==========================================================");
}

+ (void)test3 {
    NSLog(@"test3");
}

- (void)hello {
    NSLog(@"hello a");
}

@end
