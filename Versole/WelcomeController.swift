//
//  WelcomeController.swift
//  Versole
//
//  Created by Soomro Shahid on 2/20/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class WelcomeController: BaseController {

    
    override func viewDidLoad() {
    
        currentController = Controllers.Welcome
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool)    {
        super.viewWillAppear(true)
        lblTitle.text = ""
    }
}

