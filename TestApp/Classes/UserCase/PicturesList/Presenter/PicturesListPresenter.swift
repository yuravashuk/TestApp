//
//  PicturesListPicturesListPresenter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

class PicturesListPresenter: PicturesListModuleInput, PicturesListViewOutput, PicturesListInteractorOutput {

    weak var view: PicturesListViewInput!
    var interactor: PicturesListInteractorInput!
    var router: PicturesListRouterInput!

    fileprivate var items: [WeatherImage] = [] {
        didSet {
            view.togglePlaceholder(on: items.isEmpty)
        }
    }

    // MARK: PicturesListViewOutput
    func viewIsReady() {
        view.set(title: "My Pictures")
        view.setupInitialState()
    }
    
    func requestImages() {
        view.showSpinner()
        interactor.requestImages()
    }
    
    func addImage() {
        router.addImage()
    }
    
    func generateGif(_ weatherType: String) {
        view.showSpinner()
        interactor.generateGIF(weatherType)
    }

    func numberOfSections() -> Int {
        return 1
    }

    func numberOfItems(in section: Int) -> Int {
        return items.count
    }

    func picture(at index: Int, section: Int) -> WeatherImage {
        return items[index]
    }

    func logout() {
        interactor.logout()
    }
    
    // MARK: PicturesListInteractorOutput
    func responseImages(_ images: [WeatherImage]) {
        items = images
        view.hideSpinner()
        view.refreshView()
    }
    
    func failedLoadImages() {
        view.hideSpinner()
        view.refreshView()
        view.togglePlaceholder(on: true)
    }
    
    func responseGIF(_ url: String) {
        view.hideSpinner()
        router.showGIF(from: url)
    }
    
    func failedLoadGIF(_ message: String) {
        view.hideSpinner()
        view.showError(message)
    }

    func successLogout() {
        router.startScreen()
    }
    
}
