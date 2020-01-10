//
//  HelloWorld.h
//  TestObjC
//
//  Created by hour on 2018/12/19.
//  Copyright © 2018 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HelloWorld : NSObject

- (void)hello;
- (void)hello1;

@end

@interface Person: NSObject

@property (nonatomic, strong) NSString *name;

@end


NS_ASSUME_NONNULL_END
