//
//  AddCreditBase.swift
//
//  Created by Soomro Shahid on 5/15/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class AddCreditBase: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kAddCreditBaseCodeKey: String = "code"
	internal let kAddCreditBaseStatusKey: String = "status"
	internal let kAddCreditBaseUserCreditKey: String = "userCredit"
	internal let kAddCreditBaseMsgKey: String = "msg"


    // MARK: Properties
	public var code: String?
	public var status: String?
	public var userCredit: String?
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
		code = json[kAddCreditBaseCodeKey].string
		status = json[kAddCreditBaseStatusKey].string
		userCredit = json[kAddCreditBaseUserCreditKey].string
		msg = json[kAddCreditBaseMsgKey].string

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
		code <- map[kAddCreditBaseCodeKey]
		status <- map[kAddCreditBaseStatusKey]
		userCredit <- map[kAddCreditBaseUserCreditKey]
		msg <- map[kAddCreditBaseMsgKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if code != nil {
			dictionary.updateValue(code!, forKey: kAddCreditBaseCodeKey)
		}
		if status != nil {
			dictionary.updateValue(status!, forKey: kAddCreditBaseStatusKey)
		}
		if userCredit != nil {
			dictionary.updateValue(userCredit!, forKey: kAddCreditBaseUserCreditKey)
		}
		if msg != nil {
			dictionary.updateValue(msg!, forKey: kAddCreditBaseMsgKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.code = aDecoder.decodeObjectForKey(kAddCreditBaseCodeKey) as? String
		self.status = aDecoder.decodeObjectForKey(kAddCreditBaseStatusKey) as? String
		self.userCredit = aDecoder.decodeObjectForKey(kAddCreditBaseUserCreditKey) as? String
		self.msg = aDecoder.decodeObjectForKey(kAddCreditBaseMsgKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(code, forKey: kAddCreditBaseCodeKey)
		aCoder.encodeObject(status, forKey: kAddCreditBaseStatusKey)
		aCoder.encodeObject(userCredit, forKey: kAddCreditBaseUserCreditKey)
		aCoder.encodeObject(msg, forKey: kAddCreditBaseMsgKey)

    }

}
