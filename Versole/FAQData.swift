//
//  FAQData.swift
//
//  Created by Soomro Shahid on 5/8/16
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class FAQData: NSObject, Mappable, NSCoding {

    // MARK: Declaration for string constants to be used to decode and also serialize.
	internal let kFAQDataFaqIdKey: String = "faqId"
	internal let kFAQDataAnswerKey: String = "answer"
	internal let kFAQDataQuestionKey: String = "question"


    // MARK: Properties
	public var faqId: String?
	public var answer: String?
	public var question: String?


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
		faqId = json[kFAQDataFaqIdKey].string
		answer = json[kFAQDataAnswerKey].string
		question = json[kFAQDataQuestionKey].string

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
		faqId <- map[kFAQDataFaqIdKey]
		answer <- map[kFAQDataAnswerKey]
		question <- map[kFAQDataQuestionKey]

    }

    /**
    Generates description of the object in the form of a NSDictionary.
    - returns: A Key value pair containing all valid values in the object.
    */
    public func dictionaryRepresentation() -> [String : AnyObject ] {

        var dictionary: [String : AnyObject ] = [ : ]
		if faqId != nil {
			dictionary.updateValue(faqId!, forKey: kFAQDataFaqIdKey)
		}
		if answer != nil {
			dictionary.updateValue(answer!, forKey: kFAQDataAnswerKey)
		}
		if question != nil {
			dictionary.updateValue(question!, forKey: kFAQDataQuestionKey)
		}

        return dictionary
    }

    // MARK: NSCoding Protocol
    required public init(coder aDecoder: NSCoder) {
		self.faqId = aDecoder.decodeObjectForKey(kFAQDataFaqIdKey) as? String
		self.answer = aDecoder.decodeObjectForKey(kFAQDataAnswerKey) as? String
		self.question = aDecoder.decodeObjectForKey(kFAQDataQuestionKey) as? String

    }

    public func encodeWithCoder(aCoder: NSCoder) {
		aCoder.encodeObject(faqId, forKey: kFAQDataFaqIdKey)
		aCoder.encodeObject(answer, forKey: kFAQDataAnswerKey)
		aCoder.encodeObject(question, forKey: kFAQDataQuestionKey)

    }

}
