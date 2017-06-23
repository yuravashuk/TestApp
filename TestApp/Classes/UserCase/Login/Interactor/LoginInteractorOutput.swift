//
//  LoginLoginInteractorOutput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation

protocol LoginInteractorOutput: class {
    func responseSendRequest()
    func responseFailedRequest(_ message: String)
}
