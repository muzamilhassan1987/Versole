//
//  ResetPasswordController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/27/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import EZAlertController
import Alamofire
class ResetPasswordController: BaseController {

    
    @IBOutlet weak var txtEmail: UITextField!
    override func viewDidLoad() {
        currentController = Controllers.ResetPassword
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = "Reset Password"
        
    }
    
    @IBAction func resetPassword(sender: UIButton) {
    
        if(!HelperMethods.validateStringLength(txtEmail.text!)) {
            EZAlertController.alert("Alert", message: "Enter email")
            return
        }
        if(!HelperMethods.isValidEmail(txtEmail.text!)) {
            EZAlertController.alert("Alert", message: "Enter valid email")
            return
        }
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/resetPassword"
        var checksum = txtEmail.text! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["email": txtEmail.text!,
                         "checksum": checksum]
        
        showNormalHud("Wait...")
        
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        print(value.valueForKey("msg"))
                        if (Int(data.code!) == 200) {
                            EZAlertController.alert("Alert", message: data.msg!, acceptMessage: "OK") { () -> () in
                                self.navigationController?.popViewControllerAnimated(true)
                            }
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
