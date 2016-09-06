//
//  ReviewOrderController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/4/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
import EZAlertController
import Toast_Swift

class ReviewOrderController: BaseController {

    @IBOutlet weak var tblListing: UITableView!
    var eSelectedOrderType:eOrderType!
    var eSelectedReviewOrderType:eReviewOrderType!
    @IBOutlet weak var btnRepair_Donate: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    var arrList:NSMutableArray? = NSMutableArray()
    var isNewOrder:Bool?
    //var AssociatedObjectHandle: UInt8 = 0
    //var btnSelectedCounter:UIButton!
    //var indexPathSelectedCounter:NSIndexPath!
    //var myPickerView:MyPickerView!
    var totalItems:Int!
    var creditUsed:String!
    var selectedOrder:HistoryOrderOrderHistory!
    override func viewDidLayoutSubviews() {
        
//        if(isNewOrder == false) {
//            btnCancel.center = CGPoint(x: self.view.center.x, y: btnCancel.center.y)
//        }
    }
    
    override func viewDidLoad() {
        
        
        currentController = Controllers.ReviewOrder
        super.viewDidLoad()
        tblListing.delaysContentTouches = false
        totalItems = 0
        
        isNewOrder = Singleton.sharedInstance.objItem.valueForKey("isNewOrder") as? Bool

        
        
        Singleton.sharedInstance.objItem.setValue(NSNumber(bool:true), forKey: "isNewOrder")
        
        
        print(Singleton.sharedInstance.objItem.valueForKey("orderType"))
        eSelectedOrderType = eOrderType(rawValue: Singleton.sharedInstance.objItem.valueForKey("orderType") as! Int)
        
        if (eSelectedOrderType == eOrderType.eOrderTypeDonate) {
            btnRepair_Donate.setTitle("Donate", forState: .Normal)
        }
        else if (eSelectedOrderType == eOrderType.eOrderTypeRepair) {
            btnRepair_Donate.setTitle("Confirm", forState: .Normal)
        }
        if(isNewOrder == false) {
            btnRepair_Donate.setTitle("Update", forState: .Normal)
        }
        
        //eSelectedOrderType = Singleton.sharedInstance.objItem.valueForKey("orderType") as! eOrderType
//        fillArray()
        //self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        lblTitle.text = "Review Order"
        fillArray()
    }
    
    
    func fillArray() {
        
        totalItems = 0
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue("Name", forKey: "title")
        obj1.setValue(Singleton.sharedInstance.userData.firstname! + " " + Singleton.sharedInstance.userData.lastname!, forKey: "data")
        obj1.setValue(false, forKey: "isEdit")
        
        let obj2:NSMutableDictionary!  = [ : ]
        obj2.setValue("Address", forKey: "title")
        obj2.setValue(Singleton.sharedInstance.objItem.valueForKey("address"), forKey: "data")
        obj2.setValue(true, forKey: "isEdit")
        
        
        let obj3:NSMutableDictionary!  = [ : ]
        
        let items = Singleton.sharedInstance.objItem.valueForKey("items") as! NSMutableArray
        for (data) in items
        {
            totalItems = totalItems + Int(data.valueForKey("itemCount") as! String)!
        }
        
        /*
        if (eSelectedReviewOrderType == eReviewOrderType.eReviewOrderTypePlace) {
            
            print(Singleton.sharedInstance.objItem.valueForKey("items"))
            let items = Singleton.sharedInstance.objItem.valueForKey("items") as! NSMutableArray
            print(items)
            
            for (data) in items
            {
                totalItems = totalItems + Int(data.valueForKey("itemCount") as! NSNumber)
                //totalItems = totalItems + Int(data.valueForKey("itemCount") as! String)!
                //print(Int(data.valueForKey("count") as! String))
            }
            //totalItems = Int(Singleton.sharedInstance.objItem.valueForKey("items") as! String)
        }
        else if (eSelectedReviewOrderType == eReviewOrderType.eReviewOrderTypeView) {
            let items = Singleton.sharedInstance.objItem.valueForKey("items") as! NSMutableArray
            print(items)
            
            for (data) in items
            {
                print(data)
                totalItems = totalItems + Int(data.valueForKey("itemCount") as! String)!
                //totalItems = totalItems + Int(data.valueForKey("itemCount") as! NSNumber)
                //print(Int(data.valueForKey("count") as! String))
            }
            //totalItems = Int(Singleton.sharedInstance.objItem.valueForKey("items") as! String)
            
            
            //totalItems = Int(Singleton.sharedInstance.objItem.valueForKey("items") as! String)
        }
        */
       // totalItems = Int(Singleton.sharedInstance.objItem.valueForKey("items") as! String)
        print(totalItems)
        print(Singleton.sharedInstance.objItem)
        obj3.setValue("# of items", forKey: "title")
        obj3.setValue(String(totalItems), forKey: "data")
        obj3.setValue(true, forKey: "isEdit")
        
        
        let obj4:NSMutableDictionary!  = [ : ]
        obj4.setValue("Pick-Up Date", forKey: "title")
        obj4.setValue(Singleton.sharedInstance.objItem.valueForKey("datePick"), forKey: "data")
        obj4.setValue(true, forKey: "isEdit")
        
        let obj5:NSMutableDictionary!  = [ : ]
        obj5.setValue("Credit(s) Used", forKey: "title")
        
        
        if (eSelectedOrderType == eOrderType.eOrderTypeDonate) {
            obj5.setValue("0" + " credits", forKey: "data")
            creditUsed = "0"
        }
        else if (eSelectedOrderType == eOrderType.eOrderTypeRepair) {
            obj5.setValue(String(totalItems) + " credits", forKey: "data")
            creditUsed = String(totalItems)
        }
        
        obj5.setValue(false, forKey: "isEdit")
        
        let totalCredit = Int(Singleton.sharedInstance.userData.creditCount!)!
        
        let obj6:NSMutableDictionary!  = [ : ]
        obj6.setValue("Credits(s) Left", forKey: "title")
        
        if (eSelectedOrderType == eOrderType.eOrderTypeDonate) {
            obj6.setValue(String(totalCredit) + " credits", forKey: "data")
        }
        else if (eSelectedOrderType == eOrderType.eOrderTypeRepair) {
            
            if(isNewOrder == false) {
                obj6.setValue(String(totalCredit) + " credits", forKey: "data")
            }
            else {
                obj6.setValue(String(totalCredit-totalItems) + " credits", forKey: "data")
            }
            
        }
        obj6.setValue(false, forKey: "isEdit")
        
        arrList?.removeAllObjects()
        arrList!.addObject(obj1)
        arrList!.addObject(obj2)
        arrList!.addObject(obj3)
        arrList!.addObject(obj4)
        arrList!.addObject(obj5)
        arrList!.addObject(obj6)
        
        tblListing.reloadData()
        
        
    }
    
//    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        
//        return 92
//    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("******")
        
        //let tabController = self.tabBarController as! CustomTabController;
        return 6
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("reviewOrderCell", forIndexPath: indexPath)
        
        
        cell.exclusiveTouch = true;
        cell.contentView.exclusiveTouch = true;
        
        for obj in cell.subviews {
            if NSStringFromClass(obj.dynamicType) == "UITableViewCellScrollView" {
                let scroll: UIScrollView = (obj as? UIScrollView)!
                scroll.delaysContentTouches = false
                break
            }
        }
        let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
        let lblTitle = cell.viewWithTag(1) as! UILabel
        let lblData = cell.viewWithTag(2) as! UILabel
        let btnEdit = cell.viewWithTag(3) as! UIButton
        //
        
        lblTitle.text = data.valueForKey("title") as? String
        lblData.text = data.valueForKey("data") as? String
        
        let isEdit = data.valueForKey("isEdit") as? Bool
        btnEdit.hidden = !isEdit!
        
        if(isNewOrder == false) {
            if(selectedOrder.orderStatus?.uppercaseString != "PENDING") {
                
               btnEdit.hidden = true
            }
            if(lblTitle.text == "# of items") {
                if (selectedOrder.orderType?.uppercaseString == "REPAIR") {
                    btnEdit.hidden = true
                }
                
            }
         }
        
        //lblAmount.text = "$ \(data.valueForKey("price")! as! String)"
        //        lblDescription.text = data.valueForKey("desc") as?
        //        String
        //        btnCount.setTitle(data.valueForKey("count")! as? String, forState: .Normal)
        btnEdit.addTarget(self, action: (#selector(ReviewOrderController.editItemDetail(_:))), forControlEvents: .TouchUpInside)
        //        print(data)
        objc_setAssociatedObject(btnEdit, &kSomeKey, data, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(btnEdit, &kIndex, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return cell
    }
    func editItemDetail(sender: AnyObject) {
        
        //let btnCount = sender as! UIButton
        //        btnSelectedCounter = sender as! UIButton
                let value : NSDictionary! = objc_getAssociatedObject(sender, &kSomeKey) as! NSDictionary
        print(value)
        let title = value.valueForKey("title") as! String
        if (title == "Address") {
            
            let indexPath : NSIndexPath! = objc_getAssociatedObject(sender, &kIndex) as! NSIndexPath!
            print(arrList![indexPath.row])
            editAddress(indexPath)
        }
        else if (title == "# of items" ) {
            
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ScheduleController") as! ScheduleController
            controller.isEdit = true;
            self.navigationController?.pushViewController(controller, animated: true)
        }
        else if (title == "Pick-Up Date") {
            
            
            let count = self.navigationController?.viewControllers.count
            for index in 0.stride(to: count!, by: +1) {
                if(self.navigationController?.viewControllers[index].isKindOfClass(PickDateTimeController) == true) {
                    self.navigationController?.popToViewController(self.navigationController!.viewControllers[index] as! PickDateTimeController, animated: true)
                    
                    return;
                }
            }
            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PickDateTimeController") as! PickDateTimeController
            controller.isEdit = true;
            self.navigationController?.pushViewController(controller, animated: true)
            
            
            
        }
        //        let indexPath : NSIndexPath! = objc_getAssociatedObject(sender, &kIndex) as! NSIndexPath!
        //        indexPathSelectedCounter = indexPath
        //        print(indexPath)
        //        print(indexPath.row)
        //        print(value)
    }
    
    
    func editAddress(indexPath:NSIndexPath) {
        
        
        let alertController = UIAlertController(title: "Alert", message: "Change address", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Change", style: .Default) { (_) in
            if let field = alertController.textFields?[0] {
                // store your data
                if(HelperMethods.validateStringLength(field.text!)) {
                    print(self.arrList);
                    let data = self.arrList![indexPath.row]
                    data.setValue(field.text, forKey: "data")
                    print(self.arrList);
                    Singleton.sharedInstance.objItem.setValue(field.text, forKey: "address")
                    self.tblListing.reloadRowsAtIndexPaths(NSArray(objects: indexPath) as! [NSIndexPath], withRowAnimation: .Fade)
                    //self.arrList?.replaceObjectAtIndex(indexPath.row, withObject: data)
                    //print(self.arrList);
                }
                
                
            } else {
                // user did not fill field
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (_) in }
        
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.placeholder = "New address"
        }
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    @IBAction func confirmOrder() {
    
        print(Singleton.sharedInstance.objItem!)
        if (isNewOrder == true) {
         
            let address = Singleton.sharedInstance.objItem?.valueForKey("address") as! String
            let oldDateString = Singleton.sharedInstance.objItem?.valueForKey("dateYear") as! String
            let oldTimeString = Singleton.sharedInstance.objItem?.valueForKey("timeSlot") as! String
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd h a"
            let dateString = dateFormatter.dateFromString(oldDateString + " " + oldTimeString)
            dateFormatter.dateFormat = "YYYY-MM-dd HH:00:00"
            let dateStringNew = dateFormatter.stringFromDate(dateString!)
            
            var orderType = ""
            if (eSelectedOrderType == eOrderType.eOrderTypeDonate) {
                orderType = "donate"
                
            }
            else if (eSelectedOrderType == eOrderType.eOrderTypeRepair) {
                orderType = "repair"
            }
            
            
            
            let items = Singleton.sharedInstance.objItem.valueForKey("items") as! NSMutableArray
            print(items)
            for data in items {
                data.removeObjectForKey("desc")
                data.removeObjectForKey("title")
            }
            print(items)
            
            let arrParams:NSMutableDictionary!  = [ : ]
            arrParams.setValue(items, forKey: "orderline")
            
            let orderDetails:NSMutableDictionary!  = [ : ]
            orderDetails.setValue(arrParams, forKey: "orderDetails")
            var dataString = ""
            print(NSJSONSerialization.isValidJSONObject(orderDetails.valueForKey("orderDetails")!))
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(orderDetails.valueForKey("orderDetails")!, options:[])
                dataString = NSString(data: data, encoding: NSUTF8StringEncoding)! as String
                print(dataString)
                
            } catch {
                print("JSON serialization failed:  \(error)")
            }
            
            
            var checksum = Singleton.sharedInstance.userData.userId! + dateStringNew + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
            checksum = checksum.md5()
            
            //Singleton.sharedInstance.userData.userId
            let parameter = ["userId": Singleton.sharedInstance.userData.userId!,
                             "creditCharged": creditUsed,
                             "pickUpDate": dateStringNew,
                             "orderType": orderType,
                             "orderDetails": dataString,
                             "checksum": checksum,
                             "address": address]
            
            
            print(parameter)
            registerOrder(parameter)
            print(Singleton.sharedInstance.objItem)
        }
        else {
            
            let address = Singleton.sharedInstance.objItem?.valueForKey("address") as! String
            var dateStringNew:String = ""
            if (Singleton.sharedInstance.objItem?.valueForKey("dateYear") != nil) {
                
                let oldDateString = Singleton.sharedInstance.objItem?.valueForKey("dateYear") as! String
                let oldTimeString = Singleton.sharedInstance.objItem?.valueForKey("timeSlot") as! String
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "YYYY-MM-dd h a"
                let dateString = dateFormatter.dateFromString(oldDateString + " " + oldTimeString)
                dateFormatter.dateFormat = "YYYY-MM-dd HH:00:00"
                dateStringNew = dateFormatter.stringFromDate(dateString!)
                print(address)
                print(oldDateString)
            }
            else {
                dateStringNew = selectedOrder.pickUpDate!
            }
            let items = Singleton.sharedInstance.objItem.valueForKey("items") as! NSMutableArray
            print(items)
            for data in items {
                print(data)
                if (data.valueForKey("desc") != nil ) {
                    data.removeObjectForKey("desc")
                }
                if (data.valueForKey("title") != nil )  {
                    data.removeObjectForKey("title")
                }
            }
            print(items)
            
            let arrParams:NSMutableDictionary!  = [ : ]
            arrParams.setValue(items, forKey: "orderline")
            
            let orderDetails:NSMutableDictionary!  = [ : ]
            orderDetails.setValue(arrParams, forKey: "orderDetails")
            var dataString = ""
            print(NSJSONSerialization.isValidJSONObject(orderDetails.valueForKey("orderDetails")!))
            do {
                let data = try NSJSONSerialization.dataWithJSONObject(orderDetails.valueForKey("orderDetails")!, options:[])
                dataString = NSString(data: data, encoding: NSUTF8StringEncoding)! as String
                print(dataString)
                
            } catch {
                print("JSON serialization failed:  \(error)")
            }
            
            
            var checksum = Singleton.sharedInstance.userData.userId! + dateStringNew + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
            checksum = checksum.md5()
            let parameter = ["userId": Singleton.sharedInstance.userData.userId!,
                             "creditCharged": creditUsed,
                             "pickUpDate": dateStringNew,
                             "orderType": selectedOrder.orderType,
                             "orderDetails": dataString,
                             "checksum": checksum,
                             "address": address,
                             "orderId": selectedOrder.orderId]
            print(parameter)
            updateOrder(parameter)
            
        }
        
        
        
        
        
        
    }
    
    @IBAction func cancel() {
        
       
        EZAlertController.alert("Alert", message: "Are you sure you want to delete this order ", buttons: ["Yes", "No"]) { (alertAction, position) -> Void in
            if position == 0 {
                
                self.cancelConfirmOrder()
                
            } else if position == 1 {
                print("Second button clicked")
            }
        }
        //checksum":MD5(orderId+Private Key)
        
    }
    
    
    func cancelConfirmOrder() {
        
        if (isNewOrder == true) {
            self.navigationController?.popViewControllerAnimated(true)
            return
        }
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
        if (self.eSelectedReviewOrderType == eReviewOrderType.eReviewOrderTypePlace) {
            
            
        }
        else if (self.eSelectedReviewOrderType == eReviewOrderType.eReviewOrderTypeView) {
            orderId = self.selectedOrder.orderId!
            var checksum = orderId +  "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
            checksum = checksum.md5()
            let parameter = ["userId": Singleton.sharedInstance.userData.userId!,
                             "orderId": orderId,
                             "checksum": checksum]
            
            self.cancelOrder(parameter)
        }
        
        
        
        
        
    }
    
    
    func registerOrder(param:AnyObject) {
        
        print(Singleton.sharedInstance.userData.creditCount)
        print(Int(Singleton.sharedInstance.userData.creditCount!))
        print(totalItems)
        print(Int(Singleton.sharedInstance.userData.creditCount!)! - totalItems)
        showNormalHud("Order in progress...")
        let URL: String = "http://66.147.244.103/~versolec/api_v1/order"
        Alamofire.request(.POST, URL, parameters: param as? [String : AnyObject])
            .responseJSON { response in
                
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        
                        let data = HistoryOrderBaseClass.init(object: value)
                        //let test = value.valueForKey("orderReview")!
                        
                        //self.view.makeToast(data.msg!, duration: 2.0, position: .Center)
                        if (Int(data.code!) == 200) {
                            
                            let dataDetail = HistoryOrderOrderHistory.init(object: value.valueForKey("orderReview")![0])
                            print(Singleton.sharedInstance.userData.creditCount)
                            let count = Int(Singleton.sharedInstance.userData.creditCount!)! - self.totalItems
                             Singleton.sharedInstance.userData.creditCount = String(count)
                            print(Singleton.sharedInstance.userData.creditCount)
                            //self.appDelegate.window!.makeToast("Order successfully placed", duration: 2.0, position: .Center)
                            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("OrderConfirmController") as! OrderConfirmController
                            controller.selectedOrder = dataDetail
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
                    self.view.makeToast(error.localizedDescription, duration: 2.0, position: .Center)
                }
                
        }
    }
    func updateOrder(param:AnyObject) {
        
        showNormalHud("Order in progress...")
        let URL: String = "http://66.147.244.103/~versolec/api_v1/modifyOrder"
        Alamofire.request(.POST, URL, parameters: param as? [String : AnyObject])
            .responseJSON { response in
                
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    print(response.result.value)
                    if let value = response.result.value {
                        
                        let data = HistoryOrderBaseClass.init(object: value)
                        //let test = value.valueForKey("orderReview")!
                        
                        //self.view.makeToast(data.msg!, duration: 2.0, position: .Center)
                        if (Int(data.code!) == 200) {
                            
                            let dataDetail = HistoryOrderOrderHistory.init(object: value.valueForKey("orderReview")![0])
                            //self.appDelegate.window!.makeToast("Order successfully placed", duration: 2.0, position: .Center)
                            let controller = self.storyboard!.instantiateViewControllerWithIdentifier("OrderConfirmController") as! OrderConfirmController
                            controller.selectedOrder = dataDetail
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
                    self.view.makeToast(error.localizedDescription, duration: 2.0, position: .Center)
                }
                
        }
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
                            
                            NSNotificationCenter.defaultCenter().postNotificationName("deleteOrder", object: self)
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
}


/*
 

 "userId": "23",
 "orderDetails": "{"orderline":[{"itemId":"2","itemCount":"5"}, {"itemId":"1","itemCount":"4"}]}",
 "orderType": "repair / donate",
 "pickUpDate": "2016-04-23 08:22:22",
 "orderId": "62",
 "checksum":MD5(userId+pickUpDate+Private Key),
 
 */
