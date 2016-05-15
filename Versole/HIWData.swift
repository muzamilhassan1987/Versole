//
//  HIWData.swift
//
//  Created by Soomro Shahid on 5/9/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class HIWData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kHIWDataDescriptionValueKey: String = "description"
	internal let kHIWDataHeadingKey: String = "heading"


    // MARK: Properties
	public var descriptionValue: String?
	public var heading: String?


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
		descriptionValue = json[kHIWDataDescriptionValueKey].string
		heading = json[kHIWDataHeadingKey].string

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
		descriptionValue <- map[kHIWDataDescriptionValueKey]
		heading <- map[kHIWDataHeadingKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if descriptionValue != nil {
			dictionary.updateValue(descriptionValue!, forKey: kHIWDataDescriptionValueKey)
		}
		if heading != nil {
			dictionary.updateValue(heading!, forKey: kHIWDataHeadingKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.descriptionValue = aDecoder.decodeObjectForKey(kHIWDataDescriptionValueKey) as? String
		self.heading = aDecoder.decodeObjectForKey(kHIWDataHeadingKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(descriptionValue, forKey: kHIWDataDescriptionValueKey)
		aCoder.encodeObject(heading, forKey: kHIWDataHeadingKey)

    }

}
