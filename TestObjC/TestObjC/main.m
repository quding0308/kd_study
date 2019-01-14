//
//  main.m
//  TestObjC
//
//  Created by hour on 2018/11/29.
//  Copyright © 2018 hour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#include "test_c.h"

#import <math.h>
#import <semaphore.h>

NSString* (*fp)(void);

/*
NSString *name() {
    return @"";
}*/


NSString *name(void) {
    return ({
        @"221";
    });
}


int main(int argc, char * argv[]) {
    float_t a = 10, b = 20;
    int r1 = isgreater(a, b);
    
    double r2 = log2(8);
    
    
    sem_t *sem = sem_open("sem_1", 0);
    
    int r4 = sem_post(sem);
    
    r4 = sem_wait(sem);
    
    r4 = sem_wait(sem);
    
    
    fp = name;
    NSString *result = fp();

    name();
    
//    @autoreleasepool {
        ({
            double a = 1.999;
            int b = a;
            float c = a;
        });
        
        printf("end");
//        printf("%ld", a);
        
        ({
            double a = 1.999;
            int b = a;
            float c = a;
        });
        
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    return 0;
}
