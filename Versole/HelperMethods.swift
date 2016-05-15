//
//  HelperMethods.swift
//  Versole
//
//  Created by Soomro Shahid on 5/8/16.
//  Copyright © 2016 Muzamil Hassan. All rights reserved.
//

import Foundation

class HelperMethods {
    
    
    
    func roundAndFormatFloat(floatToReturn : Float, numDecimalPlaces: Int) -> String{
        
        let formattedNumber = String(format: "%.\(numDecimalPlaces)f", floatToReturn)
        return formattedNumber
        
    }
    
    static func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(testStr)
    }
    
    static func validateStringLength(text: String) -> Bool {
        let trimmed = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return !trimmed.isEmpty
    }

}