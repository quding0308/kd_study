//
//  HelloObject.h
//  objc-test
//
//  Created by hour on 2020/1/7.
//

#import <Foundation/Foundation.h>

@protocol Protocol1 <NSObject>

@required
@property (nonatomic, strong) NSString *protocolName;

//@optional
@required
- (void)speak;

@end


NS_ASSUME_NONNULL_BEGIN

@interface HelloObject : NSObject <Protocol1>

@property (nonatomic, strong) NSString *property1;


- (void)sayHello;
- (void)sayGoodbye;

//@property (nonatomic, strong) NSString *protocolName;
//- (void)speak;

@end

NS_ASSUME_NONNULL_END
