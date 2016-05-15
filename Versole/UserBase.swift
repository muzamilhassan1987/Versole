//
//  UserBase.swift
//
//  Created by Soomro Shahid on 5/9/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class UserBase: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kUserBaseCodeKey: String = "code"
	internal let kUserBaseDataKey: String = "data"
	internal let kUserBaseStatusKey: String = "status"
	internal let kUserBaseMsgKey: String = "msg"


    // MARK: Properties
	public var code: String?
	public var data: [UserData]?
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
		code = json[kUserBaseCodeKey].string
		data = []
		if let items = json[kUserBaseDataKey].array {
			for item in items {
				data?.append(UserData(json: item))
			}
		} else {
			data = nil
		}
		status = json[kUserBaseStatusKey].string
		msg = json[kUserBaseMsgKey].string

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
		code <- map[kUserBaseCodeKey]
		data <- map[kUserBaseDataKey]
		status <- map[kUserBaseStatusKey]
		msg <- map[kUserBaseMsgKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code!, forKey: kUserBaseCodeKey)
		}
		if data?.count > 0 {
			var temp: [AnyObject] = []
			for item in data! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kUserBaseDataKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kUserBaseStatusKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kUserBaseMsgKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.code = aDecoder.decodeObjectForKey(kUserBaseCodeKey) as? String
		self.data = aDecoder.decodeObjectForKey(kUserBaseDataKey) as? [UserData]
		self.status = aDecoder.decodeObjectForKey(kUserBaseStatusKey) as? String
		self.msg = aDecoder.decodeObjectForKey(kUserBaseMsgKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(code, forKey: kUserBaseCodeKey)
		aCoder.encodeObject(data, forKey: kUserBaseDataKey)
		aCoder.encodeObject(status, forKey: kUserBaseStatusKey)
		aCoder.encodeObject(msg, forKey: kUserBaseMsgKey)

    }

}
