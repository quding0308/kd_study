//
//  TestCompare.m
//  kd_study
//
//  Created by hour on 2020/1/9.
//  Copyright © 2020 hour. All rights reserved.
//

#import "TestCompare.h"


@implementation TestCompareObj1

- (BOOL)isEqual:(TestCompareObj1 *)other
{
    if (other == self) {
        return YES;
    } else {
//        return self.first == other.first && self.second == other.second;
        return [self.first isEqualToString:other.first ] && [self.second isEqualToString: other.second];
    }

    return NO;
}

- (NSUInteger)hash
{
    return [NSString stringWithFormat:@"%@%@", self.first, self.second].hash;
}

- (id)copyWithZone:(NSZone *)zone {
    TestCompareObj1* obj = [[TestCompareObj1 alloc] init];
    obj.first = self.first;
    obj.second = self.second;
    
    return obj;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    TestCompareObj1* obj = [[TestCompareObj1 alloc] init];
    obj.first = self.first;
    obj.second = self.second;
    
    return obj;
}

//- (id)copy {
//    TestCompareObj1* obj = [[TestCompareObj1 alloc] init];
//    obj.first = self.first;
//    obj.second = self.second;
//    
//    return obj;
//}
//
//- (id)mutableCopy {
//    TestCompareObj1* obj = [[TestCompareObj1 alloc] init];
//    obj.first = self.first;
//    obj.second = self.second;
//    
//    return obj;
//}

@end

@implementation TestCompare

/// isEqual、==、isEqualToString
+ (void)test {
//    [self testHash];
    [self testCopy];
    
    TestCompareObj1* obj1 = [[TestCompareObj1 alloc] init];
    obj1.first = @"first";
    obj1.second = @"second";
    TestCompareObj1* obj2 = [[TestCompareObj1 alloc] init];
    obj2.first = @"first".mutableCopy;
    obj2.second = @"second".mutableCopy;
    
    if(obj1 == obj2){
        NSLog(@"==");
    }
    
    if([obj1 isEqual:obj2]){
        NSLog(@"isEqual");
    }
    
    NSString *str1  = [[NSString alloc] initWithString:@"hello"];
    NSString *str2  = [[NSString alloc] initWithString:@"hello"];
    NSString *str3  = [[NSMutableString alloc] initWithString:@"hello"];
    NSString *str4  = [[NSMutableString alloc] initWithString:@"hello"];
    
    if(str1 == str2) { // YES
        NSLog(@"== ");
    }
    
    if(str1 == str3) { // NO
        NSLog(@"== ");
    }
    
    if(str3 == str4) { // NO
        NSLog(@"== ");
    }
    
    if([str1 isEqual:str2]){ // YES
        NSLog(@" isEqual ");
    }
    
    if([str3 isEqual:str4]){    // YES
        NSLog(@"isEqual ");
    }
    
}

+ (void)testHash{
    NSMutableDictionary *mDict = @{}.mutableCopy;
    
    TestCompareObj1* obj1 = [[TestCompareObj1 alloc] init];
    obj1.first = @"first";
    obj1.second = @"second";
    TestCompareObj1* obj2 = [[TestCompareObj1 alloc] init];
    obj2.first = @"first".mutableCopy;
    obj2.second = @"second".mutableCopy;
    
    TestCompareObj1* obj3 = nil;//[[TestCompareObj1 alloc] init];
    
    [mDict setObject:@"123" forKey:obj1];
    [mDict setObject:[NSNull null] forKey:obj2];
//    [mDict setObject:@"789" forKey:obj3]; // crash

    
    NSLog(@"");
}

+ (void)testCopy {
    TestCompareObj1* obj1 = [[TestCompareObj1 alloc] init];
    obj1.first = @"first";
    obj1.second = @"second";
    
    TestCompareObj1 *obj2 = obj1.copy;
    TestCompareObj1 *obj3 = obj1.mutableCopy;
    
    obj1.first = @"123";
 
    NSLog(@"");
}

@end
