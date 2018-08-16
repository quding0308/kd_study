//
//  TestOperatorMethod.swift
//  Test111
//
//  Created by hour on 2018/7/19.
//  Copyright © 2018年 hour. All rights reserved.
//

import Foundation

class TestOperatorMethod: NSObject {
    
    
    
    
}


struct Vector2D {
    var x = 0, y = 0
    
}

/*
 infix unary operator
 prefix unary operator
 postfix unary operator
 
 */

extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: right.x - left.x, y: right.y - left.y)
    }
    
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
    
    static postfix func ++ (vector: Vector2D) -> Vector2D {
        return Vector2D(x: vector.x * 2, y: vector.y * 2)
    }
    
}

extension Vector2D: Equatable {
    public static func == (lhs: Vector2D, rhs: Vector2D) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }

}


/*
 自定义操作符
 */
