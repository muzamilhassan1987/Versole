//
//  UserData.swift
//
//  Created by Soomro Shahid on 5/9/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class UserData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kUserDataAddressKey: String = "address"
	internal let kUserDataPhoneKey: String = "phone"
	internal let kUserDataPasswordKey: String = "password"
	internal let kUserDataLastnameKey: String = "lastname"
	internal let kUserDataUserIdKey: String = "userId"
	internal let kUserDataUserHashKey: String = "userHash"
	internal let kUserDataCreatedOnKey: String = "createdOn"
	internal let kUserDataFirstnameKey: String = "firstname"
	internal let kUserDataEmailKey: String = "email"
	internal let kUserDataAptKey: String = "apt"
	internal let kUserDataZipcodeKey: String = "zipcode"
    internal let kUserDataCreditCountKey: String = "userCredit"
    internal let kUserDataCityKey: String = "city"


    // MARK: Properties
	public var address: String?
	public var phone: String?
	public var password: String?
	public var lastname: String?
	public var userId: String?
	public var userHash: String?
	public var createdOn: String?
	public var firstname: String?
	public var email: String?
	public var apt: String?
	public var zipcode: String?
    public var creditCount: String?
    public var city: String?

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
		address = json[kUserDataAddressKey].string
		phone = json[kUserDataPhoneKey].string
		password = json[kUserDataPasswordKey].string
		lastname = json[kUserDataLastnameKey].string
		userId = json[kUserDataUserIdKey].string
		userHash = json[kUserDataUserHashKey].string
		createdOn = json[kUserDataCreatedOnKey].string
		firstname = json[kUserDataFirstnameKey].string
		email = json[kUserDataEmailKey].string
        
        apt = json[kUserDataAptKey].string
        zipcode = json[kUserDataZipcodeKey].string
        
        creditCount = json[kUserDataCreditCountKey].string
        
        city = json[kUserDataCityKey].string

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
		address <- map[kUserDataAddressKey]
		phone <- map[kUserDataPhoneKey]
		password <- map[kUserDataPasswordKey]
		lastname <- map[kUserDataLastnameKey]
		userId <- map[kUserDataUserIdKey]
		userHash <- map[kUserDataUserHashKey]
		createdOn <- map[kUserDataCreatedOnKey]
		firstname <- map[kUserDataFirstnameKey]
		email <- map[kUserDataEmailKey]
		apt <- map[kUserDataAptKey]
		zipcode <- map[kUserDataZipcodeKey]
        creditCount <- map[kUserDataCreditCountKey]
        city <- map[kUserDataCityKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if address != nil {
			dictionary.updateValue(address!, forKey: kUserDataAddressKey)
		}
		if phone != nil {
			dictionary.updateValue(phone!, forKey: kUserDataPhoneKey)
		}
		if password != nil {
			dictionary.updateValue(password!, forKey: kUserDataPasswordKey)
		}
		if lastname != nil {
			dictionary.updateValue(lastname!, forKey: kUserDataLastnameKey)
		}
		if userId != nil {
			dictionary.updateValue(userId!, forKey: kUserDataUserIdKey)
		}
		if userHash != nil {
			dictionary.updateValue(userHash!, forKey: kUserDataUserHashKey)
		}
		if createdOn != nil {
			dictionary.updateValue(createdOn!, forKey: kUserDataCreatedOnKey)
		}
		if firstname != nil {
			dictionary.updateValue(firstname!, forKey: kUserDataFirstnameKey)
		}
		if email != nil {
			dictionary.updateValue(email!, forKey: kUserDataEmailKey)
		}
		if apt != nil {
			dictionary.updateValue(apt!, forKey: kUserDataAptKey)
		}
		if zipcode != nil {
			dictionary.updateValue(zipcode!, forKey: kUserDataZipcodeKey)
		}
        if creditCount != nil {
            dictionary.updateValue(creditCount!, forKey: kUserDataCreditCountKey)
        }
        if city != nil {
            dictionary.updateValue(city!, forKey: kUserDataCityKey)
        }

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.address = aDecoder.decodeObjectForKey(kUserDataAddressKey) as? String
		self.phone = aDecoder.decodeObjectForKey(kUserDataPhoneKey) as? String
		self.password = aDecoder.decodeObjectForKey(kUserDataPasswordKey) as? String
		self.lastname = aDecoder.decodeObjectForKey(kUserDataLastnameKey) as? String
		self.userId = aDecoder.decodeObjectForKey(kUserDataUserIdKey) as? String
		self.userHash = aDecoder.decodeObjectForKey(kUserDataUserHashKey) as? String
		self.createdOn = aDecoder.decodeObjectForKey(kUserDataCreatedOnKey) as? String
		self.firstname = aDecoder.decodeObjectForKey(kUserDataFirstnameKey) as? String
		self.email = aDecoder.decodeObjectForKey(kUserDataEmailKey) as? String
		self.apt = aDecoder.decodeObjectForKey(kUserDataAptKey) as? String
		self.zipcode = aDecoder.decodeObjectForKey(kUserDataZipcodeKey) as? String
        self.creditCount = aDecoder.decodeObjectForKey(kUserDataCreditCountKey) as? String
        self.city = aDecoder.decodeObjectForKey(kUserDataCityKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(address, forKey: kUserDataAddressKey)
		aCoder.encodeObject(phone, forKey: kUserDataPhoneKey)
		aCoder.encodeObject(password, forKey: kUserDataPasswordKey)
		aCoder.encodeObject(lastname, forKey: kUserDataLastnameKey)
		aCoder.encodeObject(userId, forKey: kUserDataUserIdKey)
		aCoder.encodeObject(userHash, forKey: kUserDataUserHashKey)
		aCoder.encodeObject(createdOn, forKey: kUserDataCreatedOnKey)
		aCoder.encodeObject(firstname, forKey: kUserDataFirstnameKey)
		aCoder.encodeObject(email, forKey: kUserDataEmailKey)
		aCoder.encodeObject(apt, forKey: kUserDataAptKey)
		aCoder.encodeObject(zipcode, forKey: kUserDataZipcodeKey)
        aCoder.encodeObject(creditCount, forKey: kUserDataCreditCountKey)
        aCoder.encodeObject(city, forKey: kUserDataCityKey)

    }

}
