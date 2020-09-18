//
//  BaseTableViewController.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/9.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController, VisitorViewDelegate {
    // 记录用户的登陆情况
    let userLogin = true;
    
    var visitorView: VisitorView?;
    
    override func loadView() {
        // 没有登陆时候加载自定义的View
        userLogin ? super.loadView() : setupVisitor();
    }
    
    func setupVisitor() {
        let custom = VisitorView.init();
        custom.delegate = self;
        view = custom;
        visitorView = custom;
        
        // 如果没有登陆, 创建导航栏按钮
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.loginWillClicked))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登陆", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.loginWillClicked))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - 实现代理方法
    @objc func loginWillClicked() {
        
        
        
        
        print(#function);
    }
    
    @objc func registerWillClicked() {
        print(#function);
    }
}
