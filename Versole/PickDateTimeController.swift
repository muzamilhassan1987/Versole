//
//  PickDateTimeController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/5/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import STCollapseTableView
import Alamofire
class PickDateTimeController: BaseController {

    @IBOutlet weak var tblListign: STCollapseTableView!
    @IBOutlet weak var lblHeading: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    var data:NSMutableArray! = NSMutableArray()
    var headers:NSMutableArray! = NSMutableArray()
    var timeDetail:TimeSlotBase!
    var timeSlots:[TimeSlotAvailableTimeSlots]!
    
    override func viewDidLoad() {
        
        currentController = Controllers.PickDate
        super.viewDidLoad()
        self.lblHeading.text = ""
        self.lblDescription.text = ""
        //setupViewController()
        //tblListign.reloadData()
        //tblListign.openSection(0, animated: false)
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getSlotData()
        
    }
    func getSlotData(){
        
        showNormalHud("Waiting...")
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/getPickaDateText?checksum")
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                    
                case .Success:
                    if let value = response.result.value {
                        self.timeDetail = TimeSlotBase.init(object: value)
                        self.lblHeading.text = self.timeDetail.data![0].heading
                        self.lblDescription.text = self.timeDetail.data![0].descriptionValue
                        self.setupViewController()
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    func nextDate(val : Int) -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.Day, value: val, toDate: NSDate(), options: [])!
    }
    
    
    func  setupViewController() {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM. d"
        
        let arrDate:NSMutableArray! = NSMutableArray()
        for i in 0..<14 {
            let dateString = dateFormatter.stringFromDate(nextDate(i))
            print(dateString)
            arrDate.addObject(dateString)
        }
        
        self.timeSlots = self.timeDetail.data![0].availableTimeSlots
        
        
        
        for _ in 0..<arrDate.count {
            
            let section:NSMutableArray! = NSMutableArray()
            self.timeDetail.data![0].availableTimeSlots?.count
            for j in 0..<Int((timeSlots?.count)!) {
                
                dateFormatter.dateFormat = "HH:mm"
                print(timeSlots![j].slotTime!)
                let date = dateFormatter.dateFromString(timeSlots![j].slotTime!)
                dateFormatter.dateFormat = "h a"
                section.addObject(dateFormatter.stringFromDate(date!))
            }
            self.data.addObject(section)
            
        }
        
        for i in 0..<arrDate.count {
            
            let header = UIView.init(frame: CGRectMake(0, 0, self.view.frame.size.width, 41))
            header.backgroundColor = UIColor.whiteColor()
            let label = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 40))
            label.textAlignment = NSTextAlignment.Center
            label.text = arrDate[i] as? String
            label.tag = 100
            label.font = UIFont (name: "Avenir-Book", size: 18)
//            label.font = UIFont (name: "Avenir-Black", size: 20)
            label.textColor = UIColor(red: 128.0/255.0, green: 128.0/255.0, blue: 128.0/255.0, alpha: 1.0)
            header.addSubview(label)
            
            let seprator = UIImageView(frame: CGRectMake(0, header.frame.size.height-2, self.view.frame.size.width, 1))
            seprator.backgroundColor = UIColor(red: 158.0/255.0, green: 158.0/255.0, blue: 158.0/255.0, alpha: 1.0)
            header.addSubview(seprator)
            headers.addObject(header)
        }
        
        
        tblListign.reloadData()
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 41
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.data.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.data[section].count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 40
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?  {
        return self.headers[section] as? UIView
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        print(self.data.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row))
        
        let lblTitleTime = cell.viewWithTag(1) as! UILabel
        lblTitleTime.text = self.data.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as? String
        //NSString* text = [[self.data objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
//        cell.selectionStyle = .None
//        
//        //                let data = arrList!.objectAtIndex(indexPath.row) as! NSMutableDictionary
//        //                cell.lblHeader.text = data.valueForKey("question") as? String
//        //                cell.lblDescription.text = data.valueForKey("answer") as? String
//        let data = arrList![indexPath.row]
//        cell.lblHeader.text = data.heading
//        cell.lblDescription.text = data.descriptionValue
//        //        cell.iswithDetails = self.expandedIndexPaths.containsObject(indexPath)
        
        return cell
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedHeader = self.headers[indexPath.section] as! UIView
        let label = selectedHeader.viewWithTag(100) as! UILabel
        
        Singleton.sharedInstance.objItem.setValue(label.text, forKey: "datePick")
        Singleton.sharedInstance.objItem.setValue(self.data.objectAtIndex(indexPath.section).objectAtIndex(indexPath.row) as? String, forKey: "timeSlot")
        
        print(Singleton.sharedInstance.objItem)
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ReviewOrderController") as! ReviewOrderController
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
