//
//  MyBaseModel.h
//  RuntimeApp
//
//  Created by hour on 2018/7/5.
//  Copyright © 2018年 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyBaseModel : NSObject

- (instancetype)initWithJson:(NSString *)json;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
