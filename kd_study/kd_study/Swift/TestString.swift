//
//  TestString.swift
//  Test111
//
//  Created by hour on 2018/6/12.
//  Copyright © 2018年 hour. All rights reserved.
//

import Foundation

class TestString: NSObject {
    
    @objc static func test() {
        //
        let char = Character.init("1")
        
        
        var str = "123"
        // String是Character的Collection，count就是Character的数量
        let count = str.count
        str.isEmpty
        str.isEmpty
        
        /*
         String 是 sruct，修改str，会生成一个新的String，原来的不会修改
         
         modify and compare
         +  +=
         == < > <=
         
         */
        
        _ = str.first
        _ = str.last
        
        print(str.unicodeScalars.count)
        print(str.unicodeScalars)
        print(str.unicodeScalars.map { $0.value })
        
        // utf-8 view
        print(str.utf8.count)
        
        // accessing String View Elements
        let name = "Hello World"
        let firstSpace = name.index(of: " ") ?? name.endIndex
        let firstName = name[..<firstSpace]   // [0, firstSpace)
        print(firstName)
        print(Array(name.utf8[..<firstSpace]))
        
        _ = name as NSString
        
        
        
        str.insert(contentsOf: "234", at: name.startIndex)
        
        str.replacingOccurrences(of: "1", with: "2")
        
        let range = str.range(of: "3")
//        str.replaceSubrange(<#T##bounds: Range<String.Index>##Range<String.Index>#>, with: <#T##Collection#>)
        
        try? str.filter({ (char) -> Bool in
            return char != "1"
        })
        
        // map(transform: (Character) -> T)
        str.map { $0 != "1" }
//        str.flatMap { (char) -> Sequence in
//            
//        }
        
        str.reduce( "10") { (str, char) -> String in
            return str
        }
        
        var backward: (String, String) -> Bool
        var forward: (Void) -> Void
        
        backward = { (s1, s2) -> Bool in
            return s1 < s2
        }
        
        let arrStr = ["1", "3", "2"]
        _ = arrStr.sorted(by: backward)
        
        _ = arrStr.sorted(by: { (s1, s2) -> Bool in
            return s1 < s2
        })
        
        // trailing closure
        _ = arrStr.sorted() {
            return $0 < $1
        }
        
        _ = arrStr.sorted {
            return $0 < $1
        }
        
        _ = arrStr.sorted() { s1, s2 in s1 < s2 }
        _ = arrStr.sorted { $0 < $1 }
        _ = arrStr.sorted(by: <)
        
        let digitNames = [
            0: "Zero", 1: "One", 2: "Two",   3: "Three", 4: "Four",
            5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
        ]
        let numbers = [16, 58, 510]
        
        let strs = numbers.map { num -> String in
            var num = num;
            var output = ""
            
            repeat {
                output = digitNames[num % 10]! + output
                num /= 10
            } while num > 0
            
            return output
        }
        
        
        
        
    }
    
}

