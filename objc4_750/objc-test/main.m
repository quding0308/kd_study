//
//  main.m
//  objc-test
//
//  Created by GongCF on 2018/12/16.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>
#import "HelloObject.h"
#import "Person.h"
#import "TestCompare.h"

//void testImages1();
//void testImages2();


void testImages1() {
    unsigned int outCount = 0;
    const char** images = objc_copyImageNames(&outCount);
    
    for (unsigned i=0; i<outCount; i++) {
        const char *tmpName = *(images+i);
        printf("%s\n", tmpName);
    }
}

void testImages2() {
    const char* image = class_getImageName(NSClassFromString(@"HelloObject"));
    unsigned int outCount = 0;
    const char** classes = objc_copyClassNamesForImage(image, &outCount);
    
    for (unsigned int i=0; i<outCount; i++) {
        const char *tmpName = *(classes+i);
        printf("%s\n", tmpName);
    }
}

void testClass() {
    id helloObj = objc_getClass("HelloObject");
    id obj = [[HelloObject alloc] init];
    Class cls = [obj class];

    id clsObj = objc_getClass("NSObject");
    Class newClass = objc_allocateClassPair(clsObj, "NewClass", 0);
    objc_registerClassPair(newClass);
    id cls1 = objc_getClass("NewClass");
    
    Class newClass1 = objc_duplicateClass(clsObj, "NewClass", 0);
    objc_registerClassPair(newClass);

    id cls2 = objc_getClass("NewClass");
    

    
    id newObject = [[newClass alloc] init];
    
    id obj1 = class_createInstance(newClass, 0);
    
    
    
    NSLog(@"%@",newObject);
    
}

void testSelectorMethod() {
//    [[[Person alloc] init] testSelector];
    [[[Person alloc] init] sayHello];
    
    SEL selector = sel_registerName("sayHello");
    
    IMP imp1 = imp_implementationWithBlock(^(){
        NSLog(@"");
    });
    
//    Class cls = objc_getClass("HelloObject");
    Class cls = objc_getClass("Person");
    
    Method helloMethod = NULL;
    unsigned int outCount = 0;
    Method *start = class_copyMethodList(cls, &outCount);
    for (unsigned int i=0; i<outCount; i++) {
        Method method = *(start+i);
        
        SEL selector = method_getName(method);
        IMP imp = method_getImplementation(method);
        const char *types = method_getTypeEncoding(method);
        struct objc_method_description *desc = method_getDescription(method);
        
        NSLog(@"%@", NSStringFromSelector(selector));
        NSLog(@"%s", types);
        
        if (strcmp("sayHello", NSStringFromSelector(selector).UTF8String) == 0) {
            helloMethod = method;
        }
    }
    
    IMP imp = method_getImplementation(helloMethod);
    id block = imp_getBlock(imp);
    
    Person *p = [[Person alloc] init];
    ((void(*)(id,Method))method_invoke)(p, helloMethod);

    Method byeMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"sayGoodBye:"));
    ((void(*)(id,Method,id))method_invoke)(p, byeMethod, @"Peter");
    
    Method getNameMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"getName"));
    id result = ((NSString* (*)(id,Method))method_invoke)(p, getNameMethod);
    
    Method getNewPersonMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"getNewPerson"));
    id result1 = ((NSString* (*)(id,Method))method_invoke)(p, getNewPersonMethod);
    
    
//    Method getStructMethod = class_getInstanceMethod(cls, NSSelectorFromString(@"getStruct"));
//    id result2 = (((struct test_t)(*)(id,Method))method_invoke_stret)(p, getStructMethod);
    
    
    
    
    Method methodHello = class_getInstanceMethod(cls, NSSelectorFromString(@"sayHello"));
    Method methodBye = class_getInstanceMethod(cls, NSSelectorFromString(@"sayGoodbye"));
    IMP impNew = imp_implementationWithBlock(^() {
        NSLog(@"=== 123456");
    });
//    method_setImplementation(method, impNew);
//    method_exchangeImplementations(methodHello, methodBye);
    
    [[[HelloObject alloc] init] sayHello];
}

void testIvar() {
    // ivar
    Class cls = objc_getClass("HelloObject");

    unsigned int outCount = 0;
    Ivar *varFirst = class_copyIvarList(cls, &outCount);
    for (unsigned int i=0; i<outCount; i++) {
        Ivar tmp = *(varFirst+i);
        
        const char *name = ivar_getName(tmp);
        const char *types = ivar_getTypeEncoding(tmp);
        ptrdiff_t offset = ivar_getOffset(tmp);
        
        NSLog(@"");
    }
    
    
    Ivar var = class_getClassVariable(cls, "_firstName");
    
    const char *name = ivar_getName(var);
    const char *types = ivar_getTypeEncoding(var);
    ptrdiff_t offset = ivar_getOffset(var);
    
    // property
    
    
//    class_addIvar(<#Class  _Nullable __unsafe_unretained cls#>, <#const char * _Nonnull name#>, <#size_t size#>, <#uint8_t alignment#>, <#const char * _Nullable types#>)
    
    
    
    NSLog(@"");
}

void testProperty() {
//    Class cls = objc_getClass("HelloObject");
    Class cls = objc_getClass("Person");
    
    unsigned int outCount = 0;
    objc_property_t *propertyHead = class_copyPropertyList(cls, &outCount);
    for (unsigned int i=0; i<outCount; i++) {
        objc_property_t tmp = *(propertyHead+i);
        
        const char *name = property_getName(tmp);
        const char *types = property_getAttributes(tmp);
        
        NSLog(@"%s, %s", name, types);
    }
    
    NSLog(@"");
}

void testProtocol() {
    Protocol *protocol = objc_getProtocol("Protocol1");
    
//    protocol_getName(<#Protocol * _Nonnull proto#>)
    
    HelloObject *obj = [[HelloObject alloc] init];
    obj.protocolName = @"1234";
    [obj speak];
    
    NSLog(@"");
}

void testMsgSend() {
    //    Class cls = objc_getClass("HelloObject");
    id obj = [[Person alloc] init];
    
    [obj performSelectorOnMainThread:NSSelectorFromString(@"sayHello") withObject:nil waitUntilDone:YES];
    
    
    ((void(*)(id, SEL))objc_msgSend)(obj, NSSelectorFromString(@"sayHello"));
    ((void(*)(id, SEL, id))objc_msgSend)(obj, NSSelectorFromString(@"sayGoodBye:"), @"Peter");
    id result = ((id(*)(id, SEL))objc_msgSend)(obj, NSSelectorFromString(@"getName"));
    
    // 消息转发
//    ((void(*)(id, SEL))objc_msgSend)(obj, NSSelectorFromString(@"sayNihao"));
    ((void(*)(id, SEL, id))objc_msgSend)(obj, NSSelectorFromString(@"sayNihao:"), @"123");
    ((id(*)(id, SEL, id))objc_msgSend)(obj, NSSelectorFromString(@"sayNihao:"), @"123");

    
    
    
    NSLog(@"");
}

void testCopy() {
    TestCompareObj1* obj1 = [[TestCompareObj1 alloc] init];
    obj1.first = @"first";
    obj1.second = @"second";
    
    TestCompareObj1 *obj2 = obj1.copy;
    TestCompareObj1 *obj3 = obj1.mutableCopy;
    
    obj1.first = @"123";
    
    NSLog(@"");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
//        const char* name = class_getName(newClass);
//        const char* sel_name = sel_getName();

//        const char *imgName = class_getImageName(newClass);
        
        
//        testClass();
//        testImages2();
//        testIvar();
//        testProperty();
//        testSelectorMethod();
//        testProtocol();
        testMsgSend();
//        testCopy();
    }
    return 0;
}
