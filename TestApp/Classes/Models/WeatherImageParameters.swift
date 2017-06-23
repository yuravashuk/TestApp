//
//  WeatherImageParameters.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import ObjectMapper

class WeatherImageParameters: NSObject, Mappable {
    
    var longitude: Float = 0.0
    var latitude: Float = 0.0
    var weather: String = ""
    var address: String = ""
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        longitude <- map["longitude"]
        latitude <- map["latitude"]
        weather <- map["weather"]
        address <- map["address"]
    }
    
}
