//
//  SocialShareBase.swift
//
//  Created by Soomro Shahid on 5/8/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class SocialShareBase: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSocialShareBaseDataKey: String = "data"
	internal let kSocialShareBaseStatusKey: String = "status"
	internal let kSocialShareBaseCodeKey: String = "code"


    // MARK: Properties
	public var data: [SocialShareData]?
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
		if let items = json[kSocialShareBaseDataKey].array {
			for item in items {
				data?.append(SocialShareData(json: item))
			}
		} else {
			data = nil
		}
		status = json[kSocialShareBaseStatusKey].string
		code = json[kSocialShareBaseCodeKey].string

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
		data <- map[kSocialShareBaseDataKey]
		status <- map[kSocialShareBaseStatusKey]
		code <- map[kSocialShareBaseCodeKey]

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
			dictionary.updateValue(temp, forKey: kSocialShareBaseDataKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kSocialShareBaseStatusKey)
		}
		if code != nil {
			dictionary.updateValue(code!, forKey: kSocialShareBaseCodeKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.data = aDecoder.decodeObjectForKey(kSocialShareBaseDataKey) as? [SocialShareData]
		self.status = aDecoder.decodeObjectForKey(kSocialShareBaseStatusKey) as? String
		self.code = aDecoder.decodeObjectForKey(kSocialShareBaseCodeKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(data, forKey: kSocialShareBaseDataKey)
		aCoder.encodeObject(status, forKey: kSocialShareBaseStatusKey)
		aCoder.encodeObject(code, forKey: kSocialShareBaseCodeKey)

    }

}
