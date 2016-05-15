//
//  ContactBase.swift
//
//  Created by Soomro Shahid on 5/8/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class ContactBase: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kContactBaseDataKey: String = "data"
	internal let kContactBaseStatusKey: String = "status"
	internal let kContactBaseCodeKey: String = "code"


    // MARK: Properties
	public var data: [ContactData]?
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
		if let items = json[kContactBaseDataKey].array {
			for item in items {
				data?.append(ContactData(json: item))
			}
		} else {
			data = nil
		}
		status = json[kContactBaseStatusKey].string
		code = json[kContactBaseCodeKey].string

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
		data <- map[kContactBaseDataKey]
		status <- map[kContactBaseStatusKey]
		code <- map[kContactBaseCodeKey]

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
			dictionary.updateValue(temp, forKey: kContactBaseDataKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kContactBaseStatusKey)
		}
		if code != nil {
			dictionary.updateValue(code!, forKey: kContactBaseCodeKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.data = aDecoder.decodeObjectForKey(kContactBaseDataKey) as? [ContactData]
		self.status = aDecoder.decodeObjectForKey(kContactBaseStatusKey) as? String
		self.code = aDecoder.decodeObjectForKey(kContactBaseCodeKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(data, forKey: kContactBaseDataKey)
		aCoder.encodeObject(status, forKey: kContactBaseStatusKey)
		aCoder.encodeObject(code, forKey: kContactBaseCodeKey)

    }

}
