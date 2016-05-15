//
//  TimeSlotAvailableTimeSlots.swift
//
//  Created by Soomro Shahid on 5/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class TimeSlotAvailableTimeSlots: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kTimeSlotAvailableTimeSlotsSlotTimeKey: String = "slotTime"
	internal let kTimeSlotAvailableTimeSlotsSlotIdKey: String = "slotId"


    // MARK: Properties
	public var slotTime: String?
	public var slotId: String?


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
		slotTime = json[kTimeSlotAvailableTimeSlotsSlotTimeKey].string
		slotId = json[kTimeSlotAvailableTimeSlotsSlotIdKey].string

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
		slotTime <- map[kTimeSlotAvailableTimeSlotsSlotTimeKey]
		slotId <- map[kTimeSlotAvailableTimeSlotsSlotIdKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if slotTime != nil {
			dictionary.updateValue(slotTime!, forKey: kTimeSlotAvailableTimeSlotsSlotTimeKey)
		}
		if slotId != nil {
			dictionary.updateValue(slotId!, forKey: kTimeSlotAvailableTimeSlotsSlotIdKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.slotTime = aDecoder.decodeObjectForKey(kTimeSlotAvailableTimeSlotsSlotTimeKey) as? String
		self.slotId = aDecoder.decodeObjectForKey(kTimeSlotAvailableTimeSlotsSlotIdKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(slotTime, forKey: kTimeSlotAvailableTimeSlotsSlotTimeKey)
		aCoder.encodeObject(slotId, forKey: kTimeSlotAvailableTimeSlotsSlotIdKey)

    }

}
