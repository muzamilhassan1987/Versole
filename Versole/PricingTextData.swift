//
//  PricingTextData.swift
//
//  Created by Soomro Shahid on 5/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class PricingTextData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kPricingTextDataCreditKey: String = "credit"
	internal let kPricingTextDataHeadingKey: String = "heading"
	internal let kPricingTextDataSubheadingKey: String = "subheading"
	internal let kPricingTextDataBodyKey: String = "body"


    // MARK: Properties
	public var credit: [PricingTextCredit]?
	public var heading: String?
	public var subheading: String?
	public var body: String?


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
		credit = []
		if let items = json[kPricingTextDataCreditKey].array {
			for item in items {
				credit?.append(PricingTextCredit(json: item))
			}
		} else {
			credit = nil
		}
		heading = json[kPricingTextDataHeadingKey].string
		subheading = json[kPricingTextDataSubheadingKey].string
		body = json[kPricingTextDataBodyKey].string

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
		credit <- map[kPricingTextDataCreditKey]
		heading <- map[kPricingTextDataHeadingKey]
		subheading <- map[kPricingTextDataSubheadingKey]
		body <- map[kPricingTextDataBodyKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if credit?.count > 0 {
			var temp: [AnyObject] = []
			for item in credit! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kPricingTextDataCreditKey)
		}
		if heading != nil {
			dictionary.updateValue(heading!, forKey: kPricingTextDataHeadingKey)
		}
		if subheading != nil {
			dictionary.updateValue(subheading!, forKey: kPricingTextDataSubheadingKey)
		}
		if body != nil {
			dictionary.updateValue(body!, forKey: kPricingTextDataBodyKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.credit = aDecoder.decodeObjectForKey(kPricingTextDataCreditKey) as? [PricingTextCredit]
		self.heading = aDecoder.decodeObjectForKey(kPricingTextDataHeadingKey) as? String
		self.subheading = aDecoder.decodeObjectForKey(kPricingTextDataSubheadingKey) as? String
		self.body = aDecoder.decodeObjectForKey(kPricingTextDataBodyKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(credit, forKey: kPricingTextDataCreditKey)
		aCoder.encodeObject(heading, forKey: kPricingTextDataHeadingKey)
		aCoder.encodeObject(subheading, forKey: kPricingTextDataSubheadingKey)
		aCoder.encodeObject(body, forKey: kPricingTextDataBodyKey)

    }

}
