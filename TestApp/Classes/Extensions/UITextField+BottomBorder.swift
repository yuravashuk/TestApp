//
//  UITextField+BottomBorder.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-20.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setBottomBorder() {
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGray.cgColor
        border.frame = CGRect(x: 0, y: frame.size.height - width, width:  frame.size.width, height: frame.size.height)
        
        border.borderWidth = width
        layer.addSublayer(border)
        layer.masksToBounds = true
    }
    
}
