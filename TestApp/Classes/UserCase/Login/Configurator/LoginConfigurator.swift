//
//  LoginLoginConfigurator.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class LoginModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? LoginViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: LoginViewController) {

        let router = LoginRouter()

        let presenter = LoginPresenter()
        presenter.view = viewController
        presenter.router = router
        
        router.transitionHandler = viewController

        let interactor = LoginInteractor()
        interactor.output = presenter
        interactor.service = UserService()

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
