//
//  ContactData.swift
//
//  Created by Soomro Shahid on 5/8/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class ContactData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kContactDataContactIdKey: String = "contactId"
	internal let kContactDataContactEmailKey: String = "contactEmail"
	internal let kContactDataContactCallKey: String = "contactCall"
	internal let kContactDataContactTextKey: String = "contactText"


    // MARK: Properties
	public var contactId: String?
	public var contactEmail: String?
	public var contactCall: String?
	public var contactText: String?


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
		contactId = json[kContactDataContactIdKey].string
		contactEmail = json[kContactDataContactEmailKey].string
		contactCall = json[kContactDataContactCallKey].string
		contactText = json[kContactDataContactTextKey].string

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
		contactId <- map[kContactDataContactIdKey]
		contactEmail <- map[kContactDataContactEmailKey]
		contactCall <- map[kContactDataContactCallKey]
		contactText <- map[kContactDataContactTextKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if contactId != nil {
			dictionary.updateValue(contactId!, forKey: kContactDataContactIdKey)
		}
		if contactEmail != nil {
			dictionary.updateValue(contactEmail!, forKey: kContactDataContactEmailKey)
		}
		if contactCall != nil {
			dictionary.updateValue(contactCall!, forKey: kContactDataContactCallKey)
		}
		if contactText != nil {
			dictionary.updateValue(contactText!, forKey: kContactDataContactTextKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.contactId = aDecoder.decodeObjectForKey(kContactDataContactIdKey) as? String
		self.contactEmail = aDecoder.decodeObjectForKey(kContactDataContactEmailKey) as? String
		self.contactCall = aDecoder.decodeObjectForKey(kContactDataContactCallKey) as? String
		self.contactText = aDecoder.decodeObjectForKey(kContactDataContactTextKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(contactId, forKey: kContactDataContactIdKey)
		aCoder.encodeObject(contactEmail, forKey: kContactDataContactEmailKey)
		aCoder.encodeObject(contactCall, forKey: kContactDataContactCallKey)
		aCoder.encodeObject(contactText, forKey: kContactDataContactTextKey)

    }

}
