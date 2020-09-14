//
//  titleBtn.swift
//  DSWeibo
//
//  Created by JsonBourne on 2020/9/14.
//  Copyright © 2020 JsonBourne. All rights reserved.
//

import UIKit

class TitleBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        setImage(UIImage(named: "navigationbar_arrow_down"), for: UIControl.State.normal);
        setImage(UIImage(named: "navigationbar_arrow_up"), for: UIControl.State.selected);
        setTitle("极客江南", for: UIControl.State.normal);
        setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 条用了两次, 除以2
//        titleLabel?.frame = titleLabel!.frame.offsetBy(dx: -imageView!.frame.width * 0.5, dy: 0);
//        imageView?.frame = imageView!.frame.offsetBy(dx: titleLabel!.frame.width * 0.5, dy: 0)
        
        titleLabel?.frame.origin.x = 0;
        imageView?.frame.origin.x = titleLabel!.frame.width;
        
    }
}
