//
//  LeftSideViewController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/26/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class LeftSideViewController: UIViewController {

     @IBOutlet weak var tblListign: UITableView!
    var lblLastSelected:UILabel!
    var shoppingList: NSArray!
    var selectedIndex:NSInteger!
    var rowHeight:Double!
    override func viewDidLoad() {
        
        super.viewDidLoad()
        shoppingList = ["Home","Pricing","FAQs","Contact Us","Profile","Order History","Share"]
//        shoppingList = ["Home","Pricing","FAQs","Contact Us","Profile","Billing","Order History","Share"]
        selectedIndex = 0;
//        let int: Int = shoppingList.count
       // let cgfloat = Double(shoppingList.count)
        //let cgfloat1 = Double(self.tblListign.frame.size.height)
        rowHeight = Double(self.tblListign.frame.size.height) / Double(shoppingList.count)
        
        tblListign.reloadData()
        // Do any additional setup after loading the view.
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        return CGFloat(rowHeight)
        //return 20.0;//Choose your custom row height
    }
    
    func tableView(tableView: UITableView, hei section: Int) -> Int {
        return shoppingList.count;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("menuCell", forIndexPath: indexPath)
        cell.selectionStyle = .None
        let lblTitle = cell.viewWithTag(1) as! UILabel
        lblTitle.text = shoppingList[indexPath.row] as? String
        lblTitle.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        if(selectedIndex == indexPath.row) {
            lblLastSelected = nil
            lblLastSelected = lblTitle
            lblTitle.textColor = UIColor(red: 251/255.0, green: 206/255.0, blue: 183/255.0, alpha: 1.0)
        }
        
        //cell.textLabel?.text = shoppingList[indexPath.row] as! String
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
       // self.navigationController?.viewControllers.removeAll()
        lblLastSelected.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        
        selectedIndex = indexPath.row
        let cell = tableView.cellForRowAtIndexPath(indexPath)!
        let lblTitle = cell.viewWithTag(1) as! UILabel
        lblTitle.textColor = UIColor(red: 251/255.0, green: 206/255.0, blue: 183/255.0, alpha: 1.0)
        lblLastSelected = lblTitle
        switch (indexPath.row) {
//
        case 0:
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
            
           // if navigationController.viewControllers.last is HomeViewController {
                navigationController.viewControllers.removeAll()
                navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
        case 1:
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("PricingViewController") as! PricingViewController
            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
            
            // if navigationController.viewControllers.last is HomeViewController {
            navigationController.viewControllers.removeAll()
            navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
        case 2:
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("FAQController") as! FAQController
            let navigationController = self.menuContainerViewController.centerViewController  as! UINavigationController
            
            // if navigationController.viewControllers.last is HomeViewController {
            navigationController.viewControllers.removeAll()
            navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
        case 3:
            
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("ContactUsController") as! ContactUsController
            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
            navigationController.viewControllers.removeAll()
            //if navigationController.viewControllers.last! is ContactUsController {
                
                navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
        case 4:
            
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("SignUpController") as! SignUpController
            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
            navigationController.viewControllers.removeAll()
            //if navigationController.viewControllers.last! is ContactUsController {
            
            navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
//        case 5:
//            
//            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("BillingController") as! BillingController
//            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
//            navigationController.viewControllers.removeAll()
//            //if navigationController.viewControllers.last! is ContactUsController {
//            
//            navigationController.pushViewController(selectedController, animated: true)
//            //}
//            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
//            })
//            break;
        case 5:
            
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("OrderHistoryController") as! OrderHistoryController
            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
            navigationController.viewControllers.removeAll()
            //if navigationController.viewControllers.last! is ContactUsController {
            
            navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
        case 6:
            
            let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("ShareController") as! ShareController
            let navigationController = self.menuContainerViewController.centerViewController as! UINavigationController
            
            //if navigationController.viewControllers.last! is ContactUsController {
            navigationController.viewControllers.removeAll()
            navigationController.pushViewController(selectedController, animated: true)
            //}
            self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
            })
            break;
        default:
            print("default")
            
        }
        
        
        
        
       
    }

    @IBAction func logout() {
        
        let logoutAlert = UIAlertController(title: "Alert", message: "Are you sure you want to logout", preferredStyle: UIAlertControllerStyle.Alert)
        
        logoutAlert.addAction(UIAlertAction(title: "Yes", style: .Default, handler: { (action: UIAlertAction!) in
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.logoutUser()
        }))
        
        logoutAlert.addAction(UIAlertAction(title: "No", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        presentViewController(logoutAlert, animated: true, completion: nil)
        
        
        
        
    }
    
    func setHomeScreen() {
        
        lblLastSelected.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        
        selectedIndex = 0
        tblListign.reloadData()
        
        let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
        let navigationController = self.menuContainerViewController.centerViewController
        
        // if navigationController.viewControllers.last is HomeViewController {
        
        navigationController.pushViewController(selectedController, animated: false)
        //}
        self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
        })
    }
    
    func setContactUsScreen() {
        
        lblLastSelected.textColor = UIColor(red: 128/255.0, green: 128/255.0, blue: 128/255.0, alpha: 1.0)
        
        selectedIndex = 3
        tblListign.reloadData()
        
        let selectedController = self.storyboard?.instantiateViewControllerWithIdentifier("ContactUsController") as! ContactUsController
        let navigationController = self.menuContainerViewController.centerViewController
        
        // if navigationController.viewControllers.last is HomeViewController {
        
        navigationController.pushViewController(selectedController, animated: false)
        //}
        self.menuContainerViewController.setMenuState(MFSideMenuStateClosed, completion: { () -> Void in
        })
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
