//
//  UIBarButtonItem+Category.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/14.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func createBtn(imageName: String, target: Any?, sction: Selector) -> UIBarButtonItem
    {
        let btn = UIButton();
        btn.setImage(UIImage(named: imageName), for: UIControl.State.normal);
        btn.setImage(UIImage(named: imageName + "_highlighted"), for: UIControl.State.highlighted);
        btn.sizeToFit();
        btn.addTarget(target, action: sction, for: UIControl.Event.touchUpInside)
        let barBtn:UIBarButtonItem = UIBarButtonItem(customView: btn);
        return barBtn;
    }
}

