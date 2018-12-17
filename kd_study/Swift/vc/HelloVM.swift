//
//  HelloVM.swift
//  kd_study
//
//  Created by hour on 2018/11/26.
//  Copyright © 2018 hour. All rights reserved.
//

import Foundation

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

@objcMembers class HelloVM: NSObject {
    
    private let bag = DisposeBag()
    
    override init() {
        super.init()
        bind()
    }
    
}

extension HelloVM {
    private func bind() {
        
    }
}
