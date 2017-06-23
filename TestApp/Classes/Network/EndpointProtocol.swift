//
//  EndpointProtocol.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import Alamofire

protocol BaseUrl {
    static var baseUrl:URL { get }
}

extension BaseUrl{
    static var baseUrl:URL {
        return NetworkConstants.BaseUrl
    }
}

protocol EndpointProtocol : BaseUrl, URLRequestConvertible {
    var parameters: [String: Any]? { get }
    var path : String { get }
    var method : HTTPMethod { get }
    var rootKey: String { get }
}

extension EndpointProtocol {
    
    func asURLRequest() throws -> URLRequest {
        let url = try? Self.baseUrl.asURL()
        var urlRequest = URLRequest(url: (url?.appendingPathComponent(path))!)
        urlRequest.httpMethod = method.rawValue
        urlRequest = try URLEncoding.default.encode(urlRequest, with: parameters)
        return urlRequest
    }
    
}
