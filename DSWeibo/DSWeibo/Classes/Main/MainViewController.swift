//
//  MainViewController.swift
//  XMGWB
//
//  Created by 李南江 on 15/9/6.
//  Copyright © 2015年 xiaomage. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController { 

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 5. 设置文字颜色
        tabBar.tintColor = UIColor.orange
        
        addChildViewController(childController: HomeTableViewController(), titleImage: "tabbar_home", title: "首页");
        addChildViewController(childController: MessageTableViewController(), titleImage: "tabbar_message_center", title: "消息");
        addChildViewController(childController: DiscoverTableViewController(), titleImage: "tabbar_discover", title: "发现");
        addChildViewController(childController: ProfileTableViewController(), titleImage: "tabbar_profile", title: "我");
    }
    
    private func addChildViewController(childController: UIViewController, titleImage: String, title: String) {
        
        // 1. 设置图片文字等
        childController.tabBarItem.image = UIImage(named: titleImage)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        childController.tabBarItem.selectedImage = UIImage(named: titleImage + "_highlighted")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        childController.tabBarItem.title = title;
        childController.navigationItem.title = title;
        
        // 2. 创建导航控制器
        let nav = UINavigationController();
        nav.addChild(childController);
        
         // 3. 将导航加入到Tab控制器
        addChild(nav);
    }
    
     
}
