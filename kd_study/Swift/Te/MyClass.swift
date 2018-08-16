//
//  MyProtocol.swift
//  Test111
//
//  Created by hour on 2018/8/10.
//  Copyright © 2018 hour. All rights reserved.
//

import Foundation

@objcMembers
class MyClass: NSObject {
    
    func hello() {
        //
    }
    
    required override init() {
        //
    }
    
}


class FirstClass: MyClass {
    override func hello() {
        print("FirstClass")
    }
}

class SecondClass: MyClass {
    override func hello() {
        print("SecondClass")
    }
}
