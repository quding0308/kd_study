//
//  KDUtil.h
//  RuntimeApp
//
//  Created by hour on 2018/8/21.
//  Copyright © 2018 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <objc/runtime.h>
#import <objc/message.h>

@interface KDUtil : NSObject

+ (void)kd_logObjSize:(id)obj;
+ (void)kd_logDictSize:(NSDictionary *)dict;

+ (void)kd_logIvar:(Class)cls;
+ (void)kd_logProperties:(Class)cls;
+ (void)kd_logProperty:(objc_property_t)property;
+ (void)kd_logMethod:(Class)cls;

- (void)hello;

@end
