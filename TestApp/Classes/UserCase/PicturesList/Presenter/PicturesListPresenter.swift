//
//  PicturesListPicturesListPresenter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import SVProgressHUD

class PicturesListPresenter: PicturesListModuleInput, PicturesListViewOutput, PicturesListInteractorOutput {

    weak var view: PicturesListViewInput!
    var interactor: PicturesListInteractorInput!
    var router: PicturesListRouterInput!

    // MARK: PicturesListViewOutput
    func viewIsReady() {
        view.setupInitialState()
    }
    
    func requestImages() {
        SVProgressHUD.show()
        interactor.requestImages()
    }
    
    func addImage() {
        router.addImage()
    }
    
    func generateGif(_ weatherType: String) {
        SVProgressHUD.show()
        interactor.generateGIF(weatherType)
    }
    
    // MARK: PicturesListInteractorOutput
    func responseImages(_ images: [WeatherImage]) {
        SVProgressHUD.dismiss()
        view.presentImages(images)
    }
    
    func failedLoadImages() {
        SVProgressHUD.dismiss()
        view.tooglePlaceholder()
    }
    
    func responseGIF(_ url: String) {
        SVProgressHUD.dismiss()
        router.showGIF(from: url)
    }
    
    func failedLoadGIF(_ message: String) {
        SVProgressHUD.dismiss()
        SVProgressHUD.showError(withStatus: message)
    }
    
}
