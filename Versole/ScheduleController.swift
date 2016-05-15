
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

    var arrList:NSMutableArray? = NSMutableArray()
    var AssociatedObjectHandle: UInt8 = 0
    var btnSelectedCounter:UIButton!
    var indexPathSelectedCounter:NSIndexPath!
    var myPickerView:MyPickerView!
    var popUp:PopUpView!
    
    
    
//    weak var weakBtntnSelectedCounter:UIButton?
//    weak var weakindexPathSelectedCounter:NSIndexPath?
//    weak var weakarrList:NSMutableArray?
//    weak var weakmyPickerView:MyPickerView?

    
    
    @IBOutlet weak var tblListing: UITableView!
    override func viewDidLoad() {
        currentController = Controllers.Schedule
        super.viewDidLoad()
        tblListing.delaysContentTouches = false
        
        fillArray()
        
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
         super.viewWillAppear(true)
        lblTitle.text = "Schedule"
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
        
        let countValue = notObject.object as! Int
        
        self.btnSelectedCounter!.setTitle(String(countValue), forState: .Normal)
        print(self.arrList)
        let data = self.arrList!.objectAtIndex(self.indexPathSelectedCounter!.row) as! NSMutableDictionary
        data.setValue(countValue, forKey: "count")

        
        
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
////                data.setValue(String(countValue), forKey: "count")
//                    data.setValue(countValue, forKey: "count")
////
//            }
//            self.myPickerView?.removeFromSuperview()
//        }
    
    }
    func fillArray() {
    
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue("SHOES", forKey: "title")
        obj1.setValue("pair(s) of tennis shoes, heels, boots, dress shoes, etc.", forKey: "desc")
        obj1.setValue(Int(0), forKey: "count")
        
        let obj2:NSMutableDictionary!  = [ : ]
        obj2.setValue("HANDBAGS", forKey: "title")
        obj2.setValue("purses, wallets, clutches, etc.", forKey: "desc")
        obj2.setValue(Int(0), forKey: "count")
        
        let obj3:NSMutableDictionary!  = [ : ]
        obj3.setValue("LUGGAGE", forKey: "title")
        obj3.setValue("suitcases, duffle bags, backpacks, etc.", forKey: "desc")
        obj3.setValue(Int(0), forKey: "count")
        
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
        
        
        
        let count = data.valueForKey("count") as! Int
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
        for var index = 0; index <= 100; index += 1 {
            
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
        let predicate = NSPredicate(format: "SELF.count > 0")
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
            totalItems = totalItems + (data.valueForKey("count") as! Int)
        }
        
        let totalCredit = Int(Singleton.sharedInstance.userData.creditCount!)!
        
        print( Int(Singleton.sharedInstance.userData.creditCount!)!)
        if (totalCredit < totalItems) {
            self.showBuyCreditPopUp()
            return
        }
        if(Float(Singleton.sharedInstance.userData.creditCount!) == 0 ) {
            
            self.showBuyCreditPopUp()
            return
        }
        
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue(results.mutableCopy() as! NSMutableArray, forKey: "items")
        
        
        Singleton.sharedInstance.objItem = obj1
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("PickDateTimeController") as! PickDateTimeController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func donateOrder() {
     
        let predicate = NSPredicate(format: "SELF.count > 0")
        let results:NSArray = arrList!.filteredArrayUsingPredicate(predicate)
        
        print(results)
        
        if (results.count == 0) {
            
            EZAlertController.alert("Alert", message: "Select atleast one product")
            return
        }
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue(results.mutableCopy() as! NSMutableArray, forKey: "items")
        
        
        Singleton.sharedInstance.objItem = obj1
        
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