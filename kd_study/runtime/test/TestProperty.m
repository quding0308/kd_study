//
//  TestProperty.m
//  RuntimeApp
//
//  Created by hour on 2018/8/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import "TestProperty.h"

#import <objc/runtime.h>
#import <objc/message.h>

/**
    typedef struct objc_property *objc_property_t;

    typedef struct {
        const char * _Nonnull name;
        const char * _Nonnull value;
    } objc_property_attribute_t;

 */
@interface TestProperty () {
    //
}

@property (nonatomic, strong) NSString *name;

@property (nonatomic, assign) int age;

@end

@implementation TestProperty

+ (void)test {
    Class cls = NSClassFromString(@"TestProperty");
    
    const uint8_t *layout = class_getWeakIvarLayout(cls);

    
    objc_property_t property = class_getProperty(cls, "name");
    [self logProperty:property];
    
    unsigned int count;
    objc_property_t *list = class_copyPropertyList(cls, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t p = list[i];
        [self logProperty:p];
    }
    
    NSLog(@"");
}

+ (void)logProperty:(objc_property_t)property {
    const char *name = property_getName(property);
    const char *attr = property_getAttributes(property);
    NSLog(@"%s, %s", name, attr);
    
    unsigned int attrCount;
    objc_property_attribute_t *attrList = property_copyAttributeList(property, &attrCount);
    for (unsigned int i = 0; i < attrCount; i++) {
        objc_property_attribute_t attr = attrList[i];
        const char *n = attr.name;
        const char *value = attr.value;
        NSLog(@"%s, %s", n, value);
    }
    
    
}

@end
