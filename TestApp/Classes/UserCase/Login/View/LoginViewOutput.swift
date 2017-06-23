//
//  LoginLoginViewOutput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

protocol LoginViewOutput {

    /**
        @author Yura Vash
        Notify presenter that view is ready
    */

    func viewIsReady()
    func set(isRegistration: Bool)
    func showError(_ message: String)
    func send(userName: String?, email: String?, password: String?, avatar: UIImage?)
}
