//
//  UploadImageUploadImageConfigurator.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class UploadImageModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {
        if let viewController = viewInput as? UploadImageViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: UploadImageViewController) {

        let router = UploadImageRouter()
        router.transitionHandler = viewController

        let presenter = UploadImagePresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = UploadImageInteractor()
        interactor.output = presenter
        interactor.service = ImagesService()

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
