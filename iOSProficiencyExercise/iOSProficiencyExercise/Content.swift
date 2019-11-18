//
//  Content.swift
//  iOSProficiencyExercise
//
//  Created by Jasmeet Singh on 18/11/19.
//  Copyright © 2019 Jasmeet. All rights reserved.
//

import ObjectMapper

class Content: Mappable {
    var title = ""
    var rows     = [Row]()
    
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title         <- map["title"]
        rows         <- map["rows"]
    }
    class func mapJsonDictionaryData(jsonDictionary:[String:AnyObject])->Content? {
        return Mapper<Content>().map(JSON:jsonDictionary)
    }
    class func mapJsonData(jsonString:String)->Content?{
        return Mapper<Content>().map(JSONString: jsonString)
    }
    class func mapModelData(model:Content)->String{
        return Mapper<Content>().toJSONString(model)!
    }
}
class Row: Mappable {
    var title:String       = ""
    var description:String = ""
    var imageHref:String      = ""
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        title               <- map["title"]
        description         <- map["description"]
    }
    
    class func mapJsonDictionaryData(jsonDictionary:[String:AnyObject])->Row? {
        return Mapper<Row>().map(JSON:jsonDictionary)
    }
    class func mapJsonData(jsonString:String)->Row?{
        return Mapper<Row>().map(JSONString: jsonString)
    }
    
}
