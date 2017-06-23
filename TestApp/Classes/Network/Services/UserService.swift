//
//  UserService.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Alamofire

class UserService: UserServiceProtocol {
    
    fileprivate let manager = NetworkManager()
    
    func login(email: String, password: String, completion: @escaping (_ user: Result<User>) -> Void) {
        let endpoint = UserEndpoint.login(email: email, password: password)
        manager.request(endpoint: endpoint) { (user) in
            completion(user)
        }
    }
    
    func register(user: User, avatar: Data, completion: @escaping (_ user: Result<User>) -> Void) {
        let endpoint = UserEndpoint.register(user: user, avatar: avatar)
        manager.upload(endpoint: endpoint, images: ["avatar" : avatar]) { (response) in
            completion(response)
        }
    }
    
}
