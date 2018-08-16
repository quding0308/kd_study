//
//  Hello.swift
//  Test111
//
//  Created by hour on 2018/2/1.
//  Copyright © 2018年 hour. All rights reserved.
//

import Foundation

class Peter {
    
    var name: String {
        willSet {
            print("will Set new \(newValue), old \(name)")
        }
        didSet {
            print("did Set \(name)")
        }
    }
    
    let tag: String
    
    init() {
        name = ""
        print("init")
        tag = "TAG"
    }
    
    convenience init(_ name: String) {
        self.init()
        self.name = name

        /// 初始化  stored value  和 constant的值
    }
    
    convenience init(age: Int) {
        self.init("name")
        
        name = "Quding"
    }
    
    func hello() {
        print("=== hello")
    }
    
}

class Hello3: NSObject {
    
    static var count = 0
    
    fileprivate let name: String
    
    @objc
    static func test() {
        //
        let obj = Hello3.init()
        _ = try? obj.testException(num: 0)
        
        let tPeter = Peter(age: 10)
        tPeter.hello()
        tPeter.name = "lala"
        
        print("")
    }
    
//    override
//    init(_ name: String = "") {
//        super.init()
//        self.name = ""
//    }
    
//    override init() {
//        self.name = ""
//        super.init()
//    }
    
    init(name: String = "") {
        self.name = name
        super.init()
    }
    
    convenience init(age: Int) {
        self.init()
    }
    
    
    func testException(num: Int) throws -> Int{
        if num < 0 {
            throw LoginError.UserNotFound;
        }
        
        return num;
    }
    
    static func staticMethod() {
        //
        print(count)
    }
    
    class func classMethod() {
        //
    }
    
    class final func classFinalMethod() {
        //
    }
    
    // computed property
    class var classProperty: String {
        return ""
    }
    
    static var staticProperty: String {
        return ""
    }
    
    
}

enum LoginError: Error {
    case UserNotFound, UserPasswordNotMatch;
    
    func say() {
        Hello3.init().printName()
    }
}

extension Hello3 {
    func printName() {
        print(name)
    }
    
}

class HelloSub: Hello3 {
    override class func classMethod() {
        //
    }
    
//    override class final func classFinalMethod() {
        //
//    }
    
    
    override class var classProperty: String {
        return ""
    }
    
//    override static var staticProperty: String {
//        return ""
//    }
}

class HasTest: Hashable {
    var hashValue: Int = {
        return 0
    }()
    
    static func == (lhs: HasTest, rhs: HasTest) -> Bool {
        return true
    }
    
    
}

class EquatableTest: Equatable {
    static func == (lhs: EquatableTest, rhs: EquatableTest) -> Bool {
        return true
    }
    
    
    
    
}

///     struct ShippingOptions: OptionSet {
///         let rawValue: Int
///
///         static let nextDay    = ShippingOptions(rawValue: 1 << 0)
///         static let secondDay  = ShippingOptions(rawValue: 1 << 1)
///         static let priority   = ShippingOptions(rawValue: 1 << 2)
///         static let standard   = ShippingOptions(rawValue: 1 << 3)
///
///         static let express: ShippingOptions = [.nextDay, .secondDay]
///         static let all: ShippingOptions = [.express, .priority, .standard]
///     }
