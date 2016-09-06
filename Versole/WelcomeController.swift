//
//  WelcomeController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/20/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
import EZAlertController
class WelcomeController: BaseController {

    
    override func viewDidLoad() {
    
        currentController = Controllers.Welcome
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = ""
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        if (self.userDefault.valueForKey("isLogin") != nil) {
            
            let  isLogin = self.userDefault.valueForKey("isLogin") as! Bool
            if (isLogin == true) {
                Singleton.sharedInstance.userData = self.userDefault.rm_customObjectForKey("userDetail") as! UserData
//                let userEmail = self.userDefault.valueForKey("userEmail") as! String
//                let userPassword = self.userDefault.valueForKey("userPassword") as! String
//
//                txtEmail.text = userEmail
//                txtPassword.text = userPassword
//                loginPressed()
                callLoginService()
            }
        }
        
        
        
    }
    
    
    func callLoginService(){
        
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/loginByEmail"
        // firstname+lastname+email+Private Key
        
        let userEmail = self.userDefault.valueForKey("userEmail") as! String
        let userPassword = self.userDefault.valueForKey("userPassword") as! String
        
        
        var checksum = userEmail +  userPassword + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["email": userEmail,
                         "password": userPassword,
                         "deviceType": "iOS",
                         "deviceId": Singleton.sharedInstance.deviceToken,
                         "checksum": checksum]
        
        //print(parameter)
        
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
                            Singleton.sharedInstance.userData = data.data![0]
                            //print(Singleton.sharedInstance.userData.address)
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
}

