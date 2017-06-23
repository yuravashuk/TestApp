//
//  WeatherGIF.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-23.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import ObjectMapper

class WeatherGIF: Mappable {

    var gifUrl: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        gifUrl <- map["gif"]
    }
    
}
