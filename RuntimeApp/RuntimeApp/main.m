//
//  main.m
//  RuntimeApp
//
//  Created by hour on 2018/7/3.
//  Copyright © 2018年 hour. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#import "RuntimeDemo.h"

struct Person {
    int age;
    char *name;
    int num;
};

int main(int argc, char * argv[]) {
    [RuntimeDemo test];
    
    {
        int a = 10;
        {
            int a = 20;
            NSLog(@"");
            {
                int a = 30;
                NSLog(@"");
            }
        }
        NSLog(@"");
    }
    
    int arr[20] = {1,2,3,4,5};
    int *pInt = arr;
    
    char carr[5] = {'a', 'b', 'c', 'd', 'e'};
    char *pchar = "abcde";
    
    size_t size = sizeof(pchar);
    
    struct Person person;
    person.age = 10;
    person.name = "Peter";
    person.num = 20;
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}

