//
//  ImagesEndpoint.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import Alamofire

enum ImagesEndpoint {
    
    case list()
    case gif(weather: String)
    case image(image: WeatherImageUpload)
    
}

extension ImagesEndpoint: EndpointProtocol {
    
    var parameters: [String: Any]? {
        switch self {
        case .list():
            return nil
        case .gif(let weather):
            var params: [String:Any] = [:]
            params["weather"] = weather
            return params
        case .image(let image):
            var params: [String:Any] = [:]
            
            if let description = image.description {
                params["description"] = description
            }
            
            if let hashtag = image.hashtags {
                params["hashtag"] = hashtag
            }
            
            if let locationParams = image.parameters {
                params["latitude"] = locationParams.latitude
                params["longitude"] = locationParams.longitude
            }
            
            return params
        }
        
    }
    
    var path : String {
        switch self {
        case .list():
            return "/all"
        case .gif(_):
            return "/gif"
        case .image(_):
            return "/image"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .list():
            return .get
        case .gif(_):
            return .get
        case .image(_):
            return .post
        }
    }
    
    var rootKey: String {
        switch self {
        case .list():
            return "images"
        case .gif(_):
            return ""
        case .image(_):
            return ""
        }
    }
}
