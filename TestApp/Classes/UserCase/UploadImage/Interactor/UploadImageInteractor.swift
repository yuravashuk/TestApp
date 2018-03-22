//
//  UploadImageUploadImageInteractor.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Photos

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

    func retriveMetadata(from info: [String : Any]) -> CLLocation? {
        if let url = info[UIImagePickerControllerReferenceURL] as? URL {
            let options = PHFetchOptions()
            options.fetchLimit = 1

            let assets = PHAsset.fetchAssets(withALAssetURLs: [url], options: options)
            let asset = assets[0]
            if let location = asset.location {
                return location
            }
        }

        return nil
    }

}
