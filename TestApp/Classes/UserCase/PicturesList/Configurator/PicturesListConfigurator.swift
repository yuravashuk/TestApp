//
//  PicturesListPicturesListConfigurator.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class PicturesListModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? PicturesListViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: PicturesListViewController) {

        let router = PicturesListRouter()
        router.transitionHandler = viewController

        let presenter = PicturesListPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = PicturesListInteractor()
        interactor.output = presenter
        interactor.service = ImagesService()

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
