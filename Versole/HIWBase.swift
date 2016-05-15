//
//  HIWBase.swift
//
//  Created by Soomro Shahid on 5/9/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class HIWBase: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kHIWBaseDataKey: String = "data"
	internal let kHIWBaseStatusKey: String = "status"
	internal let kHIWBaseCodeKey: String = "code"


    // MARK: Properties
	public var data: [HIWData]?
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
		if let items = json[kHIWBaseDataKey].array {
			for item in items {
				data?.append(HIWData(json: item))
			}
		} else {
			data = nil
		}
		status = json[kHIWBaseStatusKey].string
		code = json[kHIWBaseCodeKey].string

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
		data <- map[kHIWBaseDataKey]
		status <- map[kHIWBaseStatusKey]
		code <- map[kHIWBaseCodeKey]

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
			dictionary.updateValue(temp, forKey: kHIWBaseDataKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kHIWBaseStatusKey)
		}
		if code != nil {
			dictionary.updateValue(code!, forKey: kHIWBaseCodeKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.data = aDecoder.decodeObjectForKey(kHIWBaseDataKey) as? [HIWData]
		self.status = aDecoder.decodeObjectForKey(kHIWBaseStatusKey) as? String
		self.code = aDecoder.decodeObjectForKey(kHIWBaseCodeKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(data, forKey: kHIWBaseDataKey)
		aCoder.encodeObject(status, forKey: kHIWBaseStatusKey)
		aCoder.encodeObject(code, forKey: kHIWBaseCodeKey)

    }

}
