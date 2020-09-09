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
        // 基础设置
        // 1. 设置文字颜色
        tabBar.tintColor = UIColor.orange
        // 2. 设置背景颜色
        tabBar.barTintColor =  UIColor(red: 0.97, green: 0.97, blue: 0.97, alpha: 1);
        
        // 获取bundle中的数据
        // 1.获取json文件路径
        let path = Bundle.main.path(forResource:"MainVCSettings.json", ofType: nil);
        
        let data = NSData(contentsOfFile: path!);
        
        
        // Xcode7之前是过error来捕获异常, Xcode7之后是通过 try / catch捕获异常
        do {
            let arr = try JSONSerialization.jsonObject(with:data! as Data, options: JSONSerialization.ReadingOptions.mutableContainers);
            print(arr)
            
            // 便利字典时候要明确数组中的数据类型
            for dict in arr as! [[String : String]]{
                print(dict);
                addStringController(childVC: dict["vcName"]!, titleImage: dict["imageName"]!, title: dict["title"]!);
            }
            
        } catch {
            print(error);
            addStringController(childVC: "HomeTableViewController", titleImage: "tabbar_home", title: "首页");
            addStringController(childVC: "MessageTableViewController", titleImage: "tabbar_message_center", title: "消息");
            addStringController(childVC: "DiscoverTableViewController", titleImage: "tabbar_discover", title: "发现");
            addStringController(childVC: "ProfileTableViewController", titleImage: "tabbar_profile", title: "我");
        }
        
        
        
    }
    
    // MARK: - 使用字符串创建类
    func addStringController(childVC: String, titleImage: String, title: String) {
        /**
         Swift中所有的类都有一个命名空间xxxx.xxxxxxxViewController
         */
        // 0. 动态获取命名空间
        let nameSpace = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String;

        // 1. 将字符串转化为类
        let cls: AnyClass = NSClassFromString(nameSpace + "." + childVC)!;
        
        // 2. 将类强转, 在初始化
        let clsVc = (cls as! UIViewController.Type).init();
        
        
        // 3. 设置图片文字等
        clsVc.tabBarItem.image = UIImage(named: titleImage)?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        clsVc.tabBarItem.selectedImage = UIImage(named: titleImage + "_highlighted")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal);
        clsVc.tabBarItem.title = title;
        clsVc.navigationItem.title = title;
        
        // 4. 创建导航控制器
        let nav = UINavigationController();
        nav.addChild(clsVc);
        
         // 5. 将导航加入到Tab控制器
        addChild(nav);
        
        
    }
     
}
