//
//  CreditBundleData.swift
//
//  Created by Soomro Shahid on 5/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class CreditBundleData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kCreditBundleDataPriceKey: String = "price"
	internal let kCreditBundleDataCreditCountKey: String = "creditCount"
	internal let kCreditBundleDataCreditbundleIdKey: String = "creditbundleId"


    // MARK: Properties
	public var price: String?
	public var creditCount: String?
	public var creditbundleId: String?


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
		price = json[kCreditBundleDataPriceKey].string
		creditCount = json[kCreditBundleDataCreditCountKey].string
		creditbundleId = json[kCreditBundleDataCreditbundleIdKey].string

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
		price <- map[kCreditBundleDataPriceKey]
		creditCount <- map[kCreditBundleDataCreditCountKey]
		creditbundleId <- map[kCreditBundleDataCreditbundleIdKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if price != nil {
			dictionary.updateValue(price!, forKey: kCreditBundleDataPriceKey)
		}
		if creditCount != nil {
			dictionary.updateValue(creditCount!, forKey: kCreditBundleDataCreditCountKey)
		}
		if creditbundleId != nil {
			dictionary.updateValue(creditbundleId!, forKey: kCreditBundleDataCreditbundleIdKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.price = aDecoder.decodeObjectForKey(kCreditBundleDataPriceKey) as? String
		self.creditCount = aDecoder.decodeObjectForKey(kCreditBundleDataCreditCountKey) as? String
		self.creditbundleId = aDecoder.decodeObjectForKey(kCreditBundleDataCreditbundleIdKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(price, forKey: kCreditBundleDataPriceKey)
		aCoder.encodeObject(creditCount, forKey: kCreditBundleDataCreditCountKey)
		aCoder.encodeObject(creditbundleId, forKey: kCreditBundleDataCreditbundleIdKey)

    }

}
