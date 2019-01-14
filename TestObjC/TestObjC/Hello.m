//
//  Hello.m
//  TestObjC
//
//  Created by hour on 2018/12/26.
//  Copyright © 2018 hour. All rights reserved.
//

#import "Hello.h"

@interface Hello () {
    NSString *_name;
    int _age;
}

@end

@implementation Hello

+ (void)load {
    NSLog(@"");
}

+ (void)initialize {
    NSLog(@"");
}

- (void)helloMethod {
    NSLog(@"");
}

@end
