//
//  OrderHistoryController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/5/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class OrderHistoryController: BaseController {

    @IBOutlet weak var tblListing: UITableView!
    var arrList:NSMutableArray? = NSMutableArray()
    
    override func viewDidLoad() {
        
        currentController = Controllers.OrderHistory
        super.viewDidLoad()
        tblListing.delaysContentTouches = false
        fillArray()
        //self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        lblTitle.text = "Review Order"
    }
    func fillArray() {
        
        
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
        

        
        arrList!.addObject(obj1)
        arrList!.addObject(obj2)
        arrList!.addObject(obj3)

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("******")
        
        //let tabController = self.tabBarController as! CustomTabController;
        return 3
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
        
        let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
        
        //let lblTitle = eOrderTag(rawValue: (cell as UILabel).tag)!

        let lblDate = cell.viewWithTag(1) as! UILabel
        let lblOrderType = cell.viewWithTag(2) as! UILabel
        let lblProductType = cell.viewWithTag(3) as! UILabel
        let lblNumberOfItems = cell.viewWithTag(4) as! UILabel
        let lblOrderStatus = cell.viewWithTag(5) as! UILabel
        //
        
        lblDate.text = data.valueForKey("date") as? String
        lblOrderType.text = data.valueForKey("orderType") as? String
        lblProductType.text = data.valueForKey("productType") as? String
        lblNumberOfItems.text = data.valueForKey("itemCount") as? String
        lblOrderStatus.text = data.valueForKey("status") as? String
        
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("ReviewOrderController") as! ReviewOrderController
        self.navigationController?.pushViewController(selectedController, animated: true)
    }
}
