//
//  ZipErrorPopUp.swift
//  Versole
//
//  Created by Soomro Shahid on 5/14/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//


import UIKit

class ZipErrorPopUp: UIView {
    
    
    @IBOutlet weak var btnSubmit: UIButton!
    class func instanceFromNib() -> UIView {
        
        return UINib(nibName: "ZipErrorPopUp", bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
    //    @IBAction func buyCredtit() {
    //
    //
    //    }
    @IBAction func cancelPopUp() {
        
        self.removeFromSuperview()
    }
    
    
}