//
//  HIWCell.swift
//  Versole
//
//  Created by Soomro Shahid on 5/9/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//
import UIKit

class HIWCell: UITableViewCell {

    
    @IBOutlet weak var lblHeader:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    @IBOutlet weak var imgBar: UIImageView!
    
    @IBOutlet weak var constrainDetailHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.iswithDetails = false
        //self.backgroundView = nil
        //self.constrainDetailHeight.constant = 0
    }
}
