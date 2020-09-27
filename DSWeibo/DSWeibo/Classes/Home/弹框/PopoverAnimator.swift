//
//  PopoverAnimator.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/21.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

let NotifGXPopoverAnimatorShow = "NotifGXPopoverAnimatorShow";
let NotifPopoverAnimatorDismiss = "NotifPopoverAnimatorDismiss";

class PopoverAnimator: NSObject {
    /// 记录当前是否是展开
    var isPresent: Bool = false
}

// MARK: - 利用代理来自定义弹出形式
extension PopoverAnimator: UIViewControllerTransitioningDelegate, UIViewControllerAnimatedTransitioning {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController?
    {
        return PopoverPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    // MARK: - 怎么利用代理来实现动画效果, 实现下面方法
    // 告诉系统谁来, 负责展现动画, 返回一个协议UIViewControllerAnimatedTransitioning
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        // 改变按钮的方向
        NotificationCenter.default.post(name: NSNotification.Name(NotifGXPopoverAnimatorShow), object: nil)
        // 控制弹出
        isPresent = true
        return self;
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        // 发通知改变按钮方向
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: NotifPopoverAnimatorDismiss), object: nil)
        // 控制dismiss
        isPresent = false
        return self
    }
    
    
    // UIViewControllerAnimatedTransitioning必须实现个两个方法
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5;
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // tovc: 被模态的
        // formVc: 发起人   特别注意, 这个字段, 会根据不用的形式互换
        let toVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let formVc = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        print(toVc as Any)
        print(formVc as Any)
        
        // toView: 被模态的View
        // formView: 发起人View 但是为 nil
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to);
        let formView = transitionContext.view(forKey: UITransitionContextViewKey.from);
        
        if (isPresent) {
            // 注意: 一定要自己添加到视图上, 这个代理自己显示之后, 系统鸡巴毛不做
            transitionContext.containerView.addSubview(toView!)
            
            // 自己动画
            toView!.transform = CGAffineTransform(scaleX: 1, y: 0)
            
            // 设置锚点
            toView!.layer.anchorPoint = CGPoint(x: 1, y: 0)
            
            UIView.animate(withDuration: 0.25, animations: {
                toView!.transform = CGAffineTransform.identity;
            }) { (_) in
                transitionContext.completeTransition(true)
            }
            
        } else {
            UIView.animate(withDuration: 0.25, animations: {
                // 注意: CGFloat是不准确的, 所以写0.0不好使
                formView!.transform = CGAffineTransform(scaleX:1.0, y: 0.00001)
            }) { (_) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
}
