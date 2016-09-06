//
//  OrderConfirmController.swift
//  Versole
//
//  Created by Soomro Shahid on 5/25/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import EZAlertController
import Alamofire
class OrderConfirmController: BaseController {

    
    @IBOutlet weak var lblTitleOrder: UILabel!
    
    var selectedOrder:HistoryOrderOrderHistory!
    var eSelectedOrderType:eOrderType!
    override func viewDidLoad() {
        
        currentController = Controllers.OrderConfirmation
        super.viewDidLoad()

        eSelectedOrderType = eOrderType(rawValue: Singleton.sharedInstance.objItem.valueForKey("orderType") as! Int)
        if (eSelectedOrderType == eOrderType.eOrderTypeDonate) {
            lblTitleOrder.text = "Thank you for your donation!"
        }
        else if (eSelectedOrderType == eOrderType.eOrderTypeRepair) {
            lblTitleOrder.text = "Thank you for your order!"
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func modifyOrder() {
     
        
        
    }
    
    @IBAction func cancel() {
        
        EZAlertController.alert("Alert", message: "Are you sure you want to cancel order", buttons: ["Yes", "No"]) { (alertAction, position) -> Void in
            if position == 0 {
                self.cancelConfirmOrder()
            } else if position == 1 {
                print("Second button clicked")
            }
        }
    }
    
    
    func cancelConfirmOrder() {
        
        print(selectedOrder.pickUpDate)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let selectedDate = dateFormatter.dateFromString(selectedOrder.pickUpDate!)
        
        let now = NSDate()
        let orderDay = NSCalendar.currentCalendar().compareDate(now, toDate: selectedDate!,
                                                                toUnitGranularity: .Day)
        
        switch orderDay {
        case .OrderedDescending:
            
            EZAlertController.alert("Alert", message: "You cannot delete old orders")
            print("DESCENDING")//Previous
            return
            
            
        case .OrderedAscending:
            print("ASCENDING")//Next
            break
            
            
        case .OrderedSame:
            print("SAME")
            let hour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
            print(hour)
            if (hour >= 17) {
                
                let controller = self.storyboard!.instantiateViewControllerWithIdentifier("OrderCancelController") as! OrderCancelController
//                controller.cancelTitle = "Oops!"
                controller.cancelTitle = "Alert"
                self.navigationController?.pushViewController(controller, animated: true)
                return
            }
            break
            
            
        }
        
        
        
        var orderId = ""
        orderId = self.selectedOrder.orderId!
        var checksum = orderId +  "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["userId": Singleton.sharedInstance.userData.userId!,
                         "orderId": orderId,
                         "checksum": checksum]
        
        self.cancelOrder(parameter)
        
        
        
        
        
    }
    
    func cancelOrder(param:AnyObject) {
        
        self.view.endEditing(true)
        showNormalHud("Deleting Order...")
        let URL: String = "http://66.147.244.103/~versolec/api_v1/cancelOrder"
        Alamofire.request(.POST, URL, parameters: param as? [String : AnyObject])
            .responseJSON { response in
                self.removeNormalHud()
                //self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = UserBase.init(object: value)
                        //self.view.makeToast(data.msg!, duration: 3.0, position: .Center)
                        if (Int(data.code!) == 200) {
                            
                            //NSNotificationCenter.defaultCenter().postNotificationName("deleteOrder", object: self)
                            //self.appDelegate.window!.makeToast(data.msg!, duration: 2.0, position: .Center)
                            //self.navigationController?.popViewControllerAnimated(true)
                            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("OrderCancelController") as! OrderCancelController
                            controller.cancelTitle = "Cancelled!"
                            self.navigationController?.pushViewController(controller, animated: true)
                            
                        }
                        else if (Int(data.code!) == 202) {
                            
                        }
                        else {
                            
                        }
                        
                        print(data.code!)
                        print(data.msg!)
                        print(data.status!)
                        
                    }
                case .Failure(let error):
                    print(error)
                    EZAlertController.alert("Alert", message: error.localizedDescription)
                }
                
        }
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
