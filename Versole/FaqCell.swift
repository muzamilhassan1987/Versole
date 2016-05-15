//
//  FaqCell.swift
//  Versole
//
//  Created by Soomro Shahid on 3/28/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import UIKit

class FaqCell: UITableViewCell {

    @IBOutlet weak var lblQuestion:UILabel!
    @IBOutlet weak var lblAnswer:UILabel!
    @IBOutlet weak var viewDetailContainer:UIView!
    @IBOutlet weak var viewTitleContainer:UIView!
    @IBOutlet weak var imgDropArrow: UIImageView!
    @IBOutlet weak var imgSideArrow: UIImageView!
   // var iswithDetails:Bool?
    @IBOutlet weak var constrainDetailHeight: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.iswithDetails = false
        self.backgroundView = nil
       self.constrainDetailHeight.constant = 0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    private var _iswithDetails : Bool = false             // _x -> backingX
    var iswithDetails : Bool {
        set { _iswithDetails = newValue;
            
            imgDropArrow.hidden = false;
            imgSideArrow.hidden = false;
            if (_iswithDetails) {
                imgSideArrow.hidden = true;
                self.constrainDetailHeight.priority = 250;
                lblQuestion.textColor = UIColor(red: 251/255, green: 206/255, blue: 183/255, alpha: 1.0)
            } else {
                imgDropArrow.hidden = true;
                self.constrainDetailHeight.priority = 999;
                lblQuestion.textColor = UIColor(red: 128/255, green: 128/255, blue: 128/255, alpha: 1.0)
            }
        }
        get { return _iswithDetails }
    }

//    func setWithDetails(withDetails:Bool) {
//        
//        iswithDetails = withDetails;
//        
//        if (withDetails) {
//            self.constrainDetailHeight.priority = 250;
//        } else {
//            self.constrainDetailHeight.priority = 999;
//        }
//    }
    
    func animationOpen() {
        let originalBackgroundColor = self.contentView.backgroundColor
        self.contentView.backgroundColor = UIColor.clearColor()
        self.viewDetailContainer.foldOpenWithTransparency(true) { 
            self.contentView.backgroundColor = originalBackgroundColor
        }
    }
    func animationClose() {
        let originalBackgroundColor = self.contentView.backgroundColor
        self.contentView.backgroundColor = UIColor.clearColor()
        self.viewDetailContainer.foldClosedWithTransparency(true) {
            self.contentView.backgroundColor = originalBackgroundColor
        }
    }
    func updateCell() {
        
        //constrainAnswerHeight.constant = 0
        self.layoutIfNeeded()
    }
}
