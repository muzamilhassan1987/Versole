//
//  CollapsableViewModel.swift
//  Versole
//
//  Created by Soomro Shahid on 2/29/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import Foundation
import UIKit

class CollapsableViewModel {
    let label: String
    let image: UIImage?
    let children: [CollapsableViewModel]
    var isCollapsed: Bool
    
    init(label: String, image: UIImage? = nil, children: [CollapsableViewModel] = [], isCollapsed: Bool = true) {
        self.label = label
        self.image = image
        self.children = children
        self.isCollapsed = isCollapsed
    }
}