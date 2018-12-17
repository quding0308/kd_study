//
//  HelloVC.swift
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
import SnapKit

@objcMembers class HelloVC: UIViewController {
    
    private let viewModel: HelloVM
    private let bag = DisposeBag()
    
    private let tableView = UITableView()
    
    init(viewModel: HelloVM) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
    }
    
    deinit {
        
        
    }
    
}

extension HelloVC {
    
    private func setup() {
        automaticallyAdjustsScrollViewInsets = false
        edgesForExtendedLayout = UIRectEdge()
        
        
//        tableView.reload
        
    }
    
    private func bind() {
        
    }
}

