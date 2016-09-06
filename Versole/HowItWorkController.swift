//
//  HowItWorkController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/25/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
class HowItWorkController: BaseController {

    var arrList:[HIWData]?
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var btnSignIn: UIButton!
    //var arrList:NSMutableArray! = NSMutableArray()
    var isDataLoaded:Bool = false
    @IBOutlet weak var tblListign: UITableView!
    override func viewDidLoad() {
        currentController = Controllers.HowItWork
        super.viewDidLoad()
        
        tblListign.rowHeight = UITableViewAutomaticDimension
        tblListign.estimatedRowHeight = 100.0
        // Do any additional setup after loading the view.
        //fillArray()
        tblListign.reloadData()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = "How it Works"
        
        if (self.userDefault.valueForKey("isLogin") != nil) {
            
            let  isLogin = self.userDefault.valueForKey("isLogin") as! Bool
            if (isLogin == true) {
                btnSignIn.hidden = true
                btnSignUp.hidden = true
            }
        }
        
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if (isDataLoaded == false) {
           getHowItWorkData()
        }
        
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((arrList == nil)){
            return 0
        }
        return (arrList?.count)!;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:HIWCell = tableView.dequeueReusableCellWithIdentifier("HIWCell", forIndexPath: indexPath) as! HIWCell
        cell.selectionStyle = .None
        
//                let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
//                cell.lblHeader.text = data.valueForKey("question") as? String
//                cell.lblDescription.text = data.valueForKey("answer") as? String
        let data = arrList![indexPath.row]
        cell.lblHeader.text = data.heading
        cell.lblDescription.text = data.descriptionValue
//        cell.iswithDetails = self.expandedIndexPaths.containsObject(indexPath)
        
        return cell
    }
    
    
    
    func getHowItWorkData(){
        
        showNormalHud("Loading...")
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/howitworks?checksum")
            .responseJSON { response in
                
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = HIWBase.init(object: value)
                        self.arrList = data.data
                        self.isDataLoaded = true
                        //print(self.arrList![0].heading)
                        self.tblListign.reloadData()
                        
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    /*
 
    func fillArray() {
        
        
        let obj1:NSMutableDictionary!  = [ : ]
        let obj2:NSMutableDictionary!  = [ : ]
        let obj3:NSMutableDictionary!  = [ : ]
        let obj4:NSMutableDictionary!  = [ : ]
        let obj5:NSMutableDictionary!  = [ : ]
        
        obj1.setValue("How do I change my order time?", forKey: "question")
        obj1.setValue("Change of plans? We can accommodate! After you’ve placed an order, you can click on either Modify or Cancel to change the terms of your order. If it’s within 24 hours of your pick-up time, please call our customer service team as soon as possible to make your change.", forKey: "answer")
        obj1.setValue("0", forKey: "isOpen")
        
        obj2.setValue("How do I change my order time?How do I change my order time?", forKey: "question")
        obj2.setValue("Change of plans? We can accommodate! After you’ve placed an order, you can click on either Modify or Cancel to change the terms of your order. If it’s within 24 hours of your pick-up time, please call our customer service team as soon as possible to make your change.", forKey: "answer")
        obj2.setValue("0", forKey: "isOpen")
        
        obj3.setValue("How do I change my order time?", forKey: "question")
        obj3.setValue("Change of plans? Whange.", forKey: "answer")
        obj3.setValue("0", forKey: "isOpen")
        
        obj4.setValue("How do I change my order time?", forKey: "question")
        obj4.setValue("Change of plans? We can accommodate! After you’ve placed an order, you can click on either Modify or Cancel to change the terms of your make your change.", forKey: "answer")
        obj4.setValue("0", forKey: "isOpen")
        
        obj5.setValue("How do I change my order time?", forKey: "question")
        obj5.setValue("Change of plans? We can your change.", forKey: "answer")
        obj5.setValue("0", forKey: "isOpen")
        
        
        
        arrList!.addObject(obj1)
        arrList!.addObject(obj2)
        arrList!.addObject(obj3)
        arrList!.addObject(obj4)
        arrList!.addObject(obj5)
        
        tblListign.reloadData()
        
    }
    */
    
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
