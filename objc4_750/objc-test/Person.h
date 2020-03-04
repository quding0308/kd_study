//
//  Person.h
//  objc-test
//
//  Created by hour on 2020/1/7.
//

#import <Foundation/Foundation.h>

struct test_t {
    char *name;
};

NS_ASSUME_NONNULL_BEGIN

@interface Person : NSObject

@property (nonatomic, copy) NSString *first;
@property (nonatomic, copy) NSString *last;

- (void)testSelector;

- (void)sayHello;
//- (void)sayGoodBye:(NSString *)name;

@end

@interface Man : NSObject

- (void)sayHello;

@end


NS_ASSUME_NONNULL_END

@interface Person (Extension2)


@property (nonatomic, copy) NSString *extension2_first;
@property (nonatomic, copy) NSString *extension2_last;

@end

@interface Person (Extension1)

@property (nonatomic, copy) NSString *extension1_first;
@property (nonatomic, copy) NSString *extension1_last;

@end


