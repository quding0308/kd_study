//
//  EnumTest.swift
//  Test111
//
//  Created by hour on 2018/6/4.
//  Copyright © 2018年 hour. All rights reserved.
//

import Foundation

//import PromiseKit

class EnumTest: NSObject {
    class func testEnum() {
        let hello = HelloEnum.hello
        switch hello {
        case .hello:
            print("\(hello.rawValue)")
        case .nihao:
            print("\(hello.rawValue)")
        default:
            print("")
        }
        
        let code = Barcode.qrCode("123")
        switch code {
        case .qrCode(let codeStr):
            print(codeStr)
        case .upc(let a, let b, let c):
            print("\(a) + \(b) + \(c)")
            //        default:
            //            print("")
        }
        
        let compass = CompassPoint.east
        switch compass {
        case .east:
            print(compass.rawValue)
        default:
            print(compass.rawValue)
        }
        
        {
            let planet = Planet.a
            switch planet {
            default:
                print(planet.rawValue)
            }
        }()
        
        if let planet = Planet(rawValue: 7) {
            switch planet {
                case .a:
                    print(planet.rawValue)
                default:
                print(planet.rawValue)
            }
        }
        
        let step = AuthFlowStep.unknow
        switch step {
        case .unknow:
            print("")
            fallthrough // 会执行下一个case，行为跟oc中一致了
        case .initial:
            print("")
        default:
            break
        }
        
        
    }
    
    
}

enum AuthFlowStep {
    case unknow
    case none   // 会跟Optional的none混淆，最好不要使用
    case finished
    case initial
    case notFound
    case nothing
    case unspecified
    
}

enum HelloEnum: Int {
    case hello
    case nihao
    case pp
    
}

// associated value 是一个tuple
enum Barcode {
    case upc(Int, Int, Int) // associated value 是一个tuple
    case qrCode(String) // associated value 是一个String
    
}

// raw value 设置
/*
 Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so.
 */
enum ASCIIControlCharacter: Character {
//    typealias RawValue = Character
    
    case tab = "\t"
    case lineFeed = "\n"
}

enum Planet: Int {
    case a = 5, b, c, d     // 设置一个默认值，之后的值会自增
}

enum CompassPoint: String {
    case east   // raw value is 'east' default
    case south
    case west
    case north
}

// 枚举的递归


