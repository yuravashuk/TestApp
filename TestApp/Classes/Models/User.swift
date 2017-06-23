//
//  User.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-20.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import ObjectMapper

class User: NSObject, Mappable {
    
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var avatar: String?
    var token: String?
    
    static var currentUser: User!
    
    override init() {
        super.init()
    }
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        password <- map["password"]
        avatar <- map["avatar"]
        token <- map["token"]
    }
    
}
