//
//  OrderCancelController.swift
//  Versole
//
//  Created by Soomro Shahid on 5/25/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class OrderCancelController: BaseController {

    @IBOutlet weak var lblCancelSubTitle: UILabel!
    @IBOutlet weak var lblCancelTitle: UILabel!
    var cancelTitle:String = ""
    override func viewDidLoad() {
        currentController = Controllers.CancelOrder
        super.viewDidLoad()
        lblCancelTitle.text = cancelTitle
       // if (cancelTitle == "Oops!") {
        if (cancelTitle == "Alert") {
            lblCancelSubTitle.text = "Your order cannot be cancelled after 5pm on the same day of your scheduled pick-up"
            //lblCancelTitle.hidden = true
        }
        else if(cancelTitle == "Cancelled!") {
            lblCancelSubTitle.text = "Your order has been cancelled."
            //lblCancelTitle.hidden = false
        }
        

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        lblTitle.text = "Cancel"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func gotoContactUs(sender: AnyObject) {
        
        let controller = appDelegate.mgSidemenuContainer.leftMenuViewController as! LeftSideViewController
        controller.setContactUsScreen()
    }
    
    override func popViewController() {
        //if (cancelTitle == "Oops!") {
        if (cancelTitle == "Alert") {
            self.navigationController?.popViewControllerAnimated(true)
        }
        else if(cancelTitle == "Cancelled!") {
            
            let count = self.navigationController?.viewControllers.count
            for index in 0.stride(to: count!, by: +1) {
                if(self.navigationController?.viewControllers[index].isKindOfClass(OrderHistoryController) == true) {
                    self.navigationController?.popToViewController(self.navigationController!.viewControllers[index] as! OrderHistoryController, animated: true)
                    
                    break;
                }
            }
        }
        
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
