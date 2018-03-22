//
//  LoginLoginPresenter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

final class LoginPresenter: LoginModuleInput, LoginViewOutput, LoginInteractorOutput, ValidatorDelegate {

    fileprivate struct ErrorCodes {
        static let emptyUserName = "Please enter user name"
        static let emptyEmail = "Please enter email address"
        static let invalidEmail = "Please enter valid email address"
        static let emptyPassword = "Please enter password"
        static let smallPassword = "Password must contains 8 characters at least"
    }

    weak var view: LoginViewInput!
    var interactor: LoginInteractorInput!
    var router: LoginRouterInput!
    let validator: Validator
    
    fileprivate var isRegistration = true

    init() {
        self.validator = Validator()
        self.validator.set(delegate: self)
    }

    func viewIsReady() {
        view.setupInitialState()
    }

    func registerEmail(textField: UITextField) {
        validator.registerTextField(textField, validators: [EmptyStringValidator(message: ErrorCodes.emptyEmail),
                                                            EmailValidator(message: ErrorCodes.invalidEmail)])
    }

    func registerPassword(textField: UITextField) {
        validator.registerTextField(textField, validators: [EmptyStringValidator(message: ErrorCodes.emptyPassword)])
    }

    func send(userName: String?, email: String?, password: String?, avatar: UIImage?) {
        view.showSpinner()
        
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
    
    func set(isRegistration: Bool, imageWasSelected: Bool) {
        self.isRegistration = isRegistration
        view.dismissKeyboard()

        if isRegistration {
            guard imageWasSelected else {
                view.showError("Please, select avatar image.")
                return
            }
        }

        self.validator.validate()
    }

    // MARK: ValidatorDelegate

    func onSuccess() {
        view.onSuccess()
    }

    func onFailed(_ message: String) {
        view.showError(message)
    }
    
    // MARK: LoginInteractorOutput
    
    func responseSendRequest() {
        if isRegistration {
            view.showSuccess("Registered!")
        }
        
        view.hideSpinner()
        router.showPicturesList()
    }
    
    func responseFailedRequest(_ message: String) {
        view.hideSpinner()
        view.showError(message)
    }
    

}

