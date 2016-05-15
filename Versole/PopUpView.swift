//
//  PopUpView.swift
//  Versole
//
//  Created by Soomro Shahid on 5/12/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class PopUpView: UIView {

    
    @IBOutlet weak var btnBuyCredit: UIButton!
    class func instanceFromNib(name : String) -> UIView {
        
       return UINib(nibName: name, bundle: nil).instantiateWithOwner(nil, options: nil)[0] as! UIView
    }
    
    
    
    
//    @IBAction func buyCredtit() {
//        
//        
//    }
    @IBAction func cancelPopUp() {
        
        self.removeFromSuperview()
    }
    
    
}
    