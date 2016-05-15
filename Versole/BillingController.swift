//
//  BillingController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/23/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Stripe
import EZAlertController
import Alamofire
class BillingController: BaseController {

    @IBOutlet weak var txtCardNumber: UITextField!
    @IBOutlet weak var txtExpireMonth: UITextField!
    @IBOutlet weak var txtExpireYear: UITextField!
    @IBOutlet weak var txtCCV: UITextField!
    var selectedMonth:Int!
    var selectedYear:Int!
    var eCurrentPickerType : ePickerType!
    var myPickerView:MyPickerView!
    var arrPicker:NSMutableArray = NSMutableArray()
    
    var creditBundle:CreditBundleData!
    
    override func viewDidLoad() {
        currentController = Controllers.Billing
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScheduleController.handler(_:)), name: "UpdatePickerData", object: nil)
        
        selectedMonth = 0
        selectedYear = 0
        

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = "Billing"
        btnShowCredit.setTitle(Singleton.sharedInstance.userData.creditCount, forState: .Normal)
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    @IBAction func monthClick(sender: AnyObject) {
        
        self.view.endEditing(true)
        eCurrentPickerType = ePickerType.ePickerTypeMonth
       ShowPicker("")
        print("month click")
    }
    @IBAction func yearClick(sender: AnyObject) {
        
        self.view.endEditing(true)
        eCurrentPickerType = ePickerType.ePickerTypeYear
        ShowPicker("")
        print("year click")
    }
    func ShowPicker(sender: AnyObject) {
        
        
        self.myPickerView = MyPickerView.init(arrToShow: nil, currentSelectedData: nil, superFrame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
       // let arrCounter:NSMutableArray = NSMutableArray()
        
        if(eCurrentPickerType == ePickerType.ePickerTypeMonth) {
            
            arrPicker.removeAllObjects()
            getMonths("January")
            getMonths("Feburary")
            getMonths("March")
            getMonths("April")
            getMonths("May")
            getMonths("June")
            getMonths("July")
            getMonths("August")
            getMonths("September")
            getMonths("October")
            getMonths("November")
            getMonths("December")
            
            
        }
        else if(eCurrentPickerType == ePickerType.ePickerTypeYear) {
           
            arrPicker.removeAllObjects()
            for index in 2016..<2027 {
                
                let object:NSMutableDictionary!  = [ : ]
                object.setValue(String(index), forKey: "title")
                arrPicker.addObject(object)
            }
        }
        
        myPickerView.changeDataArray(arrPicker)
        self.view!.addSubview(myPickerView)
        self.view.bringSubviewToFront(myPickerView)
        //txtExpireMonth.inputView = myPickerView
    }
    
    func getMonths(month:String) {
        
        let object:NSMutableDictionary!  = [ : ]
        object.setValue(month, forKey: "title")
        arrPicker.addObject(object)
        
    }
    func handler(notObject: NSNotification) {
        print("MyNotification was handled")
        print(notObject.object)
        if (notObject.object != nil) {
            
            let countValue = notObject.object as! Int
            let data = arrPicker[countValue] as! NSMutableDictionary
            if(eCurrentPickerType == ePickerType.ePickerTypeMonth) {
                print(countValue)
                selectedMonth = countValue+1
                txtExpireMonth.text = data.valueForKey("title") as? String
            }
            else if(eCurrentPickerType == ePickerType.ePickerTypeYear) {
                print(countValue)
                
                
                selectedYear = Int(data.valueForKey("title") as! String)
                print(selectedYear)
                txtExpireYear.text = data.valueForKey("title") as? String
            }
        }
        
//        let countValue = notObject.object as! Int
//        
//        self.btnSelectedCounter!.setTitle(String(countValue), forState: .Normal)
//        print(self.arrList)
//        let data = self.arrList!.objectAtIndex(self.indexPathSelectedCounter!.row) as! NSMutableDictionary
//        data.setValue(countValue, forKey: "count")
//        
//        
//        
        self.myPickerView?.removeFromSuperview()
    }
    @IBAction func payToStripe(sender: AnyObject) {
        
        txtCardNumber.text = "4242424242424242"
        txtExpireMonth.text = "8"
        txtCCV.text = "123"
        txtExpireYear.text = "2020"
        selectedMonth = 8
        selectedYear = 2020
        if(!HelperMethods.validateStringLength(txtCardNumber.text!) &&
            txtCardNumber.text?.characters.count != 16) {
            EZAlertController.alert("Alert", message: "Enter 16 digit card number")
            return
        }
        if (selectedMonth == 0) {
            EZAlertController.alert("Alert", message: "Select expiration month")
            return
        }
        if (selectedYear == 0) {
            EZAlertController.alert("Alert", message: "Select expiration year")
            return
        }
        if(!HelperMethods.validateStringLength(txtCCV.text!)) {
            EZAlertController.alert("Alert", message: "Enter CCV number")
            return
        }
        
        // Initiate the card
        let stripCard = STPCardParams()
        
        
//        let expMonth = UInt(txtExpireMonth.text!)
//        let expYear = UInt(txtExpireYear.text!)
        
        stripCard.number = txtCardNumber.text
        stripCard.cvc = txtCCV.text
        stripCard.expMonth = UInt(selectedMonth)
        stripCard.expYear =  UInt(selectedYear)
        
        var underlyingError: NSError?
        if STPCardValidator.validationStateForCard(stripCard) == .Valid {
            // the card is valid.
            print("error")
        }
        
        STPAPIClient.sharedClient().createTokenWithCard(stripCard, completion: { (token, error) -> Void in
            
            if error != nil {
                //self.handleError(error!)
                print(error!)
                return
            }
            
            
            self.postStripeTokenNow(token!)
        })
    }
    
    func postStripeToken(token: STPToken)  {
        
        let amountInCent = "300"
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/chargeCard"
        // firstname+lastname+email+Private Key
        var checksum = amountInCent +  token.tokenId + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["amountInCents": amountInCent,
                         "token": token.tokenId,
                         "description": "",
                         "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Requesting Server...")
        
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        
                        if (Int(data.code!) == 200) {
                            
                            self.userDefault.rm_setCustomObject(data.data![0], forKey: "userDetail")
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
    
    
    func postStripeTokenNow(token: STPToken) {
        //Singleton.sharedInstance.userData.userId!
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/addmoreCredit"
        // firstname+lastname+email+Private Key
        var checksum = Singleton.sharedInstance.userData.userId! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        //creditedAmount": "2.5"
        let parameter = ["userId": Singleton.sharedInstance.userData.userId!,
                         "creditedAmount":creditBundle.creditCount!,
                         "checksum": checksum]
        
        print(parameter)
        
        showNormalHud("Waiting...")
        
        Alamofire.request(.POST, URL, parameters: parameter)
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = AddCreditBase.init(object: value)
                        
                        if (Int(data.code!) == 200) {
                        
                           let userDetail = self.userDefault.rm_customObjectForKey("userDetail") as! UserData
                            print(userDetail.creditCount)
                            userDetail.creditCount = data.userCredit
                            self.userDefault.rm_setCustomObject(userDetail, forKey: "userDetail")
                            let userDetail1 = self.userDefault.rm_customObjectForKey("userDetail") as! UserData
                            print(userDetail1.creditCount)
                            Singleton.sharedInstance.userData.creditCount = userDetail.creditCount
                        }
                        else {
                            EZAlertController.alert("Alert", message: data.msg!)
                        }
                        
                    }
                case .Failure(let error):
                    print(error)
                    
                }
                
        }
        
        
//        let URL = "http://localhost/donate/payment.php"
//        let params = ["stripeToken": token.tokenId,
//                      "amount": self.amountTextField.text.toInt()!,
//                      "currency": "usd",
//                      "description": self.emailTextField.text]
//        
//        let manager = AFHTTPRequestOperationManager()
//        manager.POST(URL, parameters: params, success: { (operation, responseObject) -> Void in
//            
//            if let response = responseObject as? [String: String] {
//                UIAlertView(title: response["status"],
//                    message: response["message"],
//                    delegate: nil,
//                    cancelButtonTitle: "OK").show()
//            }
//            
//        }) { (operation, error) -> Void in
//            self.handleError(error!)
//        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        print("deinit")
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
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
