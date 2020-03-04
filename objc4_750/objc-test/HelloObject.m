//
//  HelloObject.m
//  objc-test
//
//  Created by hour on 2020/1/7.
//

#import "HelloObject.h"

@interface HelloObject () {
    int grade;
    NSString *_firstName;
    NSString *_lastName;
    int age;
    
//    static NSString *clsVar;
}

@end

@implementation HelloObject

- (void)sayHello {
    NSLog(@"=== sayHello");
}

- (void)sayGoodbye {
    NSLog(@"=== sayGoodbye");
}

- (void)speak {
    NSLog(@"=== speak");
}

- (void)setProtocolName:(NSString *)protocolName {
    NSLog(@"=== %@", protocolName);
}

@end
