//
//  HomeTableViewController.swift
//  XMGWB
//
//  Created by 李南江 on 15/9/6.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class HomeTableViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 如果是没有登陆, 只设置没登陆的方法
        if (!userLogin) {
            visitorView?.setupVisitorInfo(isHome: true, imageName: "visitordiscover_feed_image_house", message: "关注一些人，回这里看看有什么惊喜");
            return;
        }
        
        // 如果登陆了, 设置登陆之后的逻辑
        setUpNavgation();
        

    }
    
    private func setUpNavgation() {
        // 1. 添加左右按钮
        // 利用分类封装btn
        navigationItem.leftBarButtonItem = UIBarButtonItem.createBtn(imageName: "navigationbar_friendattention", target: self, sction: #selector(leftItemClick));
        navigationItem.rightBarButtonItem = UIBarButtonItem.createBtn(imageName: "navigationbar_pop", target: self, sction: #selector(rightItemClick));
        
        // 2. 添加标题
        // 利用继承创建按钮
        let titleBtn:TitleBtn = TitleBtn()
        titleBtn.addTarget(self, action: #selector(titleBtnClick), for: UIControl.Event.touchUpInside)
        navigationItem.titleView = titleBtn;
        
    }
    
    @objc func leftItemClick()
    {
        print(#function);
    }
    
    @objc func rightItemClick()
    {
        print(#function);
    }
    
    @objc func titleBtnClick(btn: UIButton)
    {
        btn.isSelected = !btn.isSelected;
        print(#function);
    }
    
}
