//
//  TestProtocol.swift
//  Test111
//
//  Created by hour on 2018/6/4.
//  Copyright © 2018年 hour. All rights reserved.
//

import Foundation

class TestProtocol {
    
    class func test() {
        
        
        
    }
    
}

protocol GeneratorType {
    associatedtype Element  // associatedtype在protoco中声明一个类型占位符作为协议定义的一部分
    
    func next() -> Element?
    
}


//////////
/*
protocol Automobile {
    associatedtype FluelType
    
    func drive(fuel: FluelType) -> FluelType.ExhaustedType
}

// 燃油
protocol Fuel {
    associatedtype ExhaustedType
    
    func comsume() -> ExhaustedType
}

// 尾气
protocol Exhaust {
    func emit()
}

public struct Car: Automobile {
    typealias FluelType = Fuel
    typealias ExhaustedType = Exhaust
    
    func drive(fuel: FluelType) -> FluelType.ExhaustedType {
        return fuel.comsume()
    }
}

public struct UnleadedGasoline: Fuel {
    func comsume() -> E {
        return E()
    }
    
    typealias E = Exhaust
}

public struct CleanExhaust: Exhaust {
    public init() {}
    public func emit() {  print("...this is some clean exhaust...")
    }
}

*/

struct Model {
    let age: Int
}

protocol TableCell {
    associatedtype T
    
    func updateCell(_ model: T)
}

class MyTableCell: UITableViewCell, TableCell {
    func updateCell(_ model: Model) {
        
    }
    
    typealias T = Model
    
}


