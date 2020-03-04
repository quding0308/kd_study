//
//  HelloModel.h
//  RuntimeApp
//
//  Created by hour on 2018/7/6.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "MyBaseModel.h"

@protocol Optional1

@end

/*
 
 T@"NSString",C,N
 
 name
 T@"NSString<Optional1>",C,N,V_name
 
 age
 Ti,N,V_age
 
 param
 T@"NSDictionary",&,N,V_param
 
 param1
 T@"NSMutableDictionary",&,N,V_param1
 
 lalaStruct
 T{Name=i},N,V_lalaStruct
 
 waka
 T@"NSString",C,N,Ghaha,Shello:,V_peter
 */

@interface HelloModel : MyBaseModel

@property (nonatomic, copy) NSString <Optional1> *name;

@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSDictionary *param;
@property (nonatomic, strong) NSMutableDictionary *param1;

//@property (nonatomic, assign) struct Name lalaStruct;

@property (nonatomic, copy, setter=hello:, getter=haha) NSString *waka;
@end

struct Name {
    int name;
};

