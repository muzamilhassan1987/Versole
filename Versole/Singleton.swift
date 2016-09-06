//
//  Singleton.swift
//  Versole
//
//  Created by Soomro Shahid on 5/13/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import Foundation
class Singleton {

    static let sharedInstance = Singleton()
    //var userData = UserData()
    var userData:UserData!
    var objItem:NSMutableDictionary!
    var isOrderProgress:Bool = false
    var deviceToken:String = ""
//    var selectedOrder:HistoryOrderOrderHistory! = HistoryOrderOrderHistory()
    
}