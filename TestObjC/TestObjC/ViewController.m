//
//  ViewController.m
//  TestObjC
//
//  Created by hour on 2018/11/29.
//  Copyright © 2018 hour. All rights reserved.
//

#import "ViewController.h"

#import "TestObjC-Swift.h"

#import "Hello.h"

#import "TimeHelper.h"

@interface ViewController ()

@end

@implementation ViewController

+ (void)load {
    NSLog(@"");
}

+ (void)initialize {
    NSLog(@"");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [TimeHelper test];
    
    MyClass *myclass = [[MyClass alloc] init];
    [myclass hello];
    
    test();
    
    
//    [[[HelloSwift alloc] init] helloSwift];
    
    BOOL flag = [Hello isKindOfClass:[NSString class]];
}


@end

@implementation MyClass

- (void)hello {
    NSLog(@"");
}

@end



static void test(void) {
    
    
    
}
