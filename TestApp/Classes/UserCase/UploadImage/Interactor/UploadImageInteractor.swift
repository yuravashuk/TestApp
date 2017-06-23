//
//  UploadImageUploadImageInteractor.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

class UploadImageInteractor: UploadImageInteractorInput {

    weak var output: UploadImageInteractorOutput!
    var service: ImagesServiceProtocol!
    
    func uploadImage(_ image: WeatherImageUpload) {
        service.uploadImage(image: image) { [weak self] (response) in
            guard response.isSuccess else {
                self?.output.uploadFailed()
                return
            }
            
            self?.output.uploadSuccess()
        }
    }

}
