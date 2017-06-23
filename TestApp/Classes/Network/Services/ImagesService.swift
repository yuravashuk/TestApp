//
//  ImagesService.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Alamofire

class ImagesService: ImagesServiceProtocol {
    
    fileprivate let manager = NetworkManager()
    
    func getImages(completion: @escaping (Result<[WeatherImage]>) -> Void) {
        let endpoint = ImagesEndpoint.list()
        manager.request(endpoint: endpoint) { (images) in
            completion(images)
        }
    }
    
    func generateGIF(weather: String, completion: @escaping (Result<WeatherGIF>) -> Void) {
        let endpoint = ImagesEndpoint.gif(weather: weather)
        manager.request(endpoint: endpoint) { (image) in
            completion(image)
        }
    }
    
    func uploadImage(image: WeatherImageUpload, completion: @escaping (Result<WeatherImage>) -> Void) {
        let endpoint = ImagesEndpoint.image(image: image)
        manager.upload(endpoint: endpoint, images: ["image" : image.image!]) { (response) in
            completion(response)
        }
    }
    
}
