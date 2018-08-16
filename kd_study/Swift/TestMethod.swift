//
//  TestMethod.swift
//  Test111
//
//  Created by hour on 2018/8/10.
//  Copyright © 2018 hour. All rights reserved.
//

import Foundation

class TestMethod: NSObject {
    
    static func test() {
        let demo = TestMethod()
        
        var temp1 = 0
        var temp2 = 0
        
        demo.swapTwoInt(&temp1, &temp2)
        
        
        print("")
    }
    
    fileprivate func swapTwoInt(_ a: inout Int, _ b: inout Int) {
        let tmp = a
        a = b
        b = tmp
    }
    
    
}
