

//
//  RuntimeDemo.m
//  TimeApp
//
//  Created by hour on 2017/11/13.
//  Copyright © 2017年 hour. All rights reserved.
//

#import "RuntimeDemo.h"

#import <objc/runtime.h>

#import "SuperClass.h"
#import "SubClass.h"

#import "TestLibrary.h"
#import "TestSelector.h"
#import "TestAssociateObj.h"
#import "TestMethod.h"
#import "TestIVar.h"
#import "TestProperty.h"
#import "TestObjc.h"
#import "TestClass.h"
#import "TestBlock.h"

#import "hello.h"

@implementation RuntimeDemo

+ (void)test {
    //
    
    char* buf1 = @encode(NSArray<id>);
    
    Method method = class_getInstanceMethod(RuntimeDemo.class, @selector(methodName));
    char* rvalue = method_copyReturnType(method);
    
    const char *coding = method_getTypeEncoding(method);
    IMP imp = method_getImplementation(method);
    imp();
    
    
//    [TestLibrary test];
    
    [Hello test];
//    NSString *str = [NSMutableString stringWithFormat:@"111"];
    
    //    [TestSelector test];
    //    [TestAssociateObj test];
    //    [TestMethod test];
//    [TestIVar test];
//    [TestProperty test];
//    [TestObjc test];
//    [TestClass test];
    
    
//    RuntimeDemo *demo = [[RuntimeDemo alloc] init];
//    SubClass *sub = [[SubClass alloc] init];
    
//    SEL hello = @selector(hello);
//    [sub performSelector:hello];
//    SEL helloStatic = @selector(helloStatic);
//    [[SubClass class] performSelector:helloStatic];
    
//    [demo aboutClass];
//    [demo runtimeConstruct];
    
//    [demo aboutIvarAndProperty];
}

- (void)testInstance {
    Class class = object_getClass(self);
    const char *class_name = object_getClassName(self);
    
//    object_get
    
    
//    object_copy(self, 0);   // 拷贝obj
//    object_
    
    // 发消息
//    objc_msgSend(target, selector, args)//     发消息
//    objc_msgSendSuper();  给父类发消息
}

- (void)testClass {
    Class class = object_getClass(self);
    
    class_getName([self class]);
    class_getSuperclass([self class]);  // 获取指定类的父类
    
    size_t size = class_getInstanceSize([self class]);    // 获取实例大小
    
    
    
    // methos
    SEL selector = @selector(methodName);
//    Method method = class_getClassMethod(class, selector);    // 获取指定名字的类方法
    Method method = class_getInstanceMethod(class, selector);   // 获取指定名字的实例方法
    IMP implement = class_getMethodImplementation(class, selector); // 获取指定名字的方法实现
    
    class_addMethod(class, selector, implement, 0); // 增加新的方法
    class_replaceMethod(class, selector, implement, 0); // 替换某个方法的实现
    
    /*
    class_respondsToSelector(class, selector); // 是否响应某个方法
    [self respondsToSelector:selector];
    [[self class] instancesRespondToSelector:selector];  // 等价
    class_conformsToProtocol(class, nil); // 是否实现了某个协议
    */
    
    // 属性
    objc_property_t property = class_getProperty(class, "name");
    class_addProperty(class, "name", nil, 0);   // 增加属性
    class_replaceProperty(class, "name", nil, 0); // 替换类的属性
    
    // 变量
    Ivar var1 = class_getClassVariable(class, "ivar_name"); // 类成员
    Ivar var2 = class_getInstanceVariable(class, "ivar_name");   // 实例成员
//    class_addIvar(class, "name", 10, , );  // 增加一个变量
    
    // 类实例操作
    id obj = class_createInstance(class, 0); // 创建一个类的实例
//    objc_destructIns

    objc_allocateClassPair(class, "class_name", 0); // 创建类和元类
    //
    objc_registerClassPair(class);  // 注册某个类到runtime
    objc_disposeClassPair(class);   // 销毁类和对应的元类
    
    
    
    
    
}

- (NSString *)methodName {
    NSLog(@"===");
    return @"";
}

#pragma mark - test
-(void)aboutClass {
    
    // Use "object_getClass()" to get "isa".
    
    SubClass *sub = [[SubClass alloc] init];
    NSLog(@"%@, %@", object_getClass(sub), class_getSuperclass(object_getClass(sub))); // Print: SubClass, SuperClass
    Class cls = objc_getMetaClass("SubClass");
    if (class_isMetaClass(cls)) {
//        class_getSuperclass  获取父类
//        object_getClass 获取元类
        NSLog(@"YES, %@, %@, %@", cls, class_getSuperclass(cls), object_getClass(cls)); // Print: YES, SubClass, SuperClass, NSObject
    }
    else {
        NSLog(@"NO");
    }
    
    
    SuperClass *sup = [[SuperClass alloc] init];
    NSLog(@"%@, %@", object_getClass(sup), class_getSuperclass(object_getClass(sup))); // Print: SuperClass, NSObject
    cls = objc_getMetaClass("SuperClass");
    if (class_isMetaClass(cls)) {
        NSLog(@"YES, %@, %@, %@", cls, class_getSuperclass(cls), object_getClass(cls)); // Print: YES, SuperClass, NSObject, NSObject
    }
    else {
        NSLog(@"NO");
    }
    
    
    cls = objc_getMetaClass("UIView");
    if (class_isMetaClass(cls)) {
        NSLog(@"YES, %@, %@, %@", cls, class_getSuperclass(cls), object_getClass(cls)); // Print: YES, UIView, UIResponder, NSObject
    }
    else {
        NSLog(@"NO");
    }
    
    
    cls = objc_getMetaClass("NSObject");
    if (class_isMetaClass(cls)) {
        NSLog(@"YES, %@, %@, %@", cls, class_getSuperclass(cls), object_getClass(cls)); // Print: YES, NSObject, NSObject, NSObject
    }
    else {
        NSLog(@"NO");
    }
    
}

int32_t testRuntimeMethodIMP(id self, SEL _cmd, NSDictionary *dic) {
    NSLog(@"testRuntimeMethodIMP: %@", dic);
    // Print:
    // testRuntimeMethodIMP: {
    //     a = "para_a";
    //     b = "para_b";
    // }
    
    return 99;
}

- (void)runtimeConstruct {
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    // 1: Create and register class, add method to class.
    Class cls = objc_allocateClassPair(SuperClass.class, "RuntimeSubClass", 0);
    // Method returns: "int32_t"; accepts: "id self", "SEL _cmd", "NSDictionary *dic". So use "i@:@" here.
    class_addMethod(cls, @selector(testRuntimeMethod), (IMP) testRuntimeMethodIMP, "i@:@");
    // You can only register a class once.
    objc_registerClassPair(cls);
    
    
    // 2: Create instance of class, print some info about class and associated meta class.
    id sub = [[cls alloc] init];
    NSLog(@"%@, %@", object_getClass(sub), class_getSuperclass(object_getClass(sub))); // Print: RuntimeSubClass, SuperClass
    Class metaCls = objc_getMetaClass("RuntimeSubClass");
    if (class_isMetaClass(metaCls)) {
        NSLog(@"YES, %@, %@, %@", metaCls, class_getSuperclass(metaCls), object_getClass(metaCls)); // Print: YES, RuntimeSubClass, SuperClass, NSObject
    }
    else {
        NSLog(@"NO");
    }
    
    
    // 3: Methods of class.
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(cls, &outCount);
    for (int32_t i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"%@, %s", NSStringFromSelector(method_getName(method)), method_getTypeEncoding(method));
    }
    // Print: testRuntimeMethod, i@:@
    free(methods);
    
    
    // 4: Call method.
    int32_t result = (int) [sub performSelector:@selector(testRuntimeMethod) withObject:@{@"a":@"para_a", @"b":@"para_b"}];
    NSLog(@"%d", result); // Print: 99
    
    
    // 5: Destory instances and class.
    // Destroy instances of cls class before destroy cls class.
    sub = nil;
    // Do not call this function if instances of the cls class or any subclass exist.
    objc_disposeClassPair(cls);
    
#pragma clang diagnostic pop
    
}


NSString * runtimePropertyGetterIMP(id self, SEL _cmd) {
    Ivar ivar = class_getInstanceVariable([self class], "_runtimeProperty");
    
    return object_getIvar(self, ivar);
}

void runtimePropertySetterIMP(id self, SEL _cmd, NSString *s) {
    Ivar ivar = class_getInstanceVariable([self class], "_runtimeProperty");
    NSString *old = (NSString *) object_getIvar(self, ivar);
    if (![old isEqualToString:s]) {
        object_setIvar(self, ivar, s);
    }
}

- (void)aboutIvarAndProperty {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    // 1: Add property and getter/setter.
    Class cls = objc_allocateClassPair(SuperClass.class, "RuntimePropertySubClass", 0);
    
    BOOL b = class_addIvar(cls, "_runtimeProperty", sizeof(cls), log2(sizeof(cls)), @encode(NSString));
    NSLog(@"%@", b ? @"YES" : @"NO"); // Print: YES
    
    
    // You can only register a class once.
    objc_registerClassPair(cls);
    
    
    // 2: Print all properties.
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    for (int32_t i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSLog(@"%s, %s\n", property_getName(property), property_getAttributes(property));
    }
    // Print:
    // runtimeProperty, T@"NSString",C,N,V_runtimeProperty
    free(properties);
    
    
    // 3: Print all ivars.
    Ivar *ivars = class_copyIvarList(cls, &outCount);
    for (int32_t i = 0; i < outCount; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"%s, %s\n", ivar_getName(ivar), ivar_getTypeEncoding(ivar));
    }
    // Print:
    // _runtimeProperty, {NSString=#}
    free(ivars);
    
    
    // 4: Use runtime property.
    id sub = [[cls alloc] init];
    [sub performSelector:@selector(setRuntimeProperty) withObject:@"It-is-a-runtime-property."];
    NSString *s = [sub performSelector:@selector(runtimeProperty)]; //[sub valueForKey:@"runtimeProperty"];
    NSLog(@"%@", s); // Print: It-is-a-runtime-property.
    
    
    // 5: Clear.
    // Destroy instances of cls class before destroy cls class.
    sub = nil;
    // Do not call this function if instances of the cls class or any subclass exist.
    objc_disposeClassPair(cls);
    
#pragma clang diagnostic pop
}

@end
