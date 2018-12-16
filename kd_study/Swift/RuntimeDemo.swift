//
//  RuntimeDemo.swift
//  Test111
//
//  Created by hour on 2018/8/10.
//  Copyright © 2018 hour. All rights reserved.
//

import Foundation

@objcMembers
@objc(Runtime)
class RuntimeDemo: NSObject {
    
//    @objc dynamic
    var name: String?
//    "@objc dynamic
    let ll = ""
    
    @objc(test)
    static func testRuntime() {
        //    RuntimeDemo *demo = [[RuntimeDemo alloc] init];
        //    [demo setKd_name:@"Peter"];
        //    NSString *name = [demo kd_name];
        
        let demo = RuntimeDemo()
        demo.kd_name = "Peter"
        let name = demo.kd_name
        
//        demo.testProperty()
        
        demo.setValue("Tom", forKey: #keyPath(RuntimeDemo.name))
        let name1 = demo.value(forKey: #keyPath(RuntimeDemo.name))
        
        demo.perform(#selector(testProperty))
        
        demo.setupModules()
        print("end")
    }
    
    @objc dynamic func testProperty() {
        var count: UInt32 = 0
        let list = class_copyPropertyList(object_getClass(self), &count)
        
        for i in 0..<numericCast(count) {
            let property = property_getName((list?[i])!)
            
            print(String(utf8String: property) ?? "default")
        }
        
        print("")
    }
    
    func setupModules() {
        var count: UInt32 = 0
        
        guard let imgName = class_getImageName(RuntimeDemo.self) else { return }
        guard let classes = objc_copyClassNamesForImage(imgName, &count) else { return }
        for i in 0..<Int(count) {
            if let clsName = String(utf8String: classes[i]) {
                if let cls = NSClassFromString(clsName) {
                    if cls.self is MyClass1.Type {
                        if let aClass = cls as? MyClass1.Type {                            
                            let obj = aClass.init()
                            obj.hello()
                        }
                    }
                }
            }
        }
    }
}

//@nonobjc
extension RuntimeDemo {
    var kd_name: String? {
        get {
//            return objc_getAssociatedObject(self, &self.kd_name) as? String
            return objc_getAssociatedObject(self, #keyPath(RuntimeDemo.kd_name)) as? String
        }
        set {
//            objc_setAssociatedObject(self, &self.kd_name, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
            objc_setAssociatedObject(self,  #keyPath(RuntimeDemo.kd_name), newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}

