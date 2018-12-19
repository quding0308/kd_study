//
//  main.m
//  UIWebViewDemo
//
//  Created by hour on 2018/4/6.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "hello.h"

#import "TestTaggedPointer.h"

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
//#import "KDUtil.h"

@interface Hello () {
    NSObject *obj;
}

//@property (atomic, assign) int age11;
@property (atomic, strong) NSString *name11;
@property (atomic, strong) NSObject *obj11;

@property (atomic, copy) NSObject *obj22;

@property (strong) NSObject *obj3333;

@property (strong, nonatomic, readonly) NSMutableArray *arrMutable;

@end


@implementation Hello

@synthesize obj11 = obj;

+ (void)test {
    Hello *obj = [[Hello alloc] init];
    
    [obj setName11:@"111"];
    
    obj.name11 = @"22";
    
//    [KDUtil kd_logMethod:[Hello class]];
    
    NSLog(@"");
}

- (void)nihao {
    @synchronized (self) {
        NSLog(@"111");
    }
}

- (void)setName11:(NSString *)lastName {
    objc_setAssociatedObject(self, @selector(lastName), lastName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end

@interface Hello (Addition)

@property (nonatomic, strong) NSString *lastName;

@end

@implementation Hello (Addition)

//- (void)setLastName:(NSString *)lastName {
//    objc_setAssociatedObject(self, @selector(lastName), lastName, OBJC_ASSOCIATION_COPY_NONATOMIC);
//}

//- (NSString *)lastName {
//    return objc_getAssociatedObject(self, @selector(lastName));
//}

- (void)setName11:(NSString *)lastName {
    objc_setAssociatedObject(self, @selector(lastName), lastName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)name11 {
    return objc_getAssociatedObject(self, @selector(lastName));
}


@end


//static void _I_Hello_setObj22_(Hello * self, SEL _cmd, NSObject *obj22) {
//    (*(NSObject **)((char *)self + OBJC_IVAR_$_Hello$_obj22)) = obj22;
//}


//static void _I_Hello_nihao(Hello * self, SEL _cmd) {
//    {   id _rethrow = 0;
//        id _sync_obj = (id)self;
//        objc_sync_enter(_sync_obj);
//
//        struct _SYNC_EXIT { _SYNC_EXIT(id arg) : sync_exit(arg) {}
//            ~_SYNC_EXIT() {objc_sync_exit(sync_exit);}
//            id sync_exit;
//        } _sync_exit(_sync_obj);
//
//        NSLog((NSString *)&__NSConstantStringImpl__var_folders_nq_dy5h_t3n3fn3zb4s_r4zb06r0000gn_T_hello_782fdf_mi_0);
//
//        { struct _FIN { _FIN(id reth) : rethrow(reth) {}
//            ~_FIN() { if (rethrow) objc_exception_throw(rethrow); }
//            id rethrow;
//        } _fin_force_rethow(_rethrow);}
//    }
//
//}
