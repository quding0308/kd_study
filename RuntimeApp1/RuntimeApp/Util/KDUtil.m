//
//  KDUtil.m
//  RuntimeApp
//
//  Created by hour on 2018/8/21.
//  Copyright © 2018 hour. All rights reserved.
//

#import "KDUtil.h"


#import <malloc/malloc.h>

@implementation KDUtil

+ (void)kd_logObjSize:(id)obj {
    NSLog(@"Size of %@: %zd", NSStringFromClass([obj class]), malloc_size((__bridge const void *) obj));
}

+ (void)kd_logDictSize:(NSDictionary *)dict {
    NSArray *myArray = [dict allValues];
    id obj = nil;
    int totalSize = 0;
    for(obj in myArray)
    {
        totalSize += malloc_size((__bridge const void *) obj);
    }
    
    NSLog(@"Size of Dictionary: %i", totalSize);
}

+ (void)kd_logIvar:(Class)cls {
    unsigned int count = 0;
    
    Ivar *ivars = class_copyIvarList(cls, &count);
    for (int32_t i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"Ivar name: %s, typeEncode: %s, offset: %td\n", ivar_getName(ivar), ivar_getTypeEncoding(ivar), ivar_getOffset(ivar));
    }
}

+ (void)kd_logProperties:(Class)cls {
    unsigned int count;
    objc_property_t *list = class_copyPropertyList(cls, &count);
    for (unsigned int i = 0; i < count; i++) {
        objc_property_t p = list[i];
        
        const char *name = property_getName(p);
        const char *attr = property_getAttributes(p);
        NSLog(@"%s, %s", name, attr);
    }
}

+ (void)kd_logProperty:(objc_property_t)property {
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

+ (void)kd_logMethod:(Class)cls {
    NSLog(@"Method：");

    unsigned int methodCount;
    Method *list = class_copyMethodList(cls, &methodCount);
    for (unsigned int i = 0; i < methodCount; i++) {
        Method method = list[i];
        
        SEL name = method_getName(method);
        IMP imp = method_getImplementation(method);
        unsigned int num = method_getNumberOfArguments(method);
//        NSLog(@"%@, %s", NSStringFromSelector(name), imp);
        NSLog(@"%@", NSStringFromSelector(name));
    }
}


- (void)hello {
    
    
    
}


@end
