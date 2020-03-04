//
//  Person.m
//  objc-test
//
//  Created by hour on 2020/1/7.
//

#import "Person.h"
#import <objc/runtime.h>
#import <objc/message.h>

@interface Guard: NSObject

//-(void)sayNihao;

@end


@implementation Guard

// 给自己一个机会 重新添加 method，然后防止闪退
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    Class cls = [self class];
    
    IMP imp = imp_implementationWithBlock(^(){
        NSLog(@"=== 备用");
    });
    class_addMethod(cls, sel, imp, "v16@0:8");
    
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return YES;
}

@end


@implementation Person

- (void)testSelector {
    SEL selector1 = NSSelectorFromString(@"testSelector");
    NSString *name = NSStringFromSelector(selector1);
    SEL selector = @selector(testSelector);

    NSLog(@"");
    
}

- (void)sayHello {
    NSLog(@"=== sayHello");
}

- (void)sayGoodBye:(NSString *)name {
    NSLog(@"=== bye %@", name);
}

- (NSString *)getName {
    return @"Peter";
}

- (Person *)getNewPerson {
    return [[Person alloc] init];
}

- (void)lala:(NSArray<NSString *> *)array {
    
}

- (struct test_t)getStruct {
   struct test_t test = {
        "dd",
    };
    
    return test;
}

// 给自己一个机会 重新添加 method，然后防止闪退
//+ (BOOL)resolveInstanceMethod:(SEL)sel {
//    Class cls = [self class];
//
//    IMP imp = imp_implementationWithBlock(^(){
//        NSLog(@"=== 备用");
//    });
//    class_addMethod(cls, sel, imp, "v16@0:8");
//
//    return YES;
//}

//- (id)forwardingTargetForSelector:(SEL)aSelector {
//    return [[Guard alloc] init];
//}


- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation %@", anInvocation.methodSignature);
    NSLog(@"forwardInvocation %lu", (unsigned long)anInvocation.methodSignature.numberOfArguments);

    NSLog(@"forwardInvocation %@", anInvocation.target);
    NSLog(@"forwardInvocation %@", NSStringFromSelector(anInvocation.selector));
    anInvocation.selector = NSSelectorFromString(@"sayHello");
    NSLog(@"forwardInvocation %@", NSStringFromSelector(anInvocation.selector));

    [anInvocation invokeWithTarget:[[Man alloc] init]];
//    [anInvocation invokeWithTarget:[[Guard alloc] init]];
//    [anInvocation invokeWithTarget:self];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
//    NSMethodSignature *signature = [Guard instanceMethodSignatureForSelector:aSelector];
    NSMethodSignature *signature = [Man instanceMethodSignatureForSelector:@selector(sayHello)];
    NSLog(@"forwardInvocation %lu", (unsigned long)signature.numberOfArguments);

    return signature;
    
//    return [super methodSignatureForSelector:aSelector];
}

@end

@implementation Person (Extension2)

- (void)sayHello {
    NSLog(@"=== Extension2 sayHello");
}

@end



@implementation Person (Extension1)

- (void)sayHello {
    NSLog(@"=== Extension1 sayHello");
}

@end


@implementation Man

- (void)sayHello {
    NSLog(@"=== Man sayHello");
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"forwardInvocation %@", anInvocation.methodSignature);
    NSLog(@"forwardInvocation %@", NSStringFromSelector(anInvocation.selector));
    
    //    [anInvocation invokeWithTarget:[[Guard alloc] init]];
    //    [anInvocation invokeWithTarget:self];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    //    NSMethodSignature *signature = [Guard instanceMethodSignatureForSelector:aSelector];
    NSMethodSignature *signature = [Man instanceMethodSignatureForSelector:@selector(sayHello)];
    
    return signature;
    
    //    return [super methodSignatureForSelector:aSelector];
}


@end

