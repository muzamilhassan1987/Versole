//
//  ReviewOrderController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/4/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class ReviewOrderController: BaseController {

    @IBOutlet weak var tblListing: UITableView!
    var arrList:NSMutableArray? = NSMutableArray()
    //var AssociatedObjectHandle: UInt8 = 0
    //var btnSelectedCounter:UIButton!
    //var indexPathSelectedCounter:NSIndexPath!
    //var myPickerView:MyPickerView!
    var totalItems:Int!
    
    override func viewDidLoad() {
        
        currentController = Controllers.ReviewOrder
        super.viewDidLoad()
        tblListing.delaysContentTouches = false
        totalItems = 0
        fillArray()
        //self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        lblTitle.text = "Review Order"
    }
    func fillArray() {
        
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue("Name", forKey: "title")
        obj1.setValue(Singleton.sharedInstance.userData.firstname! + " " + Singleton.sharedInstance.userData.lastname!, forKey: "data")
        obj1.setValue(false, forKey: "isEdit")
        
        let obj2:NSMutableDictionary!  = [ : ]
        obj2.setValue("Address", forKey: "title")
        obj2.setValue(Singleton.sharedInstance.userData.address, forKey: "data")
        obj2.setValue(true, forKey: "isEdit")
        
        
        let obj3:NSMutableDictionary!  = [ : ]
        let items = Singleton.sharedInstance.objItem.valueForKey("items") as! NSMutableArray
        print(items)
        
        for (data) in items
        {
            totalItems = totalItems + Int(data.valueForKey("count") as! NSNumber)
            //print(Int(data.valueForKey("count") as! String))
        }
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
        obj5.setValue(String(totalItems) + "credits", forKey: "data")
        obj5.setValue(false, forKey: "isEdit")
        
        let totalCredit = Int(Singleton.sharedInstance.userData.creditCount!)!
        
        let obj6:NSMutableDictionary!  = [ : ]
        obj6.setValue("Credits(s) Left", forKey: "title")
        obj6.setValue(String(totalCredit-totalItems) + "credits", forKey: "data")
        obj6.setValue(false, forKey: "isEdit")
        
        arrList!.addObject(obj1)
        arrList!.addObject(obj2)
        arrList!.addObject(obj3)
        arrList!.addObject(obj4)
        arrList!.addObject(obj5)
        arrList!.addObject(obj6)
        
        
        
        
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
        
        
        //lblAmount.text = "$ \(data.valueForKey("price")! as! String)"
        //        lblDescription.text = data.valueForKey("desc") as?
        //        String
        //        btnCount.setTitle(data.valueForKey("count")! as? String, forState: .Normal)
//        btnEdit.addTarget(self, action: (#selector(ReviewOrderController.editItemDetail(_:))), forControlEvents: .TouchUpInside)
        //        print(data)
        objc_setAssociatedObject(btnEdit, &kSomeKey, data, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
       // objc_setAssociatedObject(btnBuyCredit, &kIndex, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return cell
    }
    func editItemDetail(sender: AnyObject) {
        
        //let btnCount = sender as! UIButton
        //        btnSelectedCounter = sender as! UIButton
                let value : AnyObject! = objc_getAssociatedObject(sender, &kSomeKey)
        print(value)
        //        let indexPath : NSIndexPath! = objc_getAssociatedObject(sender, &kIndex) as! NSIndexPath!
        //        indexPathSelectedCounter = indexPath
        //        print(indexPath)
        //        print(indexPath.row)
        //        print(value)
    }
    
}
