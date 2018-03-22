//
//  LoginLoginViewInput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

protocol LoginViewInput: class {

    /**
        @author Yura Vash
        Setup initial state of the view
    */

    func setupInitialState()
    func onSuccess()
    func showError(_ message: String)
    func showSpinner()
    func showSuccess(_ message: String)
    func hideSpinner()
    func dismissKeyboard()
}
