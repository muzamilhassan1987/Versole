
//
//  ScheduleController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/27/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import ObjectiveC
import EZAlertController
var kSomeKey = "s"
var kIndex = "s"
class ScheduleController: BaseController {

    @IBOutlet weak var btnUpdate: UIButton!
    @IBOutlet weak var btnDonate: UIButton!
    @IBOutlet weak var btnRepair: UIButton!
    var arrList:NSMutableArray? = NSMutableArray()
    var AssociatedObjectHandle: UInt8 = 0
    var btnSelectedCounter:UIButton!
    var indexPathSelectedCounter:NSIndexPath!
    var myPickerView:MyPickerView!
    var popUp:PopUpView!
    var isEdit:Bool = false
    
    
//    weak var weakBtntnSelectedCounter:UIButton?
//    weak var weakindexPathSelectedCounter:NSIndexPath?
//    weak var weakarrList:NSMutableArray?
//    weak var weakmyPickerView:MyPickerView?

    
    
    @IBOutlet weak var tblListing: UITableView!
    override func viewDidLoad() {

        currentController = Controllers.Schedule
        super.viewDidLoad()
        tblListing.delaysContentTouches = false
        if(isEdit == true) {
            btnDonate.hidden = true
            btnRepair.hidden = true
            btnUpdate.hidden = false
        }
        else {
            btnDonate.hidden = false
            btnRepair.hidden = false
            btnUpdate.hidden = true
        }
        fillArray()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(true)
        lblTitle.text = "Schedule"
        btnShowCredit.setTitle(Singleton.sharedInstance.userData.creditCount, forState: .Normal)
        updateCounter()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    
    deinit {
        print("deinit")
        arrList!.removeAllObjects()
        arrList = nil
        btnSelectedCounter = nil
        indexPathSelectedCounter = nil
        myPickerView = nil
        popUp = nil
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handler(notObject: NSNotification) {
        print("MyNotification was handled")
        
        if(notObject.object == nil) {
            self.myPickerView?.removeFromSuperview()
            return
        }
        
        let countValue = notObject.object as! Int
        
        self.btnSelectedCounter!.setTitle(String(countValue), forState: .Normal)
        print(self.arrList)
        let data = self.arrList!.objectAtIndex(self.indexPathSelectedCounter!.row) as! NSMutableDictionary
        data.setValue(String(countValue), forKey: "itemCount")
        self.myPickerView?.removeFromSuperview()
        
        
        
    }
    func updateCounter() {

//        weak var weakSelf = self;

        
        
        print(self.arrList)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ScheduleController.handler(_:)), name: "UpdatePickerData", object: nil)
        
        
//        NSNotificationCenter.defaultCenter().addObserverForName("UpdatePickerData", object: nil, queue: nil) { (notObject:NSNotification) -> Void in
//                if (notObject.object != nil) {
//                    
//                    print(self.arrList)
//                    
//                let countValue = notObject.object as! Int
//                    
////                    print(weakSelf)
////                    print(weakSelf!.btnSelectedCounter)
//                    //print(self.btnSelectedCounter)
//                self.btnSelectedCounter!.setTitle(String(countValue), forState: .Normal)
//                    print(self.arrList)
//                let data = self.arrList!.objectAtIndex(self.indexPathSelectedCounter!.row) as! NSMutableDictionary
////                data.setValue(String(countValue), forKey: "itemCount")
//                    data.setValue(countValue, forKey: "count")
////
//            }
//            self.myPickerView?.removeFromSuperview()
//        }
    
    }
    func fillArray() {
    
        //print(Singleton.sharedInstance.objItem)
        var shoeCount = 0
        var bagCount = 0
        var luggageCount = 0
        if(isEdit == true) {
            
            let arrItems:NSMutableArray? = Singleton.sharedInstance.objItem.valueForKey("items") as? NSMutableArray
            print(arrItems)
            for data in arrItems! {
                if (Int(data.valueForKey("itemId") as! String) == 1) {
                    
                    shoeCount = Int(data.valueForKey("itemCount") as! String)!
                }
                else if (Int(data.valueForKey("itemId") as! String) == 2) {
                    bagCount = Int(data.valueForKey("itemCount") as! String)!
                }
                else if (Int(data.valueForKey("itemId") as! String) == 3) {
                    luggageCount = Int(data.valueForKey("itemCount") as! String)!
                }
            }
        }
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue("SHOES", forKey: "title")
        obj1.setValue("1", forKey: "itemId")
//        obj1.setValue("pair(s) of tennis shoes, heels, boots, dress shoes, etc.", forKey: "desc")
        obj1.setValue("sneakers, heels, boots, dress shoes, etc.", forKey: "desc")
        obj1.setValue(String(shoeCount), forKey: "itemCount")
        
        let obj2:NSMutableDictionary!  = [ : ]
        obj2.setValue("HANDBAGS", forKey: "title")
        obj2.setValue("2", forKey: "itemId")
        obj2.setValue("purses, wallets, clutches, etc.", forKey: "desc")
        obj2.setValue(String(bagCount), forKey: "itemCount")
        
        let obj3:NSMutableDictionary!  = [ : ]
        obj3.setValue("LUGGAGE", forKey: "title")
        obj3.setValue("3", forKey: "itemId")
        obj3.setValue("suitcases, duffle bags, backpacks, etc.", forKey: "desc")
        obj3.setValue(String(luggageCount), forKey: "itemCount")
        
        arrList!.addObject(obj1)
        arrList!.addObject(obj2)
        arrList!.addObject(obj3)
        
        
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 150
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("******")
        
        //let tabController = self.tabBarController as! CustomTabController;
        return 3
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("scheduleCell", forIndexPath: indexPath)
        
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
        let lblDescription = cell.viewWithTag(2) as! UILabel
        let btnCount = cell.viewWithTag(3) as! UIButton
//        
        lblDescription.sizeToFit()
        lblTitle.text = data.valueForKey("title")! as? String
        lblDescription.text = data.valueForKey("desc") as? String
        
        
        
        let count = data.valueForKey("itemCount") as! String
        btnCount.setTitle(String(count), forState: .Normal)
        
        
       // btnCount.setTitle(data.valueForKey("count")! as? String, forState: .Normal)
        btnCount.addTarget(self, action: (#selector(ScheduleController.ShowPicker(_:))), forControlEvents: .TouchUpInside)
        print(data)
        objc_setAssociatedObject(btnCount, &kSomeKey, data, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(btnCount, &kIndex, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return cell
    }
    
    func ShowPicker(sender: AnyObject) {
        
        //let btnCount = sender as! UIButton
        self.btnSelectedCounter = sender as! UIButton
        print(sender)
        print(self.btnSelectedCounter)
        let value : AnyObject! = objc_getAssociatedObject(sender, &kSomeKey)
        let indexPath : NSIndexPath! = objc_getAssociatedObject(sender, &kIndex) as! NSIndexPath!
        indexPathSelectedCounter = indexPath
        print(indexPath)
        print(indexPath.row)
        print(value)
        
        self.myPickerView = MyPickerView.init(arrToShow: nil, currentSelectedData: nil, superFrame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height))
        
        let arrCounter:NSMutableArray = NSMutableArray()
        
        for index in 0...100 {
        //for var index = 0; index <= 100; index += 1 {
            
            let object:NSMutableDictionary!  = [ : ]
            object.setValue(String(index), forKey: "title")
            arrCounter.addObject(object)
        }
        myPickerView.changeDataArray(arrCounter)
        self.view!.addSubview(myPickerView)
     self.view.bringSubviewToFront(myPickerView)
        

        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(true)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func cleanOrder() {
        
        print(arrList)
        let predicate = NSPredicate(format: "SELF.itemCount.integerValue > 0")
        let results:NSArray = arrList!.filteredArrayUsingPredicate(predicate)
        
        print(results)
        print(arrList)
        if (results.count == 0) {
            
            EZAlertController.alert("Alert", message: "Select atleast one product")
            return
        }
        print(Singleton.sharedInstance.userData.creditCount!)
        
        var totalItems = 0
        for (data) in results
        {
            totalItems = totalItems + (Int(data.valueForKey("itemCount") as! String))!
        }
        
        let totalCredit = Int(Singleton.sharedInstance.userData.creditCount!)!
        
        print( Int(Singleton.sharedInstance.userData.creditCount!)!)
        if (totalCredit < totalItems) {
            self.showBuyCreditPopUp()
            return
        }
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue(results.mutableCopy() as! NSMutableArray, forKey: "items")
        
        Singleton.sharedInstance.objItem = obj1
        print(Singleton.sharedInstance.objItem)
        Singleton.sharedInstance.objItem.setValue(NSNumber(integer: eOrderType.eOrderTypeRepair.rawValue), forKey: "orderType")
        Singleton.sharedInstance.objItem.setValue(NSNumber(bool:true), forKey: "isNewOrder")
        
        if(Float(Singleton.sharedInstance.userData.creditCount!) == 0 ) {
            
            self.showBuyCreditPopUp()
            return
        }
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PickDateTimeController") as! PickDateTimeController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func donateOrder() {
     
        let predicate = NSPredicate(format: "SELF.itemCount.integerValue > 0")
        let results:NSArray = arrList!.filteredArrayUsingPredicate(predicate)
        
        print(results)
        
        if (results.count == 0) {
            
            EZAlertController.alert("Alert", message: "Select atleast one product")
            return
        }
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue(results.mutableCopy() as! NSMutableArray, forKey: "items")
        
        print(obj1)
        Singleton.sharedInstance.objItem = obj1
        print(Singleton.sharedInstance.objItem)
        Singleton.sharedInstance.objItem.setValue(NSNumber(integer: eOrderType.eOrderTypeDonate.rawValue), forKey: "orderType")
        Singleton.sharedInstance.objItem.setValue(NSNumber(bool:true), forKey: "isNewOrder")
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PickDateTimeController") as! PickDateTimeController
        self.navigationController?.pushViewController(controller, animated: true)
        
    }
    
    func showBuyCreditPopUp() {
        
        self.popUp = PopUpView.instanceFromNib("PopUpView") as! PopUpView
        self.popUp.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)
        self.view.addSubview(self.popUp)
        
        self.popUp.btnBuyCredit.addEventHandler({ AnyObject in
            
            self.showBuyCreditScreen()
            
            }, forControlEvents: .TouchUpInside)
        
    }
    
    override func showBuyCreditScreen() {
        
        Singleton.sharedInstance.isOrderProgress = true
        self.view.endEditing(true)
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("BuyCreditsController") as! BuyCreditsController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func updateOrders(sender: AnyObject) {
        
        
        let SelectedOrderType = eOrderType(rawValue: Singleton.sharedInstance.objItem.valueForKey("orderType") as! Int)
        print(SelectedOrderType)
        let predicate = NSPredicate(format: "SELF.itemCount.integerValue > 0")
        let results:NSArray = arrList!.filteredArrayUsingPredicate(predicate)
        
        print(results)
        
        if (results.count == 0) {
            
            EZAlertController.alert("Alert", message: "Select atleast one product")
            return
        }
        
        var totalItems = 0
        for (data) in results
        {
            totalItems = totalItems + (Int(data.valueForKey("itemCount") as! String))!
        }
        
        let totalCredit = Int(Singleton.sharedInstance.userData.creditCount!)!
        
        print( Int(Singleton.sharedInstance.userData.creditCount!)!)
        
        if (SelectedOrderType == eOrderType.eOrderTypeRepair) {
            
            if (totalCredit < totalItems) {
                self.showBuyCreditPopUp()
                return
            }
        }
        
        
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue(results.mutableCopy() as! NSMutableArray, forKey: "items")
        
        let arrData = results.mutableCopy() as! NSMutableArray
//        for data in arrData {
//            data.removeObjectForKey("title")
//            data.removeObjectForKey("desc")
//        }
        print(Singleton.sharedInstance.objItem)
        //print(obj1)
        Singleton.sharedInstance.objItem.setValue(arrData, forKey: "items")
        print(Singleton.sharedInstance.objItem)
        self.navigationController?.popViewControllerAnimated(true)
        
        

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

public extension UIView {
    
    public class func instantiateFromNib<T: UIView>(viewType: T.Type) -> T {
        return NSBundle.mainBundle().loadNibNamed(String(viewType), owner: nil, options: nil).first as! T
    }
    
    public class func instantiateFromNib() -> Self {
        return instantiateFromNib(self)
    }
    
}
/*

let myDict:Dictionary<Int, String> = [1: “One”, 2: “Two”]
let myDictShort:[Int: String] = [1: “One”, 2: “Two”]
let myDictShorter = [1: “One”, 2: “Two”]


var myDict2 = [“One”: 1, “Two”: 2]
let element = myDict2[“One”]
let noElement = myDict2[“false Key”] // returns nil – no such element
myDict2[“Three”] = 3
myDict2.updateValue(4, forKey: “Three”)
myDict2.removeValueForKey(“Three”)


for (number, numberString) in myDict2 {
print(number)
println(numberString)
}




*/