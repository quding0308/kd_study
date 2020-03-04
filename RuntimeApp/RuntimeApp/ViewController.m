//
//  ViewController.m
//  RuntimeApp
//
//  Created by hour on 2018/7/3.
//  Copyright © 2018年 hour. All rights reserved.
//

#import "ViewController.h"

#import <objc/runtime.h>

#import "ShuWeiLocation.h"


#import "RuntimeDemo.h"

#import "HelloModel.h"

#import "TestMethod.h"
#import "RunHello.h"

#import "TestTaggedPointer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    [[HelloModel alloc] init];
    
//    [TestMethod test];
    
//    [ShuWeiLocation sharedInstance];
    
    [TestTaggedPointer test];
    
//    [RuntimeDemo test];
    
    
    RunHello *hello = [[RunHello alloc] init];
    RunHello *hell = [[RunHello alloc] init];
////    hello.firstName = @"123";
////    hello.lastName = @"234";
////    id obj = objc_getAssociatedObject(hello, @selector(lastName));
//    hello.age = 10;
//
//
//    self.hello = hello;
//    self.hello2 = hello;
    
    
    
//    @selector(<#selector#>)
    
//    Class c = [RunHello class];
//    Class sc = class_getSuperclass(c);
//    class_getmeta
    //    (*c)->data();
    //    class_getVersion(Class  _Nullable __unsafe_unretained cls);
    //        class_getSuperclass()
    
    /*
     create a new class and metaclass
     */
    Class qdClass = objc_allocateClassPair([NSObject class], "QuDing", 0);

    objc_property_attribute_t type = { "T", "@\"NSString\"" };
    objc_property_attribute_t ownership = { "C", "" }; // C = copy
    objc_property_attribute_t backingivar  = { "V", "_privateName" };
    objc_property_attribute_t attrs[] = { type, ownership, backingivar };
    class_addProperty(qdClass, "age", attrs, 3);
    
    objc_registerClassPair(qdClass);
    
    
    Class c2 = objc_getClass("QuDing");
    
    id qdObj = class_createInstance(c2, 0);
//    [qdObj setAge:@"22"];
    Ivar ivar = class_getInstanceVariable(c2, "age");
    object_setIvar(qdObj, ivar, [NSString stringWithFormat:@"22"]);
    
    objc_setAssociatedObject(self, "name", [NSString stringWithFormat:@"Peter"], OBJC_ASSOCIATION_COPY_NONATOMIC);
    id name = objc_getAssociatedObject(self, "name");
    
    id age = object_getIvar(qdObj, ivar);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testAtomatic {
    // property is atomic by default
    // @property NSObject *obj;          // atomic by default

}

- (void)setName:(NSString *)name {
    _name = name;
}


@end

//NSString *nameGetter(id self, SEL _cmd) {
//    Ivar ivar = class_getInstanceVariable([SomeClass class], "_privateName");
//    return object_getIvar(self, ivar);
//}
//
//void nameSetter(id self, SEL _cmd, NSString *newName) {
//    Ivar ivar = class_getInstanceVariable([SomeClass class], "_privateName");
//    id oldName = object_getIvar(self, ivar);
//    if (oldName != newName) object_setIvar(self, ivar, [newName copy]);
//}
