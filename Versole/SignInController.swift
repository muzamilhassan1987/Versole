//
//  SignInController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/21/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import EZAlertController
import Alamofire
import RMMapper
class SignInController: BaseController {

    @IBOutlet var txtEmail:UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var  distanceConstrain:NSLayoutConstraint!
    override func viewDidLoad() {
        
        self.currentController = Controllers.SignIn;
        
    
        super.viewDidLoad()
        
//        txtEmail.layer.cornerRadius=8.0
//        txtEmail.layer.masksToBounds=true
//        txtEmail.layer.borderColor=UIColor.redColor().CGColor
//        txtEmail.layer.borderWidth=2.0

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = "Sign In"
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
//        if (self.userDefault.valueForKey("isLogin") != nil) {
//            
//            let  isLogin = self.userDefault.valueForKey("isLogin") as! Bool
//            if (isLogin == true) {
//                Singleton.sharedInstance.userData = self.userDefault.rm_customObjectForKey("userDetail") as! UserData
//                let userEmail = self.userDefault.valueForKey("userEmail") as! String
//                let userPassword = self.userDefault.valueForKey("userPassword") as! String
//                
//                txtEmail.text = userEmail
//                txtPassword.text = userPassword
//                loginPressed()
//            }
//        }
        
        
        
    }
    override func  updateViewConstraints() {
        
        super.updateViewConstraints()
        if (UIScreen.mainScreen().bounds.size.height == 480) {
            distanceConstrain.constant = 30
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginPressed() {
        

        //txtEmail.text = "m@m.com"
        //txtEmail.text = "a@a.com"
     //   txtEmail.text = "tt@txt.com"
        txtEmail.text = "q@q.com"
        txtPassword.text = "123456"
        
        if(!HelperMethods.validateStringLength(txtEmail.text!)) {
            EZAlertController.alert("Alert", message: "Enter email")
            return
        }
        if(!HelperMethods.isValidEmail(txtEmail.text!)) {
            EZAlertController.alert("Alert", message: "Enter valid email")
            return
        }
        if(!HelperMethods.validateStringLength(txtPassword.text!)) {
            EZAlertController.alert("Alert", message: "Enter password")
            return
        }
        
        callLoginService()
        
//        NSNotificationCenter.defaultCenter().postNotificationName("login", object: nil)
    }
    
    func makeCall(){
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/loginByEmail"
        // firstname+lastname+email+Private Key
        var checksum = txtEmail.text! +  txtPassword.text! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["email": txtEmail.text!,
                         "password": txtPassword.text!,
                         "deviceType": "iOS",
                         "deviceId": Singleton.sharedInstance.deviceToken,
                         "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Login in...")
        
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        
                        if (Int(data.code!) == 200) {
                            
                            self.userDefault.rm_setCustomObject(data.data![0], forKey: "userDetail")
                            self.userDefault.setValue(NSNumber(bool: true), forKey: "isLogin")
                            self.userDefault.setValue(self.txtEmail.text, forKey: "userEmail")
                            self.userDefault.setValue(self.txtPassword.text, forKey: "userPassword")
                            Singleton.sharedInstance.userData = data.data![0]
                            print(Singleton.sharedInstance.userData.address)
                            //                            let test = self.userDefault.rm_customObjectForKey("userDetail") as! UserData
                            //                            print(test.firstname)
                            //                            print(test.creditCount)
                            // print(userDefault.rm_customObjectForKey("userDetail"))
                            NSNotificationCenter.defaultCenter().postNotificationName("login", object: nil)
                        }
                        else {
                            EZAlertController.alert("Alert", message: data.msg!)
                        }
                        
                    }
                case .Failure(let error):
                    print(error)
                    
                }
                
        }
    }
    
    
    
    
    
    
    
    func callLoginService(){
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/loginByEmail"
        // firstname+lastname+email+Private Key
        var checksum = txtEmail.text! +  txtPassword.text! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["email": txtEmail.text!,
                         "password": txtPassword.text!,
                         "deviceType": "iOS",
                         "deviceId": Singleton.sharedInstance.deviceToken,
                         "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Login in...")
        
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        
                        if (Int(data.code!) == 200) {
                            
                            self.userDefault.rm_setCustomObject(data.data![0], forKey: "userDetail")
                            self.userDefault.setValue(NSNumber(bool: true), forKey: "isLogin")
                            self.userDefault.setValue(self.txtEmail.text, forKey: "userEmail")
                            self.userDefault.setValue(self.txtPassword.text, forKey: "userPassword")
                            Singleton.sharedInstance.userData = data.data![0]
                            print(Singleton.sharedInstance.userData.address)
//                            let test = self.userDefault.rm_customObjectForKey("userDetail") as! UserData
//                            print(test.firstname)
//                            print(test.creditCount)
                           // print(userDefault.rm_customObjectForKey("userDetail"))
                            NSNotificationCenter.defaultCenter().postNotificationName("login", object: nil)
                        }
                        else {
                            EZAlertController.alert("Alert", message: data.msg!)
                        }
                        
                    }
                case .Failure(let error):
                    print(error)
                    
                }
                
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
       
    }


}
