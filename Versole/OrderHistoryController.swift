//
//  OrderHistoryController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/5/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
class OrderHistoryController: BaseController {

    
    @IBOutlet weak var btnBuyCredit: UIButton!
    @IBOutlet weak var btnSchedule: UIButton!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblTitleNoRecord: UILabel!
    @IBOutlet weak var tblListing: UITableView!
    var arrList:[HistoryOrderOrderHistory]?
    var isDataLoaded:Bool!
    var selectedIndex:Int!
    let dateFormatter = NSDateFormatter()
    override func viewDidLoad() {
        
        currentController = Controllers.OrderHistory
        super.viewDidLoad()
        tblListing.delaysContentTouches = false
        isDataLoaded = false
        btnSchedule.hidden = true
        btnBuyCredit.hidden = true
        lblDesc.hidden = true
        lblTitleNoRecord.hidden = true
        tblListing.hidden = true
        //self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
        NSNotificationCenter.defaultCenter().removeObserver(self)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(OrderHistoryController.deleteOrderNotification(_:)), name: "deleteOrder", object: nil)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        lblTitle.text = "Order History"
    }
    override func viewDidAppear(animated: Bool) {
        if(isDataLoaded == false) {
            getDataFromServer()
        }
        
    }
    func getDataFromServer() {
        
        var checksum = Singleton.sharedInstance.userData.userId! + "gJmbPtUw4Ky7Il@p!6hPsdb*s89"
        checksum = checksum.md5()
        let parameter = ["userId": Singleton.sharedInstance.userData.userId!,
                         "checksum": checksum]
        
        let URL: String = "http://66.147.244.103/~versolec/api_v1/orderhistory"
        
        showNormalHud("Waiting...")
        Alamofire.request(.POST,  URL, parameters: parameter)
            .responseJSON { response in
                self.removeNormalHud()
                print(response.result.value)
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        print(value)
                        let data = HistoryOrderBaseClass.init(object: value)
                        if (Int(data.code!) == 200) {
                            self.isDataLoaded = true
                            
                            self.arrList = data.orderHistory?.reverse()
                            //self.arrList?.reverse()
                            
                            if (self.arrList?.count  == 0) {
                                self.btnSchedule.hidden = false
                                self.btnBuyCredit.hidden = false
                                self.lblDesc.hidden = false
                                self.lblTitleNoRecord.hidden = false
                                self.tblListing.hidden = true
                            }
                            else {
                                self.tblListing.hidden = false
                            }
                            self.tblListing.reloadData()
                            
                        }
                        else if (Int(data.code!) == 204) {
                            self.btnSchedule.hidden = false
                            self.btnBuyCredit.hidden = false
                            self.lblDesc.hidden = false
                            self.lblTitleNoRecord.hidden = false
                            self.tblListing.hidden = true
                        }
                        else {
                            
                        }
                    }
                case .Failure(let error):
                    print(error)
                }
        }
        
        
        
        
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue("Feb, 25, 2016", forKey: "date")
        obj1.setValue("donation", forKey: "orderType")
        obj1.setValue("Luggage", forKey: "productType")
        obj1.setValue("3 items total", forKey: "itemCount")
        obj1.setValue("COMPLETE", forKey: "status")
        
        let obj2:NSMutableDictionary!  = [ : ]
        obj2.setValue("Feb, 25, 2016", forKey: "date")
        obj2.setValue("donation", forKey: "orderType")
        obj2.setValue("Luggage", forKey: "productType")
        obj2.setValue("3 items total", forKey: "itemCount")
        obj2.setValue("COMPLETE", forKey: "status")
        
        let obj3:NSMutableDictionary!  = [ : ]
        obj3.setValue("Feb, 25, 2016", forKey: "date")
        obj3.setValue("donation", forKey: "orderType")
        obj3.setValue("Luggage", forKey: "productType")
        obj3.setValue("3 items total", forKey: "itemCount")
        obj3.setValue("COMPLETE", forKey: "status")
        

        
//        arrList!.addObject(obj1)
//        arrList!.addObject(obj2)
//        arrList!.addObject(obj3)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("******")
        if ((self.arrList) != nil) {
            return (self.arrList?.count)!
        }
        else {
            return 0
        }
        //let tabController = self.tabBarController as! CustomTabController;
        
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("orderHistoryCell", forIndexPath: indexPath)
        
        
        cell.exclusiveTouch = true;
        cell.contentView.exclusiveTouch = true;
        
        for obj in cell.subviews {
            if NSStringFromClass(obj.dynamicType) == "UITableViewCellScrollView" {
                let scroll: UIScrollView = (obj as? UIScrollView)!
                scroll.delaysContentTouches = false
                break
            }
        }
        
        let data = arrList![indexPath.row]
    
        //let lblTitle = eOrderTag(rawValue: (cell as UILabel).tag)!

        let lblDate = cell.viewWithTag(1) as! UILabel
        let lblOrderType = cell.viewWithTag(2) as! UILabel
        let lblProductType = cell.viewWithTag(3) as! UILabel
        let lblNumberOfItems = cell.viewWithTag(4) as! UILabel
        let lblOrderStatus = cell.viewWithTag(5) as! RDLabel
        
        var strStatus = data.orderType?.uppercaseFirst
        
        if (strStatus == "READY FOR PICK UP") {
            strStatus = "READY FOR\nPICK UP"
        }
        else if (strStatus == "OUT FOR DELIVERY") {
            strStatus = "OUT FOR\nDELIVERY"
        }
        //
        
        
//        lblDate.text = data.valueForKey("date") as? String
//        lblOrderType.text = data.valueForKey("orderType") as? String
//        lblProductType.text = data.valueForKey("productType") as? String
//        lblNumberOfItems.text = data.valueForKey("itemCount") as? String
//        lblOrderStatus.text = data.valueForKey("status") as? String
        
        lblOrderType.text = strStatus
        lblNumberOfItems.text = data.totalItems! + " items total"
        if (Int(data.totalItems!)! == 1) {
            lblNumberOfItems.text = data.totalItems! + " item total"
        }
        
        lblOrderStatus.text = data.orderStatus?.uppercaseString
//        lblOrderStatus.textAlignment = NSTextAlignment.Center
//        lblOrderStatus.numberOfLines = 0
//        lblOrderStatus.sizeToFit()
        lblProductType.text = data.itemNames
        

        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(data.pickUpDate!)
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let dateString = dateFormatter.stringFromDate(date!)
        lblDate.text = dateString
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let data = arrList![indexPath.row]
        var orderType = 0
        if (data.orderType == "donate") {
            orderType = 1
        }
        else if (data.orderType == "repair") {
           orderType = 2
            
        }
        let obj1:NSMutableDictionary!  = [ : ]
        Singleton.sharedInstance.objItem = obj1
        Singleton.sharedInstance.objItem.setValue(data.arrItem, forKey: "items")
        Singleton.sharedInstance.objItem.setValue(NSNumber(bool:false), forKey: "isNewOrder")
        Singleton.sharedInstance.objItem.setValue(NSNumber(integer: orderType), forKey: "orderType")
        
        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        let date = dateFormatter.dateFromString(data.pickUpDate!)
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let dateString = dateFormatter.stringFromDate(date!)
        Singleton.sharedInstance.objItem.setValue(dateString, forKey: "datePick")
        Singleton.sharedInstance.objItem.setValue(data.address, forKey: "address")
        let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("ReviewOrderController") as! ReviewOrderController
        selectedController.eSelectedReviewOrderType = eReviewOrderType.eReviewOrderTypeView
        selectedController.selectedOrder = data
        selectedIndex = indexPath.row
        
        self.navigationController?.pushViewController(selectedController, animated: true)
    }
    
    func deleteOrderNotification(notification:NSNotification) {
        
        let indexPath = NSIndexPath(forRow: selectedIndex, inSection: 0)
        arrList?.removeAtIndex(selectedIndex)
        self.tblListing.deleteRowsAtIndexPaths(NSArray(objects: indexPath) as! [NSIndexPath], withRowAnimation: .Fade)
        

    }
    
//    - (void) deleteChallangeNotification:(NSNotification *) notification
//    {
//    // [notification name] should always be @"TestNotification"
//    // unless you use this method for observation of other notifications
//    // as well.
//    
//    if ([[notification name] isEqualToString:@"deleteChallange"])
//    NSLog (@"Successfully received the test notification!");
//    {
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
//    [attempts removeObjectAtIndex:selectedIndex];
//    [challengeTable deleteRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationFade];
//    }
    
    
 //   }
    deinit {
        
        print("Base Deinit")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}
extension String {
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    var uppercaseFirst: String {
        return first.uppercaseString + String(characters.dropFirst())
    }
}


class RDLabel: UILabel {
    
    override func drawTextInRect(rect: CGRect) {
        
        var inset = UIEdgeInsetsMake(0, 0, 0, 0)
        if (self.text! == "READY FOR PICK UP" ||
            self.text! == "OUT FOR DELIVERY") {
            
            inset = UIEdgeInsetsMake(0, 0, 0, 0)
        }
        else  {
            inset = UIEdgeInsetsMake(-20, 0, 0, 0)
        }
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, inset))
    }
    
    func sizeForLabel(label:UILabel) -> CGSize{
        
        //let contrain = CGSizeMake(label.bounds.width, CGFloat(FLT_MAX))
        let size: CGSize = label.text!.sizeWithAttributes([NSFontAttributeName: label.font])
        return size
    }
    
    func lineCountForLabel(label:UILabel) -> Double{
        
        //let contrain = CGSizeMake(label.bounds.width, CGFloat(FLT_MAX))
        let size: CGSize = label.text!.sizeWithAttributes([NSFontAttributeName: label.font])
        
        let lines = Double(size.height) / Double(label.font.lineHeight)
        return ceil(lines);
        
    }

}

