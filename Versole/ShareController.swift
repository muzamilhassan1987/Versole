//
//  ShareController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/23/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit
import Alamofire
class ShareController: BaseController {

    var socialData:SocialShareData!
    @IBOutlet weak var  distanceConstrain:NSLayoutConstraint!
    @IBOutlet weak var  distanceConstrainButtons:NSLayoutConstraint!
    @IBOutlet weak var  btnEmail:UIButton!
    @IBOutlet weak var  btnFacebook:UIButton!
    @IBOutlet weak var  btnTwitter:UIButton!
    @IBOutlet weak var  btnMessage:UIButton!
    @IBOutlet var lblSocialData:UILabel!
    override func viewDidLoad() {
    
        currentController = Controllers.Share
        super.viewDidLoad()
        lblSocialData.text = ""
        btnEmail.hidden = true
        btnTwitter.hidden = true
        btnMessage.hidden = true
        btnFacebook.hidden = true
        
        
    }
    override func  updateViewConstraints() {
        
        super.updateViewConstraints()
        if (UIScreen.mainScreen().bounds.size.height == 480) {
            distanceConstrain.constant = 25
        }
        let totalWidth = btnEmail.frame.origin.x + btnEmail.frame.size.width - btnFacebook.frame.origin.x
        distanceConstrainButtons.constant = (self.view.frame.size.width - totalWidth)/2
        distanceConstrainButtons.constant = distanceConstrainButtons.constant-20
        print(distanceConstrainButtons.constant)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        lblTitle.text = "Share"
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        getShareData()
        
    }
    func getShareData(){
    
        showNormalHud("Waiting...")
        Alamofire.request(.GET, "http://66.147.244.103/~versolec/api_v1/getShare?checksum")
            .responseJSON { response in
                self.removeNormalHud()
                self.btnEmail.hidden = false
                self.btnTwitter.hidden = false
                self.btnMessage.hidden = false
                self.btnFacebook.hidden = false
                switch response.result {
                    
                case .Success:
                    if let value = response.result.value {
                        let data = SocialShareBase.init(object: value)
                        self.socialData = data.data![0]
                        self.lblSocialData.text = self.socialData.shareText
                        print (self.socialData.shareText! as String);
                        
                    }
                case .Failure(let error):
                    print(error)
                }
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
