//
//  TextField.swift
//  Versole
//
//  Created by Soomro Shahid on 2/21/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

@IBDesignable class TextField: UITextField {


//    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
//    @IBInspectable var borderWidth: CGFloat = 0
//    @IBInspectable var cornerRadius: CGFloat = 0
    
    @IBInspectable var borderColor: UIColor = UIColor.clearColor() {
        didSet {
            layer.borderColor = borderColor.CGColor
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
}
