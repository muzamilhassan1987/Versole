//
//  CreditBundleBase.swift
//
//  Created by Soomro Shahid on 5/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class CreditBundleBase: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kCreditBundleBaseDataKey: String = "data"
	internal let kCreditBundleBaseStatusKey: String = "status"
	internal let kCreditBundleBaseCodeKey: String = "code"


    // MARK: Properties
	public var data: [CreditBundleData]?
	public var status: String?
	public var code: String?


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
		data = []
		if let items = json[kCreditBundleBaseDataKey].array {
			for item in items {
				data?.append(CreditBundleData(json: item))
			}
		} else {
			data = nil
		}
		status = json[kCreditBundleBaseStatusKey].string
		code = json[kCreditBundleBaseCodeKey].string

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
		data <- map[kCreditBundleBaseDataKey]
		status <- map[kCreditBundleBaseStatusKey]
		code <- map[kCreditBundleBaseCodeKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if data?.count > 0 {
			var temp: [AnyObject] = []
			for item in data! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kCreditBundleBaseDataKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kCreditBundleBaseStatusKey)
		}
		if code != nil {
			dictionary.updateValue(code!, forKey: kCreditBundleBaseCodeKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.data = aDecoder.decodeObjectForKey(kCreditBundleBaseDataKey) as? [CreditBundleData]
		self.status = aDecoder.decodeObjectForKey(kCreditBundleBaseStatusKey) as? String
		self.code = aDecoder.decodeObjectForKey(kCreditBundleBaseCodeKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(data, forKey: kCreditBundleBaseDataKey)
		aCoder.encodeObject(status, forKey: kCreditBundleBaseStatusKey)
		aCoder.encodeObject(code, forKey: kCreditBundleBaseCodeKey)

    }

}
