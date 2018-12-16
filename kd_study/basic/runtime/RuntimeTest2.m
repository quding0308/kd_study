//
//  RuntimeTest2.m
//  kd_study
//
//  Created by quding on 2018/12/16.
//  Copyright © 2018 hour. All rights reserved.
//

#import "RuntimeTest2.h"

#import "MyClass.h"

#import <objc/objc.h>
#import <objc/runtime.h>

@implementation NSObject (Sark)

- (void)foo {
    NSLog(@"IMP: -[NSObject(Sark) foo]");
}

@end

@implementation RuntimeTest2

+ (void)test {
//    Class cls = [NSObject class];
//    Class meta_class1 = objc_getMetaClass(class_getName(cls));
//    Class super1 = class_getSuperclass(meta_class1);

//    Class meta_class2 = objc_getMetaClass(class_getName(super1));
//    Class super2 = class_getSuperclass(super1);

//    Class meta_class3 = objc_getMetaClass(class_getName(super1));
//    Class super3 = class_getSuperclass(meta_class2);

    Class meta_class1 = objc_getMetaClass(class_getName([MyClass class]));

    unsigned int outCount = 0;
    Method *methods = class_copyMethodList(meta_class1, &outCount);
    for (int i = 0; i < outCount; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %s", method_getName(method));
    }
    free(methods);


//    [NSObject foo];
//    [[NSObject new] foo];
}

@end

