//
//  SubClass.m
//  TimeApp
//
//  Created by hour on 2017/11/13.
//  Copyright © 2017年 hour. All rights reserved.
//

#import "SubClass.h"

#import <objc/runtime.h>
#import <objc/message.h>


/**
 -[ViewController method]: unrecognized selector sent to instance 0x7fa09b784f40
 Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '-[ViewController method]: unrecognized selector sent to instance 0x7fa09b784f40'

 这段崩溃异常信息实际上是由 NSObject 的 doesNotRecognizeSelector 方法抛出的。不过，我们可以采取一些措施，让我们的程序执行特定的逻辑，而避免程序的崩溃。
 消息转发机制基本上分为三个步骤：
 * 第一步：动态方法解析。
 * 第二步：备用接收者。
 * 第三步：完整转发。

 */
@implementation SubClass

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSObject *obj = nil;
        [obj valueForKey:@""];
        
        
        
        NSString *str = @"hello";
        char *str1 = "hello";
        
        SEL sel1 = sel_registerName("hello");
        SEL sel2 = sel_registerName("hello");
        
        
        
        NSSelectorFromString(@"");

        SEL hello = @selector(forwardInvocation);
        SEL hello1 = @selector(forwardInvocation:);
        
        SEL sel = @selector(helloName1:withName2:withName3:);
        if ([self respondsToSelector:sel]) {
            IMP imp = [self methodForSelector:sel];
            if (imp != 0) {
                id result = ((id(*)(id, id, id))imp)(@"",@"",@"");
            }
        }
        
        [self kd_performSelector:@selector(helloName1:withName2:withName3:) withObject:@"name1" withObject:@"name2" withObject:@"name3"];
        
//        objc_setAssociatedObject(<#id  _Nonnull object#>, <#const void * _Nonnull key#>, <#id  _Nullable value#>, <#objc_AssociationPolicy policy#>)
    
//        [self doesNotRecognizeSelector:<#(SEL)#>];
    }
    return self;
}

//- (void)hello {
//    NSLog(@"");
//}

- (id)kd_performSelector:(SEL)sel withObject:(id)obj1 withObject:(id)obj2 withObject:(id)obj3 {
    if (!sel) [self doesNotRecognizeSelector:sel];
    
    // stret = struct return
//    objc_msgSend_stret
    // fpret = float return
//    objc_msgSend_fpret
    // for some float return types.
//  objc_msgSend_fp2ret
    // return id
//    objc_msgSend
    
    
//    return ((id(*)(id, SEL, id, id, id))objc_msgSend)(self, sel, obj1, obj2, obj3);
    return ((id(*)(id, SEL, id, id, id))objc_msgSend)(self, sel, obj1, obj2, obj3);

}

- (NSString *)helloName1:(NSString *)name1 withName2:(NSString *)name2 withName3:(NSString *)name3 {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    return @"return_value";
}



void dealWithExceptionForUnknownMethod(id self, SEL _cmd) {
    NSLog(@"dealWithExceptionForUnknownMethod %@, %p", self, _cmd); // Print: <ViewController: 0x7ff96be33e60>, 0x1078259fc
}


#pragma mark - 实例方法转发
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *strSelector = NSStringFromSelector(sel);
    if ([strSelector isEqualToString:@"hello"]) {
        // 被截获，并用其他方法处理
//        class_addMethod([self class], sel, (IMP)dealWithExceptionForUnknownMethod, "v@:");
//        return YES;
    }
    
    return [super resolveInstanceMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *strSelector = NSStringFromSelector(aSelector);
    if ([strSelector isEqualToString:@"hello"]) {
        // 被截获，并用其他方法处理
//        class_addMethod(self.class, @selector(hello), (IMP) dealWithExceptionForUnknownMethod, "v@:");
        
//        return [[InvocationDemo alloc] init];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
//    if (!signature) {
        if ([InvocationDemo instancesRespondToSelector:aSelector]) {
            signature = [InvocationDemo instanceMethodSignatureForSelector:aSelector];
//            signature = [InvocationDemo instanceMethodSignatureForSelector:@selector(hello1)];
            
            return signature;
        }
//    }
    
    return signature;
}

//- (void)forwardInvocation:(NSInvocation *)anInvocation {
//    if ([InvocationDemo instancesRespondToSelector:anInvocation.selector]) {
////        [anInvocation invokeWithTarget:[[InvocationDemo alloc] init]];
//    } else {
//        NSLog(@"forwardInvocation");
//    }
//}

#pragma mark - 类方法转发
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSString *strSelector = NSStringFromSelector(sel);
    if ([strSelector isEqualToString:@"helloStatic"]) {
        // 获取 MetaClass
//        Class predicateMetaClass = objc_getMetaClass([NSStringFromClass(self) UTF8String]);
//        // 根据 metaClass 获取方法的实现
//        IMP impletor = class_getMethodImplementation(predicateMetaClass, @selector(proxyMethod));
//        // 获取类方法
//        Method predicateMethod = class_getClassMethod(predicateMetaClass, @selector(proxyMethod));
//        const char *encoding = method_getTypeEncoding(predicateMethod);
//
//        // 动态添加类方法
//        class_addMethod(predicateMetaClass, sel, impletor, encoding);
        
        
//        class_addMethod([self class], sel, (IMP)dealWithExceptionForUnknownMethod, "v@:");
//        return YES;
    }
    
    return [super resolveClassMethod:sel];
}

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    NSString *strSelector = NSStringFromSelector(aSelector);
    if ([strSelector isEqualToString:@"helloStatic"]) {
        // 被截获，并用其他方法处理
//        class_addMethod(self.class, @selector(helloStatic), (IMP) dealWithExceptionForUnknownMethod, "v@:");
        
//        return [[InvocationDemo alloc] init];
//        return [InvocationDemo class];
    }
    
    return [super forwardingTargetForSelector:aSelector];
}

+ (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        if ([InvocationDemo respondsToSelector:aSelector]) {
            //methodSignatureForSelector 可以获取类方法和实例方法的签名
            //instanceMethodSignatureForSelector只能获取实例方法的签名
            signature = [InvocationDemo methodSignatureForSelector:aSelector];
        }
    }
    
    return signature;
}

+ (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([InvocationDemo respondsToSelector:anInvocation.selector]) {
        [anInvocation invokeWithTarget:[InvocationDemo class]];
//        [anInvocation invokeWithTarget:[[InvocationDemo alloc] init]];

    } else {
        NSLog(@"");
    }
}



@end


@implementation InvocationDemo

- (void)hello {
    NSLog(@"hello");
}

- (void)hello1 {
    NSLog(@"hello1");
}

// 类方法可以转到执行实例方法
- (void)helloStatic {
    NSLog(@"helloStatic instance");
}

+ (void)helloStatic {
    NSLog(@"helloStatic");
}

@end
