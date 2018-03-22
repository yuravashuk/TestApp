//
//  SessionHelper.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import KeychainSwift

final class SessionHelper {
    
    private static let token_key = "auth_token"

    static var isTokenAvailable: Bool {
        guard let user = User.currentUser,
            let token = user.token,
            !token.isEmpty else {
            return false
        }

        return true
    }

    static func logout() {
        let keychain = KeychainSwift()
        keychain.set("", forKey: token_key)
    }

    static func storeUser() {
        if !isTokenAvailable {
            return
        }
        
        let keychain = KeychainSwift()
        keychain.set(User.currentUser.token!, forKey: token_key)
    }
    
    static func retriveUser() {
        let keychain = KeychainSwift()
        let token = keychain.get(token_key)
        
        if let user = User.currentUser {
            user.token = token
        } else {
            User.currentUser = User()
            User.currentUser.token = token
        }
    }

}
