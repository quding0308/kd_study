//
//  TestMethod.m
//  RuntimeApp
//
//  Created by hour on 2018/7/4.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "TestMethod.h"

#import <objc/runtime.h>
#import <objc/message.h>

/**
 // represent a method in a class definition
 typedef struct objc_method *Method;
 
 // 函数指针
 typedef id (*IMP)(id, SEL, ...);
 
 
 
 
 */

void hello_new() {
    NSLog(@"hello_new");
}

@implementation TestMethod

+ (void)test {
    Class cls = NSClassFromString(@"TestMethod");
    SEL selector = @selector(hello);
//    SEL selector = @selector(hello1:);
    Method m = class_getInstanceMethod(cls, selector);
    
    SEL sel = method_getName(m);
    const char *methodName = sel_getName(sel);
    
    IMP imp = method_getImplementation(m);
    
    
    //    "v16@0:8"
    //    "v24@0:8@16"
    const char *typeEncoding = method_getTypeEncoding(m);
    const char *returnType = method_copyReturnType(m);
    
    unsigned int argsCount =  method_getNumberOfArguments(m);
    for (unsigned int i = 0; i < argsCount; i++) {
        const char *argType = method_copyArgumentType(m, 0);
        NSLog(@"%s", argType);
    }
    
    /*
     struct objc_method_description {
         SEL _Nullable name;
         char * _Nullable types;
     };
    */
    struct objc_method_description *des = method_getDescription(m);
    
    
    /// set or exchange
//    method_setImplementation(m, hello_new);
    
    
    
    
    /// invoke call the IMP
    //   id returnValue = method_invoke();
    //    method_invoke(obj, m, "dd");
    
    SEL selector2 = @selector(hello2);
    Method m2 = class_getInstanceMethod(cls, selector2);
    method_exchangeImplementations(m, m2);
    TestMethod *obj = [[TestMethod alloc] init];
    [obj hello];
    [obj hello2];
    
    method_setImplementation(m, class_getMethodImplementation(cls, @selector(helloPeter)));
    TestMethod *obj1 = [[TestMethod alloc] init];
    [obj1 hello];
    [obj1 hello2];
    
//    method_exchangeImplementations(m, m2);
//    TestMethod *obj = [[TestMethod alloc] init];
//    [obj hello];
//    [obj hello2];
    
//    class_replaceMethod([self class], @selector(hello), <#IMP  _Nonnull imp#>, nil)
    
    unsigned int methodCount;
    Method *list = class_copyMethodList([self class], &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = list[i];

        SEL name = method_getName(method);
        IMP imp = method_getImplementation(method);
        unsigned int num = method_getNumberOfArguments(method);

        NSLog(@"");
    }
    
    NSLog(@"");
}



- (void)hello {
    NSLog(@"hello");
}

- (void)hello2 {
    NSLog(@"hello2");
}

- (void)helloPeter {
    NSLog(@"Peter");
}

- (void)hello1:(NSString *)name {
    NSLog(@"hello1");
    
//    return 0;
}

@end
