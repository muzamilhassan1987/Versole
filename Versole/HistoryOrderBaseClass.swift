//
//  HistoryOrderBaseClass.swift
//
//  Created by Soomro Shahid on 5/28/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class HistoryOrderBaseClass: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kHistoryOrderBaseClassOrderHistoryKey: String = "orderHistory"
	internal let kHistoryOrderBaseClassCodeKey: String = "code"
	internal let kHistoryOrderBaseClassStatusKey: String = "status"
	internal let kHistoryOrderBaseClassMsgKey: String = "msg"


    // MARK: Properties
	public var orderHistory: [HistoryOrderOrderHistory]?
	public var code: String?
	public var status: String?
	public var msg: String?


    // MARK: SwiftyJSON Initalizers
    /**
    Initates the class based on the object
    - parameter object: The object of either Dictionary or Array kind that was passed.
    - returns: An initalized instance of the class.
    */
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }

    /**
    Initates the class based on the JSON that was passed.
    - parameter json: JSON object from SwiftyJSON.
    - returns: An initalized instance of the class.
    */
    public init(json: JSON) {
		orderHistory = []
		if let items = json[kHistoryOrderBaseClassOrderHistoryKey].array {
			for item in items {
				orderHistory?.append(HistoryOrderOrderHistory(json: item))
			}
		} else {
			orderHistory = nil
		}
		code = json[kHistoryOrderBaseClassCodeKey].string
		status = json[kHistoryOrderBaseClassStatusKey].string
		msg = json[kHistoryOrderBaseClassMsgKey].string

    }

    // MARK: ObjectMapper Initalizers
    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    required public init?(_ map: Map){

    }

    /**
    Map a JSON object to this class using ObjectMapper
    - parameter map: A mapping from ObjectMapper
    */
    public func mapping(map: Map) {
		orderHistory <- map[kHistoryOrderBaseClassOrderHistoryKey]
		code <- map[kHistoryOrderBaseClassCodeKey]
		status <- map[kHistoryOrderBaseClassStatusKey]
		msg <- map[kHistoryOrderBaseClassMsgKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if orderHistory?.count > 0 {
			var temp: [AnyObject] = []
			for item in orderHistory! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kHistoryOrderBaseClassOrderHistoryKey)
		}
		if code != nil {
			dictionary.updateValue(code!, forKey: kHistoryOrderBaseClassCodeKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kHistoryOrderBaseClassStatusKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kHistoryOrderBaseClassMsgKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.orderHistory = aDecoder.decodeObjectForKey(kHistoryOrderBaseClassOrderHistoryKey) as? [HistoryOrderOrderHistory]
		self.code = aDecoder.decodeObjectForKey(kHistoryOrderBaseClassCodeKey) as? String
		self.status = aDecoder.decodeObjectForKey(kHistoryOrderBaseClassStatusKey) as? String
		self.msg = aDecoder.decodeObjectForKey(kHistoryOrderBaseClassMsgKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(orderHistory, forKey: kHistoryOrderBaseClassOrderHistoryKey)
		aCoder.encodeObject(code, forKey: kHistoryOrderBaseClassCodeKey)
		aCoder.encodeObject(status, forKey: kHistoryOrderBaseClassStatusKey)
		aCoder.encodeObject(msg, forKey: kHistoryOrderBaseClassMsgKey)

    }

}
