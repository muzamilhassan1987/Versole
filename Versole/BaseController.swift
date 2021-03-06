//
//  BaseController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/20/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit   
import Alamofire
import JGProgressHUD
class BaseController: UIViewController {

    var currentController: Controllers!
    var lblTitle: UILabel!
    var btnShowCredit:UIButton! = UIButton(type: .Custom)
    var HUD:JGProgressHUD! = nil
    let userDefault = NSUserDefaults.standardUserDefaults()
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController!.navigationBar.translucent = false
        for view in (self.navigationController?.navigationBar.subviews)! {
            
            if (view.tag == 10) {
                lblTitle = view as! UILabel
            }
        }
        if (lblTitle == nil) {
            ////print(self.navigationController?.navigationBar.subviews)
            lblTitle = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, (self.navigationController?.navigationBar.frame.size.height)!))
            lblTitle.textAlignment = NSTextAlignment.Center
            //lblTitle.text = "Test"
            lblTitle.font = UIFont (name: "Avenir-Medium", size: 18)
            lblTitle.textColor = UIColor.whiteColor()
            lblTitle.tag = 10
            self.navigationController?.navigationBar.addSubview(lblTitle)
            
        }

        //print(self.navigationController?.navigationBar.tintColor)
        
        if (currentController == Controllers.SignIn ||
            currentController == Controllers.SignUp ||
            currentController == Controllers.ResetPassword ||
            currentController == Controllers.ReviewOrder ||
            currentController == Controllers.HowItWork ||
            currentController == Controllers.PickDate ) {
            
            createBackarrow()
        }
        else if (currentController == Controllers.CancelOrder) {
            
            createHamburger()
            
        }
        else if (currentController == Controllers.Home) {
            
            createHamburger()
            
            createCreditButton()
            
        }
        else if (currentController == Controllers.Pricing) {
            
            createHamburger()
            
            createCreditButton()
        }
        else if (currentController == Controllers.ContactUs) {
            createHamburger()
        }
        else if (currentController == Controllers.Billing) {
            
            //print(self.navigationController?.viewControllers.count)
            if (self.navigationController?.viewControllers.count > 1) {
                createBackarrow()
            }
            else {
                createHamburger()
            }

            //createCreditButton()
            
        }
        else if (currentController == Controllers.OrderHistory) {
            //print(self.navigationController?.viewControllers)
            if (self.navigationController?.viewControllers.count > 2) {
                createBackarrow()
            }
            else {
                createHamburger()
            }
            
            
        }

        else if (currentController == Controllers.Profile) {
            createHamburger()
        }
        else if (currentController == Controllers.Share) {
            createHamburger()
        }
        else if (currentController == Controllers.BuyCredit) {
            
            if (self.navigationController?.viewControllers.count > 2) {
                createBackarrow()
            }
            else {
                createHamburger()
            }
            
            
        }
        else if (currentController == Controllers.Schedule) {
            
            createBackarrow()
            
            createCreditButton()
            
        }
        else if (currentController == Controllers.FAQ) {
            
            createHamburger()
        }
        else if (currentController == Controllers.OrderConfirmation) {
            
            createHamburger()
        }
        
    }
    
    func createHamburger()  {
        
        let imgBack: UIImage = UIImage(named: "hamburger")!
        let btnBack: UIButton = UIButton(type: .Custom)
        btnBack.bounds = CGRectMake(0, 0, imgBack.size.width, imgBack.size.height)
        btnBack.setImage(imgBack, forState: .Normal)
        btnBack.addTarget(self, action: #selector(BaseController.showLeftMenuPressed), forControlEvents: .TouchUpInside)
        let btnBackItem: UIBarButtonItem = UIBarButtonItem(customView: btnBack)
        self.navigationItem.leftBarButtonItem = btnBackItem
    }
    func createBackarrow()  {
        
        let imgBack: UIImage = UIImage(named: "backarrow")!
        let btnBack: UIButton = UIButton(type: .Custom)
        btnBack.bounds = CGRectMake(0, 0, imgBack.size.width+20, imgBack.size.height+20)
        btnBack.setImage(imgBack, forState: .Normal)
        btnBack.addTarget(self, action: #selector(BaseController.popViewController), forControlEvents: .TouchUpInside)
        let btnBackItem: UIBarButtonItem = UIBarButtonItem(customView: btnBack)
        
        self.navigationItem.leftBarButtonItem = btnBackItem
    }
    
    func createCreditButton() {
        
        let imgCredit: UIImage = UIImage(named: "btnshowcredit")!
        //btnShowCredit: UIButton = UIButton(type: .Custom)
        btnShowCredit.bounds = CGRectMake(0, 0, imgCredit.size.width, imgCredit.size.height)
        btnShowCredit.setBackgroundImage(imgCredit, forState: .Normal)
        btnShowCredit.addTarget(self, action: #selector(BaseController.showBuyCreditScreen), forControlEvents: .TouchUpInside)
        //btnShowCredit.setTitle("50", forState: .Normal)
        btnShowCredit.titleLabel?.font = UIFont.systemFontOfSize(10)
        let btnCreditItem: UIBarButtonItem = UIBarButtonItem(customView: btnShowCredit)
        self.navigationItem.rightBarButtonItem = btnCreditItem
    }
    
    func showBuyCreditScreen() {
        self.view.endEditing(true)
        Singleton.sharedInstance.isOrderProgress = false
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("BuyCreditsController") as! BuyCreditsController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func showLeftMenuPressed() {
        self.view.endEditing(true)
        self.menuContainerViewController.toggleLeftSideMenuCompletion { () -> Void in
            
        };
    }
    
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
    }
    func popViewController() {
        self.navigationController?.popViewControllerAnimated(true);
    }
    func showNormalHud(message : String) {
        HUD = JGProgressHUD.init(style: .Dark)
        HUD.textLabel.text = message
        HUD.showInView(self.view)
    }
    func removeNormalHud() {
        HUD.dismiss()
    }
    deinit {
        
        //print("Base Deinit")
    }
}

//class Animal {
//    var name:String!
//    func sound() {}
//    func eyeCount() -> Int{
//       return 2
//    }
//}
//
//class Giraffe : Animal {
//    
//    override func sound() {
//        //print("Giraffe sound")
//    }
//}
//class Pigeon : Animal {
//    override func sound() {
//        //print("Pigeon sound")
//    }
//}
//
//class Tuna : Animal {
//    override func sound() {
//        //print("Tuna sound")
//    }
//}
//    

