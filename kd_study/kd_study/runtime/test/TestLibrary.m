//
//  TestLibrary.m
//  RuntimeApp
//
//  Created by hour on 2018/8/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import "TestLibrary.h"


#import <objc/runtime.h>

/**
 working with library
 
 objc_copyImageNames
 objc_copyClassNamesForImage
 
 class_getImageName
 
 */
@implementation TestLibrary

+ (void)test {
    unsigned int outCount;
    const char **imageNames = objc_copyImageNames(&outCount);
    
    for (unsigned int i = 0; i < outCount; i++) {
        const char *name = imageNames[i];
        NSLog(@"%s", name); // image name
        NSString *appName = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
        
        if ([appName containsString:@"RuntimeApp"]) {
            [self getImgInfo:name];
        }
    }
    
    [self getImageName];
}

+ (void)getImgInfo:(const char *)name {
    unsigned int outCount;

    const char **clsNames = objc_copyClassNamesForImage(name, &outCount);
    
    for (unsigned int i = 0; i < outCount; i++) {
        const char *name = clsNames[i];
        NSLog(@"%s", name); // image name
    }
}

+ (void)getImageName {
//    const char * imgName = class_getImageName(self);
    const char * imgName = class_getImageName([NSObject class]);

    NSLog(@"");
}


@end
