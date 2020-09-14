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
        
        // 设置全局外观
        UITabBar.appearance().tintColor = UIColor.orange;
        UINavigationBar.appearance().tintColor = UIColor.orange;
        
        // 3. 添加控制器
        addAllControllers();
        
        // 4. 添加加号按钮, 如果在ViewDidLoad里面方法监听不好使
        tabBar.addSubview(composeBtn);
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        // MARK: - 苹果推荐使用懒加载, 在ViewDidLoad中, 添加按钮时候, item没有创建, 此时item才被创建, 覆盖了btn, 导致方法监听不到
        let width = UIScreen.main.bounds.width / CGFloat(tabBar.items!.count);
        let frame = CGRect(x: 0, y: 0, width: width, height: 49);
        composeBtn.frame = frame.offsetBy(dx: 2 * width, dy: 0);
       tabBar.bringSubviewToFront(composeBtn)
    }
    
    // MARK: - 设置控制器
    private func addAllControllers() {
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
            addStringController(childVC: "NullViewController", titleImage: "", title: "");
            addStringController(childVC: "DiscoverTableViewController", titleImage: "tabbar_discover", title: "发现");
            addStringController(childVC: "ProfileTableViewController", titleImage: "tabbar_profile", title: "我");
        }
}
    
    // MARK: - 使用字符串创建类
    private func addStringController(childVC: String, titleImage: String, title: String) {
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
    
    // MARK: - 懒加载加号按钮
    lazy var composeBtn: UIButton = {
        let btn = UIButton();
        btn.setImage(UIImage(named: "tabbar_compose_icon_add"), for: UIControl.State.normal);
        btn.setImage(UIImage(named: "tabbar_compose_icon_add_highlighted"), for: UIControl.State.highlighted);
        
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button"), for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "tabbar_compose_button_highlighted"), for: UIControl.State.highlighted);
        
        btn.backgroundColor = UIColor.red;
        
        // 如果有参数, 也不用加冒号, 他会自动添加
        btn.addTarget(self, action: #selector(self.didClickedBtn), for: UIControl.Event.touchUpInside);
        
        return btn
    }()
    
    // MARK: - 按钮的点击方法
   @objc private func didClickedBtn(btn: UIButton) {
        print(btn);
    }
     
}
