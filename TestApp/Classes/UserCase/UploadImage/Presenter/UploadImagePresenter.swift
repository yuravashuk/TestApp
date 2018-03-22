//
//  UploadImageUploadImagePresenter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Photos
import CoreLocation

class UploadImagePresenter: UploadImageModuleInput, UploadImageViewOutput, UploadImageInteractorOutput {

    weak var view: UploadImageViewInput!
    var interactor: UploadImageInteractorInput!
    var router: UploadImageRouterInput!
    
    private let locationManager = LocationHelper()

    func viewIsReady() {
        view.set(title: "Upload Picture")
        view.setupInitialState()
    }
    
    // MARK: UploadImageViewOutput
    func uploadImage(_ description: String?, hashtag: String?, metadata: CLLocation?, image: UIImage) {
        
        locationManager.authorize()
        
        if !locationManager.enabled, metadata == nil {
            router.showLocationAlert()
            return
        }
        
        guard let imageData = UIImageJPEGRepresentation(image, 0.5) else {
            view.showError("Invalid image data")
            return
        }
        
        let parameters = WeatherImageParameters()
        
        if locationManager.enabled {
            parameters.latitude = Float(locationManager.latitude)
            parameters.longitude = Float(locationManager.longitude)
        } else {
            if let coordinate = metadata?.coordinate {
                parameters.latitude = Float(coordinate.latitude)
                parameters.longitude = Float(coordinate.longitude)
            }
        }

        let image = WeatherImageUpload(description: description, hashtags: hashtag, image: imageData, parameters: parameters)

        view.showSpinner()
        interactor.uploadImage(image)
    }

    func retriveMetadata(from info: [String : Any]) -> CLLocation? {
        return interactor.retriveMetadata(from: info)
    }
    
    func close() {
        router.dissmiss()
    }

    // MARK: UploadImageInteractorOutput
    func uploadFailed() {
        view.hideSpinner()
        view.showError(NetworkError.wrong.localizedDescription)
    }
    
    func uploadSuccess() {
        view.hideSpinner()
        view.showSuccess("Uploaded!")
        router.dissmiss()
    }
    
}
