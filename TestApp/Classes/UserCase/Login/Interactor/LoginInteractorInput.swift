//
//  LoginLoginInteractorInput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import UIKit

protocol LoginInteractorInput {
    func login(email: String, password: String)
    func register(user: User, avatar: UIImage?)
}
