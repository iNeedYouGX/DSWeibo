//
//  PopoverPresentationController.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/16.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

class PopoverPresentationController: UIPresentationController {
    /**
     presentedViewController: 被展示的控制器
     presentingViewController: 发起的控制器
     */
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        
        presentedViewController.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    }
    
    // MARK: - 在将要出现的方法中修改尺寸
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        
        presentedView!.frame = CGRect(x: 100, y: 56, width: 200, height: 200);
        
        containerView?.insertSubview(masksView, at: 0);
    }
    
    // MARK: - 插入一个蒙版
    lazy var masksView: UIView = {
       let masksView = UIView()
        masksView.frame = UIScreen.main.bounds;
        masksView.backgroundColor = UIColor(white: 0.0, alpha: 0.7);
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissaView))
        masksView.addGestureRecognizer(tap);
        return masksView;
    }()
    
   @objc func dismissaView() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }

}
