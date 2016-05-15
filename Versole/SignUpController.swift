//
//  SignUpController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/22/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
import CryptoSwift
import EZAlertController


class SignUpController: BaseController {

    var popUp:ZipErrorPopUp!
    
    var profileData:UserData!
    
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtZipCode: UITextField!
    @IBOutlet weak var txtAPT: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var imgPassword: UIImageView!
    
    override func viewDidLoad() {
        
        
        if(self.menuContainerViewController == nil) {
            currentController = Controllers.SignUp
            btnSignUp.setTitle("Sign Up", forState: .Normal)
            btnCancel.setTitle("Password?", forState: .Normal)
            print("Not loaded")
        }
        else {
            print("loaded")
            currentController = Controllers.Profile
            print(self.menuContainerViewController)
            btnSignUp.setTitle("Save", forState: .Normal)
            btnCancel.setTitle("Cancel", forState: .Normal)
            txtEmail.userInteractionEnabled = false
            txtPassword.hidden = true
            imgPassword.hidden = true
            loadProfile()
            
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = "Sign Up"
        
        if(currentController == Controllers.Profile) {
            lblTitle.text = "Profile"
        }
    }
    // let test = userDefault.rm_customObjectForKey("userDetail") as! UserData
    // print(test.firstname)
    // print(userDefault.rm_customObjectForKey("userDetail"))
    
    func loadProfile(){
        
        profileData = userDefault.rm_customObjectForKey("userDetail") as! UserData
        txtName.text = profileData.firstname
        txtLastName.text = profileData.lastname
        txtEmail.text = profileData.email
        txtPhoneNumber.text = profileData.phone
        txtAddress.text = profileData.address
        txtAPT.text = profileData.apt
        txtZipCode.text = profileData.zipcode
        txtPassword.text = profileData.password
    }
    

    @IBAction func signUpUser(){
        
//        txtName.text = "Ed"
//        txtLastName.text = "were"
//        //txtEmail.text = "mmmm@mmmm.com"
//        txtPhoneNumber.text = "123"
//        txtAddress.text = "12weds1"
//        txtAPT.text = "1111"
//        txtZipCode.text = "223"
//        txtPassword.text = "123456"
        
       //EZAlertController.alert("Alert", message: "")
        if(!HelperMethods.validateStringLength(txtName.text!)) {
            EZAlertController.alert("Alert", message: "Enter first name")
            return
        }
        if(!HelperMethods.validateStringLength(txtLastName.text!)) {
            EZAlertController.alert("Alert", message: "Enter last name")
            return
        }
        if(!HelperMethods.validateStringLength(txtEmail.text!)) {
            EZAlertController.alert("Alert", message: "Enter email")
            return
        }
        if(!HelperMethods.isValidEmail(txtEmail.text!)) {
            EZAlertController.alert("Alert", message: "Enter valid email")
            return
        }
        if(!HelperMethods.validateStringLength(txtPhoneNumber.text!)) {
            EZAlertController.alert("Alert", message: "Enter phone number")
            return
        }
        if(!HelperMethods.validateStringLength(txtAddress.text!)) {
            EZAlertController.alert("Alert", message: "Enter address")
            return
        }
        if(!HelperMethods.validateStringLength(txtAPT.text!)) {
            EZAlertController.alert("Alert", message: "Enter APT")
            return
        }
        if(!HelperMethods.validateStringLength(txtZipCode.text!)) {
            EZAlertController.alert("Alert", message: "Enter zip code")
            return
        }
        if(!HelperMethods.validateStringLength(txtPassword.text!)) {
            EZAlertController.alert("Alert", message: "Enter password")
            return
        }
        if(txtPassword.text?.characters.count < 6) {
            EZAlertController.alert("Alert", message: "Password length must be greater than five characters")
            return
        }
        
        if(currentController == Controllers.SignUp) {
            callSignUpService()
        }
        else if(currentController == Controllers.Profile) {
            callUpdateProfileService()
        }
        
    }
    
    func callSignUpService(){
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/signup"
       // firstname+lastname+email+Private Key
        var checksum = txtName.text! + txtLastName.text! + txtEmail.text! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["firstname": txtName.text!,
                          "lastname": txtLastName.text!,
                          "email": txtEmail.text!,
                          "phone": txtPhoneNumber.text!,
                          "address": txtAddress.text!,
                          "apt": txtAPT.text!,
                          "deviceType": "iOS",
                          "deviceId": "dssdds",
                          "zipcode": txtZipCode.text!,
                          "password": txtPassword.text!,
                          "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Registering user...")
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        
                        if (Int(data.code!) == 200) {
                            EZAlertController.alert("Alert", message: data.msg!, acceptMessage: "OK") { () -> () in
                                self.navigationController?.popViewControllerAnimated(true)
                            }
                        }
                        else if (Int(data.code!) == 202) {
                            self.showZipCodePopUp()
                        }
                        else {
                            EZAlertController.alert("Alert", message: data.msg!)
                        }
                        
                        print(data.code!)
                        print(data.msg!)
                        print(data.status!)
                        
                    }
                case .Failure(let error):
                    print(error)
                    
                }

        }
    }
//    "checksum":MD5($userId+firstname+lastname+phone+address+apt+zipcode+Private Key),
//    
//}
    
    func callUpdateProfileService(){
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/editProfile"
        // firstname+lastname+email+Private Key
        var checksum = profileData.userId! + txtName.text! + txtLastName.text! + txtPhoneNumber.text!
        checksum = checksum + txtAddress.text! + txtAPT.text! + txtZipCode.text! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["userHash": profileData.userHash!,
                         "userId": profileData.userId!,
                         "firstname": txtName.text!,
                         "lastname": txtLastName.text!,
                         "phone": txtPhoneNumber.text!,
                         "address": txtAddress.text!,
                         "apt": txtAPT.text!,
                         "zipcode": txtZipCode.text!,
                         "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Updating user...")
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        
                        if (Int(data.code!) == 200) {
                            EZAlertController.alert("Alert", message: data.msg!, acceptMessage: "OK") { () -> () in
                                
                                self.userDefault.rm_setCustomObject(data.data![0], forKey: "userDetail")
                                self.loadProfile()
                            }
                        }
                        else {
                            EZAlertController.alert("Alert", message: data.msg!)
                        }
                        
                        print(data.code!)
                        print(data.msg!)
                        print(data.status!)
                        
                    }
                case .Failure(let error):
                    print(error)
                    
                }
                
        }
    }
    
    
    
    
    func showZipCodePopUp() {
        
        self.popUp = ZipErrorPopUp.instanceFromNib() as! ZipErrorPopUp
        self.popUp.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(self.popUp)
        
        self.popUp.btnSubmit.addEventHandler({ AnyObject in
            
                self.callSubmitZipcodeService()
            
            }, forControlEvents: .TouchUpInside)
        
    }
    
    
    func callSubmitZipcodeService(){
        
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/requestZipcode"
        // firstname+lastname+email+Private Key
        var checksum =  txtZipCode.text! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["requestedZip": txtZipCode.text!,
                         "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Sending Zipcode" + "'" + txtZipCode.text! + "'" + "...")
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        
                       EZAlertController.alert("Alert", message: data.msg!)
                        self.popUp.removeFromSuperview()
                        print(data.code!)
                        print(data.msg!)
                        print(data.status!)
                        
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
