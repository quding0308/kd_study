//
//  TestAssociateObj.m
//  RuntimeApp
//
//  Created by hour on 2018/8/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import "TestAssociateObj.h"
#import <objc/runtime.h>

@interface TestAssociateObj () {

    NSObject *obj;
}

//@property (atomic, assign) int age11;
@property (atomic, strong) NSString *name11;
@property (atomic, strong) NSObject *obj11;
@property NSObject *obj22;

@end


@implementation TestAssociateObj

@synthesize obj11 = obj;

+ (void)test {
    
    TestAssociateObj *obj = [[TestAssociateObj alloc] init];
    
    NSString *name = obj.lastName;
    obj.lastName = @"Peter";
    
}

- (void)removeAssociatedObj {
    objc_removeAssociatedObjects(self);
}

@end


@implementation TestAssociateObj (Extension)

- (void)setLastName:(NSString *)lastName {
    objc_setAssociatedObject(self, @selector(lastName), lastName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)lastName {
    return objc_getAssociatedObject(self, @selector(lastName));
}

@end
