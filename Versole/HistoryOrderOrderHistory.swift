//
//  HistoryOrderOrderHistory.swift
//
//  Created by Soomro Shahid on 5/28/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class HistoryOrderOrderHistory: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kHistoryOrderOrderHistoryAddressKey: String = "address"
	internal let kHistoryOrderOrderHistoryTotalItemsKey: String = "totalItems"
	internal let kHistoryOrderOrderHistoryLastnameKey: String = "lastname"
	internal let kHistoryOrderOrderHistoryFirstnameKey: String = "firstname"
	internal let kHistoryOrderOrderHistoryOrderTypeKey: String = "orderType"
	internal let kHistoryOrderOrderHistoryCreditUsedKey: String = "creditUsed"
	internal let kHistoryOrderOrderHistoryOrderlineKey: String = "orderline"
	internal let kHistoryOrderOrderHistoryPickUpDateKey: String = "pickUpDate"
	internal let kHistoryOrderOrderHistoryItemNamesKey: String = "ItemNames"
	internal let kHistoryOrderOrderHistoryOrderIdKey: String = "orderId"
	internal let kHistoryOrderOrderHistoryCreditLeftKey: String = "creditLeft"
	internal let kHistoryOrderOrderHistoryItemCountKey: String = "itemCount"
	internal let kHistoryOrderOrderHistoryOrderStatusKey: String = "orderStatus"


    // MARK: Properties
	public var address: String?
	public var totalItems: String?
	public var lastname: String?
	public var firstname: String?
	public var orderType: String?
	public var creditUsed: String?
	public var orderline: String?
	public var pickUpDate: String?
	public var itemNames: String?
	public var orderId: String?
	public var creditLeft: String?
	public var itemCount: String?
	public var orderStatus: String?
    public var arrItem:NSMutableArray! = NSMutableArray()
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
    public override init() {
        
    }
    public init(json: JSON) {
		address = json[kHistoryOrderOrderHistoryAddressKey].string
		totalItems = json[kHistoryOrderOrderHistoryTotalItemsKey].string
		lastname = json[kHistoryOrderOrderHistoryLastnameKey].string
		firstname = json[kHistoryOrderOrderHistoryFirstnameKey].string
		orderType = json[kHistoryOrderOrderHistoryOrderTypeKey].string
		creditUsed = json[kHistoryOrderOrderHistoryCreditUsedKey].string
		orderline = json[kHistoryOrderOrderHistoryOrderlineKey].string
		pickUpDate = json[kHistoryOrderOrderHistoryPickUpDateKey].string
		itemNames = json[kHistoryOrderOrderHistoryItemNamesKey].string
		orderId = json[kHistoryOrderOrderHistoryOrderIdKey].string
		creditLeft = json[kHistoryOrderOrderHistoryCreditLeftKey].string
		itemCount = json[kHistoryOrderOrderHistoryItemCountKey].string
		orderStatus = json[kHistoryOrderOrderHistoryOrderStatusKey].string

        arrItem = NSMutableArray()
        
      
        
        
        let data = orderline!.dataUsingEncoding(NSUTF8StringEncoding)!
        
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let items = json as? NSArray {
                for itemDict in items as! [NSDictionary] {
                    print (itemDict.valueForKey("itemCount"))
                    print (itemDict.valueForKey("itemId"))
                    self.arrItem.addObject(itemDict)
                }
                print(self.arrItem)
            }
        } catch let error as NSError {
            print("Failed to load: \(error.localizedDescription)")
        }
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
		address <- map[kHistoryOrderOrderHistoryAddressKey]
		totalItems <- map[kHistoryOrderOrderHistoryTotalItemsKey]
		lastname <- map[kHistoryOrderOrderHistoryLastnameKey]
		firstname <- map[kHistoryOrderOrderHistoryFirstnameKey]
		orderType <- map[kHistoryOrderOrderHistoryOrderTypeKey]
		creditUsed <- map[kHistoryOrderOrderHistoryCreditUsedKey]
		orderline <- map[kHistoryOrderOrderHistoryOrderlineKey]
		pickUpDate <- map[kHistoryOrderOrderHistoryPickUpDateKey]
		itemNames <- map[kHistoryOrderOrderHistoryItemNamesKey]
		orderId <- map[kHistoryOrderOrderHistoryOrderIdKey]
		creditLeft <- map[kHistoryOrderOrderHistoryCreditLeftKey]
		itemCount <- map[kHistoryOrderOrderHistoryItemCountKey]
		orderStatus <- map[kHistoryOrderOrderHistoryOrderStatusKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if address != nil {
			dictionary.updateValue(address!, forKey: kHistoryOrderOrderHistoryAddressKey)
		}
		if totalItems != nil {
			dictionary.updateValue(totalItems!, forKey: kHistoryOrderOrderHistoryTotalItemsKey)
		}
		if lastname != nil {
			dictionary.updateValue(lastname!, forKey: kHistoryOrderOrderHistoryLastnameKey)
		}
		if firstname != nil {
			dictionary.updateValue(firstname!, forKey: kHistoryOrderOrderHistoryFirstnameKey)
		}
		if orderType != nil {
			dictionary.updateValue(orderType!, forKey: kHistoryOrderOrderHistoryOrderTypeKey)
		}
		if creditUsed != nil {
			dictionary.updateValue(creditUsed!, forKey: kHistoryOrderOrderHistoryCreditUsedKey)
		}
		if orderline != nil {
			dictionary.updateValue(orderline!, forKey: kHistoryOrderOrderHistoryOrderlineKey)
		}
		if pickUpDate != nil {
			dictionary.updateValue(pickUpDate!, forKey: kHistoryOrderOrderHistoryPickUpDateKey)
		}
		if itemNames != nil {
			dictionary.updateValue(itemNames!, forKey: kHistoryOrderOrderHistoryItemNamesKey)
		}
		if orderId != nil {
			dictionary.updateValue(orderId!, forKey: kHistoryOrderOrderHistoryOrderIdKey)
		}
		if creditLeft != nil {
			dictionary.updateValue(creditLeft!, forKey: kHistoryOrderOrderHistoryCreditLeftKey)
		}
		if itemCount != nil {
			dictionary.updateValue(itemCount!, forKey: kHistoryOrderOrderHistoryItemCountKey)
		}
		if orderStatus != nil {
			dictionary.updateValue(orderStatus!, forKey: kHistoryOrderOrderHistoryOrderStatusKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.address = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryAddressKey) as? String
		self.totalItems = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryTotalItemsKey) as? String
		self.lastname = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryLastnameKey) as? String
		self.firstname = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryFirstnameKey) as? String
		self.orderType = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryOrderTypeKey) as? String
		self.creditUsed = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryCreditUsedKey) as? String
		self.orderline = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryOrderlineKey) as? String
		self.pickUpDate = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryPickUpDateKey) as? String
		self.itemNames = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryItemNamesKey) as? String
		self.orderId = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryOrderIdKey) as? String
		self.creditLeft = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryCreditLeftKey) as? String
		self.itemCount = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryItemCountKey) as? String
		self.orderStatus = aDecoder.decodeObjectForKey(kHistoryOrderOrderHistoryOrderStatusKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(address, forKey: kHistoryOrderOrderHistoryAddressKey)
		aCoder.encodeObject(totalItems, forKey: kHistoryOrderOrderHistoryTotalItemsKey)
		aCoder.encodeObject(lastname, forKey: kHistoryOrderOrderHistoryLastnameKey)
		aCoder.encodeObject(firstname, forKey: kHistoryOrderOrderHistoryFirstnameKey)
		aCoder.encodeObject(orderType, forKey: kHistoryOrderOrderHistoryOrderTypeKey)
		aCoder.encodeObject(creditUsed, forKey: kHistoryOrderOrderHistoryCreditUsedKey)
		aCoder.encodeObject(orderline, forKey: kHistoryOrderOrderHistoryOrderlineKey)
		aCoder.encodeObject(pickUpDate, forKey: kHistoryOrderOrderHistoryPickUpDateKey)
		aCoder.encodeObject(itemNames, forKey: kHistoryOrderOrderHistoryItemNamesKey)
		aCoder.encodeObject(orderId, forKey: kHistoryOrderOrderHistoryOrderIdKey)
		aCoder.encodeObject(creditLeft, forKey: kHistoryOrderOrderHistoryCreditLeftKey)
		aCoder.encodeObject(itemCount, forKey: kHistoryOrderOrderHistoryItemCountKey)
		aCoder.encodeObject(orderStatus, forKey: kHistoryOrderOrderHistoryOrderStatusKey)

    }

}
