//
//  UserEndpoint.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import Alamofire

enum UserEndpoint {
    
    case login(email: String , password: String)
    case register(user: User, avatar: Data)
    
}

extension UserEndpoint: EndpointProtocol {

    var parameters: [String: Any]? {
        switch self {
        case .login(let email, let password):
            var params: [String:Any] = [:]
            params["email"] = email
            params["password"] = password
            return params
        case .register(let user, _):
            var params: [String:Any] = [:]
            
            if let name = user.name, name.isEmpty {
                params["username"] = user.name
            }
            
            params["email"] = user.email
            params["password"] = user.password
            return params
        }
        
    }
    
    var path : String {
        switch self {
        case .login(_,_):
            return "/login"
        case .register(_, _):
            return "/create"
        }
    }
    
    var method : HTTPMethod {
        switch self {
        case .login(_,_):
            return .post
        case .register(_, _):
            return .post
        }
    }
    
    var rootKey: String {
        return ""
    }

}




