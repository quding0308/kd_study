//
//  Hello.swift
//  kd_study
//
//  Created by hour on 2018/8/14.
//  Copyright © 2018 hour. All rights reserved.
//

import Foundation

class Hello: NSObject {
    
    fileprivate(set) var name: String?
    
    @objc
    func hello() {
//        pointerTest()
//        pointerStringTest()
//        rawPointerTest()
        testStructPointer()
//        testClassPointer()
//        objc_setAssociatedObject(self, <#T##key: UnsafeRawPointer##UnsafeRawPointer#>, <#T##value: Any?##Any?#>, <#T##policy: objc_AssociationPolicy##objc_AssociationPolicy#>)
        
        
        print("")
    }
    
    /**
     UnsafePointer
     UnsafeMutablePointer
     UnsafeBufferPointer
     
     UnsafeRawPointer   // no automated memory management, no type safety, and no alignment guarantees, to access and manage raw bytes in memory, whether or not that memory has been bound to a specific type
     
     */
    private func pointerTest() {
        
        //        var pointer: UnsafePointer<Int>  // 一个指针
        ///  UnsafeMutablePointer
        //        pointer.pointee == 23
        //        pointer[0] = 10
        
        var bytes: [UInt32] = [39, 77, 111, 111, 102, 33, 39, 0]
        
        let uint8Ptr = UnsafeMutablePointer<UInt32>.allocate(capacity: 8)
        
        uint8Ptr.initialize(from: &bytes, count: 8)
        
        let x = uint8Ptr.pointee
        
        let offsetPtr = uint8Ptr + 2
        let y = offsetPtr.pointee
        
        let z = uint8Ptr[4]
        
//        printUInt(atAddress: uint8Ptr)
    }
    
    private func pointerStringTest() {
        
        //        var pointer: UnsafePointer<Int>  // 一个指针
        ///  UnsafeMutablePointer
        //        pointer.pointee == 23
        //        pointer[0] = 10
        
        var bytes: [String] = ["111", "2111"]
        
        let uint8Ptr = UnsafeMutablePointer<String>.allocate(capacity: 8)
        
        uint8Ptr.initialize(from: &bytes, count: 8)
        
        let x = uint8Ptr.pointee
        
        let offsetPtr = uint8Ptr + 2
        let y = offsetPtr.pointee
        
        let z = uint8Ptr[4]
        
        //        printUInt(atAddress: uint8Ptr)
    }
    
    private func rawPointerTest() {
        let bytesPtr = UnsafeMutableRawPointer.allocate(byteCount: 4, alignment: 1)
        
        bytesPtr.storeBytes(of: 0x111111F0, as: UInt32.self)
        
        let x = bytesPtr.load(as: UInt8.self)
        let y = bytesPtr.load(as: UInt16.self)
        let z = bytesPtr.load(as: UInt32.self)
        
        let offsetPtr = bytesPtr + 2
        let xx = offsetPtr.load(as: UInt8.self)
        let yy = offsetPtr.load(as: UInt16.self)
        
        bytesPtr.deallocate()
        
        print("")
    }
    
    private func testStructPointer() {
        let structPtr = UnsafeMutablePointer<PointerTestStruct>.allocate(capacity: 4)
        
        let s1 = PointerTestStruct(firstVar: 10, secondVar: 20, thirdVar: 30)
        let s2 = PointerTestStruct(firstVar: 11, secondVar: 20, thirdVar: 30)
        let s3 = PointerTestStruct(firstVar: 11, secondVar: 30, thirdVar: 30)

        printAddress(values: s1 as! AnyObject)
        printAddress(values: s2 as! AnyObject)
        printAddress(values: s3 as! AnyObject)

        structPtr[0] = s1
        structPtr[1] = s2

        printAddress(values: structPtr[0] as! AnyObject)


        printAddress(values: structPtr[0] as! AnyObject)

        print("")
    }
    
    private func testClassPointer() {
        let classPtr = UnsafeMutablePointer<PointerClass>.allocate(capacity: 4)
        
        let s1 = PointerClass()
        printAddress(values: classPtr[0] as! AnyObject)

        classPtr[0] = s1
        printAddress(values: classPtr[0] as! AnyObject)
        printAddress(values: s1 as! AnyObject)

        print("")
    }
    
    func printUInt(atAddress p: UnsafeMutablePointer<UInt8>) {
        print(p.pointee)
    }
    
    //定义方法打印对象内存地址
    func printAddress(values: AnyObject...){
        for value in values {
            print(Unmanaged.passUnretained(value).toOpaque())
        }
        print("-----------------------------------------")
    }

}

private struct PointerTestStruct {
    
    var firstVar: Int32
    var secondVar: Int16

    var thirdVar: Int16 = 30

}

private struct PointerClass {
    
    var firstVar: Int32 = 10
    var secondVar: Int16 = 20
    
    var thirdVar: Int16 = 30
    
}
