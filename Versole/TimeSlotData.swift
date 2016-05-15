//
//  TimeSlotData.swift
//
//  Created by Soomro Shahid on 5/14/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class TimeSlotData: NSObject, Mappable {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kTimeSlotDataDescriptionValueKey: String = "description"
	internal let kTimeSlotDataAvailableTimeSlotsKey: String = "availableTimeSlots"
	internal let kTimeSlotDataHeadingKey: String = "heading"


    // MARK: Properties
	public var descriptionValue: String?
	public var availableTimeSlots: [TimeSlotAvailableTimeSlots]?
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
		descriptionValue = json[kTimeSlotDataDescriptionValueKey].string
		availableTimeSlots = []
		if let items = json[kTimeSlotDataAvailableTimeSlotsKey].array {
			for item in items {
				availableTimeSlots?.append(TimeSlotAvailableTimeSlots(json: item))
			}
		} else {
			availableTimeSlots = nil
		}
		heading = json[kTimeSlotDataHeadingKey].string

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
		descriptionValue <- map[kTimeSlotDataDescriptionValueKey]
		availableTimeSlots <- map[kTimeSlotDataAvailableTimeSlotsKey]
		heading <- map[kTimeSlotDataHeadingKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if descriptionValue != nil {
			dictionary.updateValue(descriptionValue!, forKey: kTimeSlotDataDescriptionValueKey)
		}
		if availableTimeSlots?.count > 0 {
			var temp: [AnyObject] = []
			for item in availableTimeSlots! {
				temp.append(item.dictionaryRepresentation())
			}
			dictionary.updateValue(temp, forKey: kTimeSlotDataAvailableTimeSlotsKey)
		}
		if heading != nil {
			dictionary.updateValue(heading!, forKey: kTimeSlotDataHeadingKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.descriptionValue = aDecoder.decodeObjectForKey(kTimeSlotDataDescriptionValueKey) as? String
		self.availableTimeSlots = aDecoder.decodeObjectForKey(kTimeSlotDataAvailableTimeSlotsKey) as? [TimeSlotAvailableTimeSlots]
		self.heading = aDecoder.decodeObjectForKey(kTimeSlotDataHeadingKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(descriptionValue, forKey: kTimeSlotDataDescriptionValueKey)
		aCoder.encodeObject(availableTimeSlots, forKey: kTimeSlotDataAvailableTimeSlotsKey)
		aCoder.encodeObject(heading, forKey: kTimeSlotDataHeadingKey)

    }

}
