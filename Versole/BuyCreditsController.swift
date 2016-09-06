//
//  BuyCreditsController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/27/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
class BuyCreditsController: BaseController {

    @IBOutlet weak var tblListing: UITableView!
    @IBOutlet weak var lblCreditCount: UILabel!
    var btnSelectedCounter:UIButton!
    var indexPathSelectedCounter:NSIndexPath!
    var arrList:NSMutableArray? = NSMutableArray()
    var creditBundle:[CreditBundleData]!
    var isDataLoaded:Bool!
    override func viewDidLoad() {
        
        currentController = Controllers.BuyCredit
        super.viewDidLoad()
        
        //lblCreditCount.text = "test"
        tblListing.delaysContentTouches = false
        //fillArray()
        isDataLoaded = false
        //self.navigationController?.navigationBar.tintColor = UIColor.blueColor()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = "Buy Credits"
        lblCreditCount.text = Singleton.sharedInstance.userData.creditCount
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if(!isDataLoaded){
            getPricingData()
        }
        
        
    }
    func getPricingData(){
        
        showNormalHud("Waiting...")
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/getCreditBundle?checksum")
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                    
                case .Success:
                    if let value = response.result.value {
                        let data = CreditBundleBase.init(object: value)
                        self.creditBundle = data.data
                        self.isDataLoaded = true
                        self.tblListing.reloadData()
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    func fillArray() {
        
        
        let obj1:NSMutableDictionary!  = [ : ]
        obj1.setValue("1", forKey: "credit")
        obj1.setValue("40", forKey: "price")
        
        let obj2:NSMutableDictionary!  = [ : ]
        obj2.setValue("5", forKey: "credit")
        obj2.setValue("180", forKey: "price")
        
        let obj3:NSMutableDictionary!  = [ : ]
        obj3.setValue("10", forKey: "credit")
        obj3.setValue("340", forKey: "price")
        
        let obj4:NSMutableDictionary!  = [ : ]
        obj4.setValue("25", forKey: "credit")
        obj4.setValue("775", forKey: "price")
        
        let obj5:NSMutableDictionary!  = [ : ]
        obj5.setValue("50", forKey: "credit")
        obj5.setValue("1400", forKey: "price")
        
        arrList!.addObject(obj1)
        arrList!.addObject(obj2)
        arrList!.addObject(obj3)
        arrList!.addObject(obj4)
        arrList!.addObject(obj5)
        
        
        
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 92
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("******")
        
        //let tabController = self.tabBarController as! CustomTabController;
        if((self.creditBundle == nil)){
            return 0
        }
        return self.creditBundle.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("creditCell", forIndexPath: indexPath)
        
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.whiteColor()
        }
        else {
            cell.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        }
        
        cell.exclusiveTouch = true;
        cell.contentView.exclusiveTouch = true;
        
        for obj in cell.subviews {
            if NSStringFromClass(obj.dynamicType) == "UITableViewCellScrollView" {
                let scroll: UIScrollView = (obj as? UIScrollView)!
                scroll.delaysContentTouches = false
                break
            }
        }
//        let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
        let lblCreditCount = cell.viewWithTag(1) as! UILabel
        let lblCredit = cell.viewWithTag(2) as! UILabel
        let lblAmount = cell.viewWithTag(3) as! UILabel
        let btnBuyCredit = cell.viewWithTag(4) as! UIButton
        //
        
//        lblCreditCount.text = data.valueForKey("credit") as? String
//        lblCredit.text = "Credits"
//        if(indexPath.row == 0){
//            lblCredit.text = "Credit"
//        }
//        
//        lblAmount.text = "$ \(data.valueForKey("price")! as! String)"
        
        let data = self.creditBundle[indexPath.row]
        lblCreditCount.text = data.creditCount
        lblCredit.text = "Credits"
        if(indexPath.row == 0){
            lblCredit.text = "Credit"
        }
        
        lblAmount.text = "$ " + data.price!
        
        
        lblAmount.adjustsFontSizeToFitWidth = true
        btnBuyCredit.addTarget(self, action: (#selector(BuyCreditsController.buyCredit(_:))), forControlEvents: .TouchUpInside)
        objc_setAssociatedObject(btnBuyCredit, &kSomeKey, data, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        objc_setAssociatedObject(btnBuyCredit, &kIndex, indexPath, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        
        return cell
    }
    
    func buyCredit(sender: AnyObject) {
        
        //let btnCount = sender as! UIButton
        //btnSelectedCounter = sender as! UIButton
        let value : AnyObject! = objc_getAssociatedObject(sender, &kSomeKey)
        let indexPath : NSIndexPath! = objc_getAssociatedObject(sender, &kIndex) as! NSIndexPath!
        indexPathSelectedCounter = indexPath
        print(indexPath)
        print(indexPath.row)
        print(value)
        let data = self.creditBundle[indexPath.row]

        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("BillingController") as! BillingController
        controller.creditBundle = data
        self.navigationController?.pushViewController(controller, animated: true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    deinit {
        print("deinit")
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
