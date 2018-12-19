

//
//  SuperClass.m
//  TimeApp
//
//  Created by hour on 2017/11/13.
//  Copyright © 2017年 hour. All rights reserved.
//

#import "SuperClass.h"

#include <string>
//#include <stdlib.h>
//#include <string.h>

using std::string;

@implementation SuperClass


@end


void use_ptr( int *p) {
    *p = 0;
    p = 0;
}

// 使用const 修饰 *p  可以防止p指针指向的值修改，此时指针可以修改
void use_ptr1(const int *p) {
//    *p = 0;
    p = 0;
}

// 等价于  use_ptr1
void use_ptr2(int const *p) {
//        *p = 0;
    p = 0;
}

// 此时 指针不可修改，但指针指向的变量可修改
void use_ptr3(int * const p) {
    *p = 0;
//    p = 0;
}

/**
 C++中的引用形参
 c语言中习惯于通过传递指针来实现对实参的访问，C++中通过使用引用形参更安全和自然
 
 */

void swap(string &s1, string &s2) {
    string tmp = s1;
    s1 = s2;
    s2 = tmp;
}
