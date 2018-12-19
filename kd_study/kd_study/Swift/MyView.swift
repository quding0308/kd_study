//
//  MyView.swift
//  Test111
//
//  Created by hour on 2018/4/8.
//  Copyright © 2018年 hour. All rights reserved.
//

import UIKit
import SnapKit

class MyView: UIView {
    
    // 懒加载，加载一次
    lazy var button1: UIButton = {
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        btn.setTitle("btn1", for: .normal)
        btn.setTitle("btn1", for: .highlighted)
//        btn.addTarget(self, action: #selector(actionBtn(btn:)), for: .touchUpInside)
        
        return btn
    }()
    
    var realValue: Int {
        willSet {   // init方法不会回调 willSet 和 didSet
            print("willSet")
            print(newValue)
        }
        
        didSet {
            print("didSet")
        }
        
    }
    
    // 语法糖，get set方法
    var count: Int {
        get {
            return realValue
        }
        set {
            realValue = newValue
        }
        
    }
    
    init() {
        realValue = 0
        super.init(frame: CGRect.zero)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupView() {
        count += 1
        count += 1
        
        self.addSubview(button1)
        
        // TODO: 待完成功能
        button1.snp.makeConstraints { (maker) in
            maker.left.equalToSuperview()
            maker.top.equalToSuperview()
            maker.size.equalToSuperview()
        }
        
        var scale = POPBasicAnimation.easeIn()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return nil
    }
    
}

// MARK: - action -
extension MyView {
    func actionBtn(btn: UIButton) {
        print(btn.tag);
        // FIXME: 有bug
        print(btn.titleLabel?.text ?? "default");
        
        
        
        
    }
    
}



