//
//  PicturesListPicturesListInteractor.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

class PicturesListInteractor: PicturesListInteractorInput {

    weak var output: PicturesListInteractorOutput!
    var service: ImagesServiceProtocol!
    
    func requestImages() {
        service.getImages { [weak self] (response) in
            
            guard response.isSuccess else {
                self?.output.failedLoadImages()
                return
            }

            guard let images = response.value else {
                self?.output.failedLoadImages()
                return
            }
            
            self?.output.responseImages(images)
        }
    }
    
    func generateGIF(_ weatherType: String) {
        service.generateGIF(weather: weatherType) { [weak self] (response) in
            guard response.isSuccess else {
                self?.output.failedLoadGIF(NetworkError.wrong.localizedDescription)
                return
            }
            
            guard let url = response.value?.gifUrl else {
                self?.output.failedLoadGIF(NetworkError.wrong.localizedDescription)
                return
            }
            
            self?.output.responseGIF(url)
        }
    }

}
