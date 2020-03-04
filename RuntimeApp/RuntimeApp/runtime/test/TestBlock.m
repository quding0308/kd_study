//
//  TestBlock.m
//  RuntimeApp
//
//  Created by hour on 2018/8/21.
//  Copyright © 2018 hour. All rights reserved.
//

#import "TestBlock.h"

#import "KDUtil.h"

// 声明一个Block类型
typedef void(^CommonBlock)(void);

@implementation TestBlock

/**
 Block
 block 作为一个变量来出来   声明 和 实现
 
 */
+ (void)test {
    
    
    // declaration block variable
    void (^simpleBlock)(void);
    
    // implemention
    simpleBlock = ^ {
        NSLog(@"111");
    };
    
    
    
    // void 和 void 默认可以删去
    ^ void (void){
        NSLog(@"221");
    }();
    
    simpleBlock();
    
    // will crash
//    simpleBlock = nil;
//    simpleBlock();
    
    CommonBlock (^block)(void) =
    ^ {
        NSLog(@"1");
        
        return ^ {
            
        };
    };
    
    CommonBlock (^block1)(CommonBlock) =
    ^ (CommonBlock block) {
        NSLog(@"1");

        return ^ {
            
        };
    };
    
    
    IMP imp = imp_implementationWithBlock(block1);
    id newBlcok = imp_getBlock(imp);
    
    NSLog(@"");
    
    
    struct Opaque *__attribute((NSObject)) objPtr = @"";
    
    
}

- (void)test {
    
    __block int i = 10;
    i = 11;
    
    // complie时会转化为下面的代码：
    struct _block_byref_i {
        void *isa;
        struct _block_byref_i *forwarding;
        
        int flags;// erfcount
        int size;
        int captured_i;
    } ii = {NULL, &i, 0, sizeof(struct _block_byref_i), 10};
    
    ii.forwarding->captured_i = 11;
}

@end

/// a Block consists of a struct
struct Block_literal_l {
    void *is_a; // initialized to &_NSConcreteStackBlock or &_NSConcreteGlobalBlock
    // _NSConcreteStackBlock、_NSConcreteMallocBlock 以及 _NSConcreteGlobalBlock
    
    int flags;  // 用来区分版本
    int reserved; // NULL
    void (*invoke)(void *, ...);    // 一个函数指针 指向 IMP
    
    struct Block_descriptor_l {
        unsigned long int reserved; // 保留字段 0
        unsigned long int size; // sizeof(struct Block_literal_l)
    } *descriptor;
    
    // 对于auto的var 只是简单地 const copy
    const int x;
    const int y;
    
};

