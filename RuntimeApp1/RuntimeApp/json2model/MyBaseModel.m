//
//  MyBaseModel.m
//  RuntimeApp
//
//  Created by hour on 2018/7/5.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "MyBaseModel.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation MyBaseModel

- (instancetype)initWithJson:(NSString *)json {
    NSData *date = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:date options:NSJSONReadingMutableContainers error:nil];
    
    self = [self initWithDict: dict];
    if (self) {
    }
    return self;
}


- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        // 获取dict中的key
//        NSArray<NSString *> *keys = [dict allKeys];
//
//        [keys enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            objc_property_t property = class_getProperty([self class], [obj UTF8String]);
//
//            objc_s
//
//
//        }];
        
//        [dict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
////            NSString *propertyKey = [self propertyForKey:key];
//
//        }];
        
        
        // 获取property
        [self __inspectProperties];
        
        
        
        // 根据key 或者是 key对应的新名字  获取一个property名字  然后设置property的value
        
        
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __inspectProperties];
        
        
        [self __testVar];
    }
    return self;
}

- (void)__inspectProperties {
    
    Class class = [self class];
    
    unsigned int propertyCount;
    objc_property_t *properties = class_copyPropertyList(class, &propertyCount);
    
    for (unsigned int i = 0; i < propertyCount; i++) {
        //        objc_property_t property = properties[i];
        //
        //        const char *name = property_getName(property);
        //
        //        const char *attrs = property_getAttributes(property);
        //        NSString *propertiesAttrs = @(attrs);
        //        NSArray* attrItems = [propertiesAttrs componentsSeparatedByString:@","];
        
        //        if ([attrItems containsObject:@"R"]) {
        //            continue;
        //        }
        
        objc_property_t property = properties[i];
        fprintf(stdout, "%s\n%s\n", property_getName(property), property_getAttributes(property));
        printf("\n");
        
//        const char * name = property_copyAttributeValue(property, "T");
//        fprintf(stdout, "%s\n", name);
//        printf("\n");
//        
//        unsigned int attrCount;
//        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
//        for (unsigned int i = 0; i < attrCount; i++) {
//            objc_property_attribute_t attr = attrs[i];
//        
//            
//            fprintf(stdout, "%s %s\n", attr.name, attr.value);
//        }
//        
//        printf("\n");
        
        
        
    }
    
}

- (void)__testVar {
    Class class = [self class];
    
    unsigned int varCount;
    Ivar *vars = class_copyIvarList(class, &varCount);
    
    for (unsigned int i = 0; i < varCount; i++) {
        Ivar var = vars[i];
        
        const char *name = ivar_getName(var);
        ptrdiff_t offset = ivar_getOffset(var);
        const char *encode = ivar_getTypeEncoding(var);
        
        id value = object_getIvar(self, var);
        
        if (strcmp("_age", name) == 0) {
            NSLog(@"");
            
            id v = @(11);
            object_setIvar(self, var, v);
        } else if (strcmp(name, "_pp") == 0) {
            object_setIvar(self, var, @"lllpp");
        }
        
//        void * value;
//        Ivar result = object_getInstanceVariab(self, "_age", &value);
        
//        object_setin
        
        NSLog(@"");
    }
    
    
}

























@end
