//
//  UploadImageUploadImagePresenter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import SVProgressHUD
import CoreLocation

class UploadImagePresenter: UploadImageModuleInput, UploadImageViewOutput, UploadImageInteractorOutput {

    weak var view: UploadImageViewInput!
    var interactor: UploadImageInteractorInput!
    var router: UploadImageRouterInput!
    
    private let locationManager = LocationHelper()

    func viewIsReady() {
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
            SVProgressHUD.showError(withStatus: "Invalid image data")
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

        SVProgressHUD.show()
        interactor.uploadImage(image)
    }
    
    func close() {
        router.dissmiss()
    }

    // MARK: UploadImageInteractorOutput
    func uploadFailed() {
        SVProgressHUD.dismiss()
        SVProgressHUD.showError(withStatus: NetworkError.wrong.localizedDescription)
    }
    
    func uploadSuccess() {
        SVProgressHUD.dismiss()
        SVProgressHUD.showSuccess(withStatus: "Uploaded!")
        router.dissmiss()
    }
    
}
