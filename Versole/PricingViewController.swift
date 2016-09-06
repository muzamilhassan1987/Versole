//
//  PricingViewController.swift
//  Versole
//
//  Created by Soomro Shahid on 5/14/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
class PricingViewController: BaseController {

    @IBOutlet weak var tblListign: UITableView!
    var arrList:NSMutableArray! = NSMutableArray()
    var pricingText:PricingTextData!
    var pricingCredit:[PricingTextCredit]!
    override func viewDidLoad() {
        
        currentController = Controllers.Pricing
        super.viewDidLoad()
        
        tblListign.rowHeight = UITableViewAutomaticDimension
        tblListign.estimatedRowHeight = 100.0
        
        //fillArray()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = "Pricing"
        btnShowCredit.setTitle(Singleton.sharedInstance.userData.creditCount, forState: .Normal)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getPricingData()
        
    }
    
    func getPricingData(){
        
        showNormalHud("Waiting...")
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/getPricingText?checksum")
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                    
                case .Success:
                    if let value = response.result.value {
                        let data = PricingTextBase.init(object: value)
                        self.pricingText = data.data![0]
                        
                        self.pricingCredit = self.pricingText.credit
                        self.tblListign.reloadData()
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((self.pricingCredit == nil)){
            return 0
        }
       // return 1;
        return (self.pricingCredit?.count)! + 1;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var identifier = ""
        if(indexPath.row == 0) {
            identifier = "PricingTextCell"
        }
        else {
            identifier = "creditCell"
        }
        let cell:PricingTextCell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! PricingTextCell
        
        //let cell:PricingTextCell = tableView.dequeueReusableCellWithIdentifier("PricingTextCell", forIndexPath: indexPath) as! PricingTextCell
       
        
        cell.selectionStyle = .None
        
        cell.exclusiveTouch = true;
        cell.contentView.exclusiveTouch = true;
        
        for obj in cell.subviews {
            if NSStringFromClass(obj.dynamicType) == "UITableViewCellScrollView" {
                let scroll: UIScrollView = (obj as? UIScrollView)!
                scroll.delaysContentTouches = false
                break
            }
        }
        
        if(indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.whiteColor()
        }
        else {
            cell.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1.0)
        }
        
        //let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
        if(indexPath.row == 0) {
            
            cell.lblHeader.text = self.pricingText.heading
           // cell.lblDescription.text = self.pricingText.body
            cell.lblDescription.text = "Simple, straightforward, and no surprises.\n\nONE credit is equal to ONE item"
//            cell.lblSubHeader.text = self.pricingText.subheading
            cell.lblSubHeader.text = ""
            
        }
        else {
            
            let data = self.pricingCredit![indexPath.row-1]
            print(data.creditCount)
            let lblCreditCount = cell.viewWithTag(1) as! UILabel
            let lblCredit = cell.viewWithTag(2) as! UILabel
            let lblAmount = cell.viewWithTag(3) as! UILabel
            
            lblCreditCount.text = data.creditCount
            lblCredit.text = "Credits"
            if(indexPath.row == 0){
                lblCredit.text = "Credit"
            }
            
            lblAmount.text = "$" + data.price!
        }
        
        
        
        
        
        
        
//        let data = arrList![indexPath.row]
//        cell.lblHeader.text = data.heading
//        cell.lblDescription.text = data.descriptionValue
//        //        cell.iswithDetails = self.expandedIndexPaths.containsObject(indexPath)
        
        return cell
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

    
     
     func fillArray() {
     
     
     let obj1:NSMutableDictionary!  = [ : ]
     let obj2:NSMutableDictionary!  = [ : ]
     let obj3:NSMutableDictionary!  = [ : ]
     let obj4:NSMutableDictionary!  = [ : ]
     let obj5:NSMutableDictionary!  = [ : ]
     
     obj1.setValue("Pricing made easy.", forKey: "question")
//        obj1.setValue("Simple, straightforward pricing based on a credit system so there are never any surprises.\nSingle credits starting at $40 and can be as little as $28 when you buy in bulk.One credit = one pair of shoes, one handbag or one piece of luggage", forKey: "answer")
        
        obj1.setValue("Simple, straightforward, and no surprises.", forKey: "answer")
        
        
        obj1.setValue("CREDITS STARTING AT $40:", forKey: "answer1")
     obj1.setValue("0", forKey: "isOpen")
     
        obj2.setValue("5", forKey: "credit")
        obj2.setValue("180", forKey: "price")
        
        obj3.setValue("10", forKey: "credit")
        obj3.setValue("340", forKey: "price")
        
        obj4.setValue("25", forKey: "credit")
        obj4.setValue("775", forKey: "price")
        
        obj5.setValue("50", forKey: "credit")
        obj5.setValue("1400", forKey: "price")
     obj5.setValue("0", forKey: "isOpen")
     
     
     
     arrList!.addObject(obj1)
     arrList!.addObject(obj2)
     arrList!.addObject(obj3)
     arrList!.addObject(obj4)
     arrList!.addObject(obj5)
     
     tblListign.reloadData()
     
     }
 
}
