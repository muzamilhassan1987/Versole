//
//  Enums.swift
//  Versole
//
//  Created by Soomro Shahid on 2/21/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import Foundation
enum Controllers {
    case Welcome
    case SignIn
    case Home
    case Schedule
    case ContactUs
    case Billing
    case OrderHistory
    case SignUp
    case Profile
    case Share
    case BuyCredit
    case FAQ
    case ResetPassword
    case ReviewOrder
    case HowItWork
    case Pricing
    case PickDate
    case OrderConfirmation
    case CancelOrder
}


enum eOrderTag: Int {
    case eOrderDate = 1
    case eOrderType
    case eProductType
    case eNumberOfItems
    case eOrderStatus
}

enum ePickerType: Int {
    case ePickerTypeYear = 1
    case ePickerTypeMonth
    
}
enum eOrderDetailTag: Int {
    case eOrderTypeCleaning = 1
    case eOrderTypeRepain
    case eOrderTypeDonation
    case eProductTypeShoes
    case eProductTypeLuggage
    case eProductTypeHandbag
    case eTotalNumberOfItems
    case eOrderStatusComplete
    case eOrderStatusPending
}

enum eOrderType: Int {
    case eOrderTypeDonate = 1
    case eOrderTypeRepair
    
}

enum eReviewOrderType: Int {
    case eReviewOrderTypePlace = 1
    case eReviewOrderTypeView
}

enum eGotoToController: Int {
    case eGotoToControllerSchedule = 1
    case eGotoToControllerSchedule1
}
