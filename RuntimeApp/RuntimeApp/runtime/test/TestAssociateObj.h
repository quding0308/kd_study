//
//  TestAssociateObj.h
//  RuntimeApp
//
//  Created by hour on 2018/8/20.
//  Copyright © 2018 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestAssociateObj : NSObject

+ (void)test;

@end


@interface TestAssociateObj (Extension)

@property (nonatomic, strong) NSString *lastName;

@end
