//
//  HomeViewController.swift
//  Versole
//
//  Created by Soomro Shahid on 3/27/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class HomeViewController: BaseController {

    @IBOutlet weak var  distanceConstrain:NSLayoutConstraint!
    @IBOutlet weak var  distanceConstrainSchedule:NSLayoutConstraint!
    @IBOutlet weak var  distanceConstrainOpenOrder:NSLayoutConstraint!
    override func viewDidLoad() {
        currentController = Controllers.Home
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = "Hi, " + Singleton.sharedInstance.userData.firstname! + "!"
        btnShowCredit.setTitle(Singleton.sharedInstance.userData.creditCount, forState: .Normal)
        
    }
    override func  updateViewConstraints() {
        
        super.updateViewConstraints()
        if (UIScreen.mainScreen().bounds.size.height == 480) {
            distanceConstrain.constant = 15
            distanceConstrainSchedule.constant = 7
            distanceConstrainOpenOrder.constant = 16
        }
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
