//
//  LoginLoginPresenter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import SVProgressHUD

class LoginPresenter: LoginModuleInput, LoginViewOutput, LoginInteractorOutput {

    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    
    fileprivate var isRegistration = true

    func viewIsReady() {
        view.setupInitialState()
    }

    func send(userName: String?, email: String?, password: String?, avatar: UIImage?) {
        SVProgressHUD.show()
        
        if isRegistration {
            let user = User()
            user.name = userName
            user.email = email
            user.password = password
            interactor.register(user: user, avatar: avatar)
        } else {
            interactor.login(email: email!, password: password!)
        }
    }
    
    func set(isRegistration: Bool) {
        self.isRegistration = isRegistration
    }
    
    func showError(_ message: String) {
        router.displayError(message)
    }
    
    // MARK: LoginInteractorOutput
    
    func responseSendRequest() {
        if isRegistration {
            SVProgressHUD.showSuccess(withStatus: "Registered!")
        }
        
        SVProgressHUD.dismiss()
        router.showPicturesList()
    }
    
    func responseFailedRequest(_ message: String) {
        SVProgressHUD.dismiss()
        showError(message)
    }
    
}
