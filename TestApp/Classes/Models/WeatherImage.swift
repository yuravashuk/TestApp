//
//  WeatherImage.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherImage: NSObject, Mappable {
    
    var id: Int?
    var parameters: WeatherImageParameters?
    var smallImagePath: String = ""
    var bigImagePath: String = ""
    
    static var currentUser: User!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        parameters <- map["parameters"]
        smallImagePath <- map["smallImagePath"]
        bigImagePath <- map["bigImagePath"]
    }
    
}
