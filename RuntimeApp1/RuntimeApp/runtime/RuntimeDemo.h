//
//  RuntimeDemo.h
//  TimeApp
//
//  Created by hour on 2017/11/13.
//  Copyright © 2017年 hour. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RuntimeDemo : NSObject

+ (void)test;

@end

/*
 消息机制
 SEL
 typedef objc_selector *SEL;   标识运行时一个方法的名字（在编译阶段，根据名称生成一个唯一的整数）
 
 IMP 函数指针
 typedef id(*IMP)(id, SEL, ...)
 
 
 Method
 typedef struct objc_method *Method;
 
 struct objc_method {
 SEL method_name OBJC2_UNAVAILABLE;
 char *method_types OBJC2_UNAVAILABLE;
 IMP method_imp OBJC2_UNAVAILABLE;
 } OBJC2_UNAVAILABLE;
 
 
 */

/*
 元类
 元类的方法列表对应的是类方法
 
 */



/*
 runtime是OC底层的一套c语言API。编译器会把oc代码编译成运行时代码，调用的就是runtime接口。
 
 实际使用场景：
 1.方法互换
 2.动态添加成员变量和方法
 3.获得某个类的所有成员变量和方法
 
 4.model与字典互相转
 5.分类增加属性
 6.
 
 Class
 typedef struct objc_class *Class;   Class是一个指向objc_class结构体的指针
 struct objc_class {
 Class isa;//元类
 Class super_class; // 父类
 
 struct objc_ivar_list *ivars;// 变量列表
 struct objc_method_list *methodLists; // 方法列表
 struct objc_cache *cache;   方法缓存
 struct objc_protocol_list *protocols; // 协议列表
 }
 
 id
 typedef struct objc_object *id;
 struct objc_object {
 
 }
 
 
 IMP 是一个指针，函数指针，指向方法的实现
 Method
 Ivar
 struct objc_ivar {
 char *ivar_name;   // 变量名
 char *ivar_type;   // 变量类型
 int ivar_offset;   // 偏移量，对成员变量寻址时使用
 
 
 }
 
 一个属性必然对应一个成员变量，还会根据属性修饰符，队成员变量进行一系列封装
 objc_property_t
 struct objc_property {
 
 }
 
 Defines a property attribute
 typedef struct {
 const char *name;  The name of the attribute
 const char *value; < The value of the attribute (usually empty)
 } objc_property_attribute_t;
 
 
 类型：
 // SEL
 typedef struct objc_selector *SEL; // 一个方法的selector。
 typedef struct objc_category *Category; // 一个category
 typedef struct objc_ivar *Ivar;    // 实例变量
 typedef struct objc_method *Method;    // class中定义的method
 
 
 
 // 函数指针
 typedef id (*IMP)(id, SEL, ...);
 
 
 // void objc_msgSend(id, SEL)
 
 
 
 
 
 
 
 */
