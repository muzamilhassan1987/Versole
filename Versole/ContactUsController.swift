//
//  ContactUsController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/27/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
import MessageUI
import EZAlertController
import KILabel
class ContactUsController: BaseController,MFMailComposeViewControllerDelegate {

    
    
    @IBOutlet var btnEmail: UIButton!
    @IBOutlet var btnMsg: UIButton!
    @IBOutlet var btnCall: UIButton!
    @IBOutlet weak var lblCall: KILabel!
    @IBOutlet weak var lblText: KILabel!
    @IBOutlet weak var lblEmail: UILabel!
    var isDataLoaded: Bool!
    var contactData:ContactData!
    @IBOutlet weak var  distanceConstrain:NSLayoutConstraint!
    override func viewDidLoad() {
        
        currentController = Controllers.ContactUs
        super.viewDidLoad()
        lblText.text = ""
        lblEmail.text = ""
        lblCall.text = ""
        isDataLoaded = false
        btnMsg.hidden = true
        btnCall.hidden = true
        
    }
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = "Contact Us"
        
    }
    override func  updateViewConstraints() {
        
        super.updateViewConstraints()
        if (UIScreen.mainScreen().bounds.size.height == 480) {
            distanceConstrain.constant = 15
        }
    }
    func updateData(firstText: String, SecondText: String, lblRefrence:UILabel)  {
        
        let firstAttribute = [NSFontAttributeName:UIFont(
            name: "Avenir-HeavyOblique",
            size: 16.0)!]
        



        
        let secondAttribute = [NSFontAttributeName:UIFont(
            name: "Avenir-HeavyOblique",
            size: 16.0)!]
        
        let txtDisplay = NSMutableAttributedString(
            string: firstText,
            attributes: firstAttribute)
        
        txtDisplay.appendAttributedString(
            NSMutableAttributedString(
                string:SecondText,
                attributes: secondAttribute))
        lblRefrence.attributedText = txtDisplay
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getContactData()
        
    }
    func getContactData(){
        
        if (isDataLoaded == true) {
            
            return
        }
        
        showNormalHud("Waiting...")
        
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/getContact?checksum")
            .responseJSON { response in
                self.removeNormalHud()
                switch response.result {
                case .Success:
                    if let value = response.result.value {
                        print(value)
                        let data = ContactBase.init(object: value)
                        self.contactData = data.data![0]
                        self.updateData("Email: ", SecondText: self.contactData.contactEmail!, lblRefrence: self.lblText)
//                        self.updateData("Website: ", SecondText: self.contactData.contactEmail!, lblRefrence: self.lblEmail)
                        //"http://www.versole.com"
                        self.updateData("Website: ", SecondText: self.contactData.contactWebsite!, lblRefrence: self.lblEmail)
                        self.updateData("Call: ", SecondText: self.contactData.contactCall!, lblRefrence: self.lblCall)
                        
                        self.lblText.text = "Website: " + self.contactData.contactWebsite!
                        self.lblCall.text = "Email: " + self.contactData.contactEmail!
                        
                    
                        self.lblCall.urlLinkTapHandler = { label, handle, range in
                            NSLog("User handle \(handle) tapped")
                            print("dffgdgfd")
                            self.email()
                        }
                        self.lblText.urlLinkTapHandler = { label, handle, range in
                            NSLog("User handle \(handle) tapped")
                            //self.emaiZZ
                            UIApplication.sharedApplication().openURL(NSURL(string: self.contactData.contactWebsite!)!)
                        }
                       // self.updateData("Email: ", SecondText: self.contactData.contactEmail!, lblRefrence: self.lblCall)
                        //self.updateData("Website: ", SecondText: "http://www.versole.com", lblRefrence: self.lblText)
                        self.lblEmail.text = ""
//                        self.lblSocialData.text = self.socialData.shareText
//                        print (self.socialData.shareText! as String);
                        self.isDataLoaded = true
                    }
                case .Failure(let error):
                    print(error)
                }
        }
    }
    
    @IBAction func call() {
        
        let url:NSURL = NSURL(string: "tel:9809088798")!
        
        if (UIApplication.sharedApplication().canOpenURL(url))
        {
            UIApplication.sharedApplication().openURL(url)
        }
        
    }
    @IBAction func message() {
        
        let url:NSURL = NSURL(string: "sms:9809088798")!
        
        if (UIApplication.sharedApplication().canOpenURL(url))
        {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    @IBAction func email() {
        
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            
            mail.setToRecipients([self.contactData.contactEmail!])
            mail.setSubject("Information...")
            mail.setMessageBody("To Admin", isHTML: false)
            
            
            presentViewController(mail, animated: true, completion: nil)
        } else {
            // show failure alert
            EZAlertController.alert("Alert", message: "Your device could not send e-mail.  Please configure your email in setting.")
        }
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        controller.dismissViewControllerAnimated(true, completion: nil)
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
