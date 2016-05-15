//
//  SocialShareData.swift
//
//  Created by Soomro Shahid on 5/8/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class SocialShareData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kSocialShareDataShareIdKey: String = "shareId"
	internal let kSocialShareDataShareTextKey: String = "shareText"


    // MARK: Properties
	public var shareId: String?
	public var shareText: String?


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
		shareId = json[kSocialShareDataShareIdKey].string
		shareText = json[kSocialShareDataShareTextKey].string

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
		shareId <- map[kSocialShareDataShareIdKey]
		shareText <- map[kSocialShareDataShareTextKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if shareId != nil {
			dictionary.updateValue(shareId!, forKey: kSocialShareDataShareIdKey)
		}
		if shareText != nil {
			dictionary.updateValue(shareText!, forKey: kSocialShareDataShareTextKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.shareId = aDecoder.decodeObjectForKey(kSocialShareDataShareIdKey) as? String
		self.shareText = aDecoder.decodeObjectForKey(kSocialShareDataShareTextKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(shareId, forKey: kSocialShareDataShareIdKey)
		aCoder.encodeObject(shareText, forKey: kSocialShareDataShareTextKey)

    }

}
