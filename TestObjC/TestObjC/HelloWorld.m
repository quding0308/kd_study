//
//  HelloWorld.m
//  TestObjC
//
//  Created by hour on 2018/12/19.
//  Copyright © 2018 hour. All rights reserved.
//

#import "HelloWorld.h"

#import <objc/runtime.h>
#import <objc/message.h>

@interface HelloWorld ()

@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;

@property (nonatomic, strong) NSArray<Person *> *persons;


@end

@implementation HelloWorld

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        self.persons = @[[[Person alloc] init], [[Person alloc] init]];
//    }
//    return self;
//}

- (void)hello1 {
    [self.persons enumerateObjectsUsingBlock:^(Person * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.name = [NSString stringWithFormat:@"person %lu", (unsigned long)idx];
    }];
    
    
//    for (int i=0; i<2; i++) {
        @autoreleasepool {
            Person *p = self.persons[0];
//              Person *p = self.person1;
//            p.name = [NSString stringWithFormat:@"person %lu", (unsigned long)i];
        }
//    }

}

- (NSArray<Person *> *)persons {
    return @[[[Person alloc] init], [[Person alloc] init]];
}

- (void)hello {
//    NSLog(@"HelloWorld");
    __weak Person *p = nil;
    
//    @autoreleasepool
    {
//        for (int i=0; i< 100; i++) {
           Person *p1 = [[Person alloc] init];
           p = p1;
//        Person *p = [[Person alloc] init];
//            self.person1 = p;
//            self.person2 = p;
//        }
    }

    NSLog(@"%@", p);
    NSLog(@"");
}

@end


@implementation Person



@end
