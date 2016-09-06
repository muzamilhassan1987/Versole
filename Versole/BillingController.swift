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
    var eToController:eGotoToController!
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
        setCardDetails()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
    }
    
    func setCardDetails() {
        
        if (self.userDefault.valueForKey("isCardArray") != nil) {
            
            let  arrList = self.userDefault.valueForKey("isCardArray") as! NSMutableArray
            print(arrList)
            let predicate = NSPredicate(format: "SELF.userid == %@",Singleton.sharedInstance.userData.userId!)
            //let predicate = NSPredicate(format: "SELF.userid == %@","44")
            let results:NSArray = arrList.filteredArrayUsingPredicate(predicate)
            print(results)
            if(results.count == 0) {
                return
            }
            let obj = results[0]
            print(obj)
            txtCardNumber.text = obj.objectForKey("cardnumber") as? String
            txtExpireMonth.text = obj.objectForKey("cardmonth") as? String
            txtExpireYear.text = obj.objectForKey("cardyear") as? String
            txtCCV.text = obj.objectForKey("cardccv") as? String
            selectedYear = obj.objectForKey("selectedYear") as! Int
            selectedMonth = obj.objectForKey("selectedMonth") as! Int
        }
        
        
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
    
    func addCardDetails() {
        
        
        let  arrList:NSMutableArray
        let predicate:NSPredicate
        let results:NSArray
        
        if (self.userDefault.valueForKey("isCardArray") != nil) {
            arrList = (self.userDefault.valueForKey("isCardArray") as! NSMutableArray).mutableCopy() as! NSMutableArray
        }
        else {
            arrList = NSMutableArray()
        }
        let object:NSMutableDictionary!  = [ : ]
        object.setValue(txtCardNumber.text, forKey: "cardnumber")
        object.setValue(txtExpireMonth.text, forKey: "cardmonth")
        object.setValue(txtExpireYear.text, forKey: "cardyear")
        object.setValue(txtCCV.text, forKey: "cardccv")
        object.setValue(selectedYear, forKey: "selectedYear")
        object.setValue(selectedMonth, forKey: "selectedMonth")
        object.setValue(Singleton.sharedInstance.userData.userId, forKey: "userid")
        
        print(selectedYear)
        print(selectedMonth)
        print(arrList)
        predicate = NSPredicate(format: "SELF.userid == %@",Singleton.sharedInstance.userData.userId!)
        results = arrList.filteredArrayUsingPredicate(predicate)
        print(results)
        if(results.count > 0) {
            
            let index = arrList.indexOfObject(results[0])
            arrList.replaceObjectAtIndex(index, withObject: object)
        }
            
        else {
            arrList.addObject(object)
        }
        
        self.userDefault.setObject(arrList, forKey:"isCardArray")
        self.userDefault.synchronize()
      
        
        
        
        let  testarray = self.userDefault.valueForKey("isCardArray") as! NSMutableArray
        print(testarray)
    }
    
    /*
    
    @IBAction func payToStripe(sender: AnyObject) {
        showNormalHud("Wait fetching token...")
        
        addCardDetails()
//        let arr:NSMutableArray = NSMutableArray()
//        
//        let object:NSMutableDictionary!  = [ : ]
//        object.setValue(txtCardNumber.text, forKey: "cardnumber")
//        object.setValue(txtExpireMonth.text, forKey: "cardmonth")
//        object.setValue(txtExpireYear.text, forKey: "cardyear")
//        object.setValue(txtCCV.text, forKey: "cardccv")
//        object.setValue(Singleton.sharedInstance.userData.userId, forKey: "userid")
//        arr.addObject(object)
//        
//        userDefault.setObject(arr, forKey: "isCardArray")
//        userDefault.synchronize()
//        
//        let arrayOfImages = userDefault.objectForKey("isCardArray")
//        print(arrayOfImages)
//        
//        print(txtCardNumber.text)
//        print(txtExpireMonth.text)
//        print(txtExpireYear.text)
//        print(txtCCV.text)
        
        
       // addMoreCredit()
    }
    */
    @IBAction func payToStripe(sender: AnyObject) {
        
        
//        txtCardNumber.text = "4242424242424242"
//        txtExpireMonth.text = "8"
//        txtCCV.text = "123"
//        txtExpireYear.text = "2020"
//        selectedMonth = 8
//        selectedYear = 2020
        
        
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
        
        
        self.view.endEditing(true)
        showNormalHud("Wait fetching token...")
        
        if STPCardValidator.validationStateForCard(stripCard) == .Valid {
            // the card is valid.
            print("error")
        }
        
        STPAPIClient.sharedClient().createTokenWithCard(stripCard, completion: { (token, error) -> Void in
            
            if error != nil {
                //self.handleError(error!)
                print(error!)
                self.removeNormalHud()
                EZAlertController.alert("Alert", message: (error?.localizedDescription)!)
                return
            }
            
            
            self.sendTokenToServer(token!)
//            self.postStripeTokenNow(token!)
        })
    }
 
    func sendTokenToServer(token: STPToken)  {
        
        let amountInCent = Int(creditBundle.price!)!*100
        print(amountInCent)
        //amountInCent = 100
        self.view.endEditing(true)
        let URL: String = "http://66.147.244.103/~versolec/api_v1/chargeCard"
        // firstname+lastname+email+Private Key
        var checksum = String(amountInCent) +  token.tokenId + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["amountInCents": amountInCent,
                         "token": token.tokenId,
                         "description": "",
                         "checksum": checksum]
        
        print(parameter)
        removeNormalHud()
        showNormalHud("Wait payment in progress...")
        
        Alamofire.request(.POST, URL, parameters: parameter as? [String : AnyObject])
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        print(value)
                        print(response)
                        print(response.result)
                        let data = UserBase.init(object: value)
                        print(data)
                        if (data.status != nil) {
                            if (data.status! == "succeeded") {
                                self.addCardDetails()
                                self.addMoreCredit()
                            }
                            else {
                                
                            }
                        }
                        else {
                            if ( value.valueForKey("error") != nil) {
                                EZAlertController.alert("Alert", message:value.valueForKey("error")!.valueForKey("message")! as! String)
                            }
                           // EZAlertController.alert("Alert", message: (error?.localizedDescription)!)
                        }
                        
                        
                        
                    }
                case .Failure(let error):
                    print(error)
                    
                }
                
        }
    }
    
    
    func addMoreCredit() {
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
        removeNormalHud()
        showNormalHud("Adding credit to account...")
        
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
                            Singleton.sharedInstance.userData.creditCount = userDetail.creditCount
                            
                            EZAlertController.alert("Alert", message: data.msg!, acceptMessage: "OK") { () -> () in
                                //self.gotoController()
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
    
    
        func gotoController() {
            
            let count = self.navigationController?.viewControllers.count
            
            
            if(self.eToController == eGotoToController.eGotoToControllerSchedule) {
            
                for index in 0.stride(to: count!, by: +1) {
                    if(self.navigationController?.viewControllers[index].isKindOfClass(ScheduleController) == true) {
                        
                        self.navigationController?.popToViewController(self.navigationController!.viewControllers[index] as! ScheduleController, animated: true)
                        
                        break;
                    }
                }
            
            
            }
            
           
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
