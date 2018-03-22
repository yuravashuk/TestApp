//
//  LoginLoginInteractor.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class LoginInteractor: LoginInteractorInput {

    weak var output: LoginInteractorOutput!
    var service: UserServiceProtocol!
    
    func login(email: String, password: String) {
        service.login(email: email, password: password, completion: { [weak self] user in
            guard user.isSuccess else {
                self?.output.responseFailedRequest(NetworkError.wrong.localizedDescription)
                return
            }
            
            User.currentUser = user.value
            SessionHelper.storeUser()
            self?.output.responseSendRequest()
        })
    }
    
    func register(user: User, avatar: UIImage?) {
        guard let avatar = avatar else {
            self.output.responseFailedRequest("Select avatar image")
            return
        }
        
        guard let data = UIImageJPEGRepresentation(avatar, 0.5) else {
            self.output.responseFailedRequest("Invalid image data")
            return
        }
        
        service.register(user: user, avatar: data, completion: { [weak self] user in
            guard user.isSuccess else {
                self?.output.responseFailedRequest(NetworkError.wrong.localizedDescription)
                return
            }
            
            User.currentUser = user.value
            SessionHelper.storeUser()
            self?.output.responseSendRequest()
        })
    }
    
}
