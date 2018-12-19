//
//  RuntimeDemo+Util.m
//  kd_study
//
//  Created by hour on 2018/12/18.
//  Copyright © 2018 hour. All rights reserved.
//

#import "RuntimeDemo+Util.h"

@implementation RuntimeDemo (Util)

+ (void)initialize {
    NSLog(@"initialize category");
}

- (void)hello {
    NSLog(@"hello category");
}

@end
