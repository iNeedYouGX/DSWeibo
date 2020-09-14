//
//  VisitorView.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/9.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

// 1创建协议
protocol VisitorViewDelegate {
    // 登陆
    func loginWillClicked();
    // 注册
    func registerWillClicked();
}

class VisitorView: UIView {
    
    
    // 2设置代理人
    var delegate: VisitorViewDelegate?;
    
    // MARK: - 设置各个界面显示的状态
    func setupVisitorInfo(isHome: Bool, imageName: String, message: String) {
        iconImageView.isHidden = !isHome;
        homeIcon.image = UIImage(named: imageName);
        messageLabel.text = message;
        
        if (isHome) { // 转圈
            startAnimation()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame);
        
        backgroundColor = UIColor.green;
        
        addSubview(iconImageView);
        addSubview(homeIcon);
        addSubview(messageLabel);
        addSubview(loginBtn);
        addSubview(registerBtn);
        
    }
    
    /// Swift推荐我们自定义控件要么是纯代码, 要么就是xib/storyboard
    required init?(coder: NSCoder) {
        // 如果通过xib/storyboard创建, 就会崩溃
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 动画
    func startAnimation()  {
        // 1. 创建动画
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        
        // 2. 设置属性
        animation.toValue = 2 * Double.pi;
        animation.repeatCount = MAXFLOAT;
        animation.duration = 20;
        
        // 2.1 隐藏显示之后, 动画会默认消失
        animation.isRemovedOnCompletion = false;
        
        // 3. 添加动画
        iconImageView.layer.add(animation, forKey: nil);
        
    }
    
    // MARK: - 懒加载各种控件
    lazy var iconImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_smallicon"))
        iv.center = CGPoint(x: UIScreen.main.bounds.size.width / 2.0, y: UIScreen.main.bounds.size.height / 2.0);
        return iv;
    }()
    
    lazy var homeIcon: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "visitordiscover_feed_image_house"))
        iv.center = CGPoint(x: UIScreen.main.bounds.size.width / 2.0, y: UIScreen.main.bounds.size.height / 2.0);
        return iv
    }()
    
    lazy var messageLabel: UILabel = {
       let lb = UILabel()
        lb.text = "关注一些人，回这里看看有什么惊喜";
        lb.frame.size.width = 170;
        lb.textColor = UIColor.gray;
        lb.numberOfLines = 0
        lb.sizeToFit();
        lb.font = UIFont().withSize(12);
        lb.center = CGPoint(x: UIScreen.main.bounds.size.width / 2.0, y: 0);
        lb.frame.origin.y = iconImageView.frame.origin.y + iconImageView.frame.size.height;
        return lb;
    }()
    
    lazy var loginBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("登录", for: UIControl.State.normal);
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.gray, for: UIControl.State.normal);
        btn.sizeToFit();
        btn.frame.size.width = 120;
        btn.frame.origin.y = messageLabel.frame.origin.y + messageLabel.frame.size.height;
        btn.frame.origin.x = 100;
        
        btn.addTarget(self, action: #selector(loginClicked), for: UIControl.Event.touchUpInside)
        return btn;
    }()
    
    lazy var registerBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("注册", for: UIControl.State.normal)
        btn.setBackgroundImage(UIImage(named: "common_button_white_disable"), for: UIControl.State.normal)
        btn.setTitleColor(UIColor.gray, for: UIControl.State.normal);
        btn.sizeToFit();
        btn.frame.size.width = 100;
        btn.frame.origin.y = loginBtn.frame.origin.y;
        btn.frame.origin.x = loginBtn.frame.origin.x + loginBtn.frame.size.width + 20;
        btn.addTarget(self, action: #selector(registerClicked(btn:)), for: UIControl.Event.touchUpInside)
        return btn;
    }()
    
    // MARK: - 点击方法
    @objc func loginClicked(btn: UIButton) {
        delegate?.loginWillClicked();
    }
    
    @objc func registerClicked(btn: UIButton) {
        delegate?.registerWillClicked();
    }
    
}
