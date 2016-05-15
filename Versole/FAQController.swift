
//
//  FAQController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/29/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
class FAQController: BaseController {

    //var arrList:NSMutableArray! = NSMutableArray()
    var arrList:[FAQData]?
    var lastIndexPath:NSIndexPath! = nil
    @IBOutlet weak var tblListign: UITableView!

    @IBOutlet weak var test: NSLayoutConstraint!
    var lblLastSelected:UILabel!
    var shoppingList: NSArray!
    var selectedIndex:NSInteger!
    var expandedIndexPaths:NSMutableSet!
    override func viewDidLoad() {
        currentController = Controllers.FAQ
        super.viewDidLoad()
        
        self.expandedIndexPaths = NSMutableSet()
        tblListign.rowHeight = UITableViewAutomaticDimension
        tblListign.estimatedRowHeight = 36.0
        
        
//        fillArray()
    }
    
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = "FAQs"
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getFaqData()
        
    }
    
    func getFaqData(){
        
        showNormalHud("Waiting...")
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/getfaq?checksum")
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        let data = FAQBase.init(object: value)
                        self.arrList = data.data
                        
                        print(self.arrList![0].question)
                        self.tblListign.reloadData()

                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
 
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if((arrList == nil)){
            return 0
        }
        return (arrList?.count)!;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:FaqCell = tableView.dequeueReusableCellWithIdentifier("faqCell", forIndexPath: indexPath) as! FaqCell
        cell.selectionStyle = .None
        
//        let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
//        cell.lblQuestion.text = data.valueForKey("question") as? String
//        cell.lblAnswer.text = data.valueForKey("answer") as? String
        let data = arrList![indexPath.row]
        cell.lblQuestion.text = data.question
        cell.lblAnswer.text = data.answer
        cell.iswithDetails = self.expandedIndexPaths.containsObject(indexPath)
    
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(self.expandedIndexPaths.containsObject(indexPath) == true) {
            
            let cell:FaqCell = tableView.cellForRowAtIndexPath(indexPath) as! FaqCell
            cell.animationClose()
            self.expandedIndexPaths.removeObject(indexPath)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)

        }
        
        else {
            
            self.expandedIndexPaths.addObject(indexPath)
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
            let cell:FaqCell = tableView.cellForRowAtIndexPath(indexPath) as! FaqCell
            cell.animationOpen()
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
        obj3.setValue("Change of plans? We can accommodate! After you’ve placed an order, you can click on either Modify or Cancel to change the terms of your order. If it’s within 24 hours of your pick-up time, please call our customer service team as soon as possible to make your change.", forKey: "answer")
        obj3.setValue("0", forKey: "isOpen")
        
        obj4.setValue("How do I change my order time?", forKey: "question")
        obj4.setValue("Change of plans? We can accommodate! After you’ve placed an order, you can click on either Modify or Cancel to change the terms of your order. If it’s within 24 hours of your pick-up time, please call our customer service team as soon as possible to make your change.", forKey: "answer")
        obj4.setValue("0", forKey: "isOpen")
        
        obj5.setValue("How do I change my order time?", forKey: "question")
        obj5.setValue("Change of plans? We can accommodate! After you’ve placed an order, you can click on either Modify or Cancel to change the terms of your order. If it’s within 24 hours of your pick-up time, please call our customer service team as soon as possible to make your change.", forKey: "answer")
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
}
