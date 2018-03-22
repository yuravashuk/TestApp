//
//  UploadImageUploadImageViewInput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

protocol UploadImageViewInput: class {

    /**
        @author Yura Vash
        Setup initial state of the view
    */

    func setupInitialState()
    func set(title: String)
    func showError(_ message: String)
    func showSuccess(_ message: String)
    func showSpinner()
    func hideSpinner()
}
