//
//  LastResponder.m
//  kd_study
//
//  Created by hour on 2018/11/14.
//  Copyright © 2018 hour. All rights reserved.
//

#import "LastResponder.h"

@implementation LastResponder

- (instancetype)init
{
    self = [super init];
    if (self) {
//        NSLog(@"没有响应这个时间");
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch begin");
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touch ended");
}

@end
