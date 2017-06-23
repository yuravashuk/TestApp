//
//  Protocols.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-20.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

protocol NetworkManagerProtocol {
    func upload<T:Mappable>(endpoint: EndpointProtocol, images: [String: Data], completion: @escaping (_ result: Result<T>) -> Void )
    func request<T:Mappable>(endpoint: EndpointProtocol, completion: @escaping (Result<T>) -> Void)
    func request<T:Mappable>(endpoint: EndpointProtocol, completion: @escaping (Result<[T]>) -> Void)
}

protocol UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (_ user: Result<User>) -> Void)
    func register(user: User, avatar: Data, completion: @escaping (_ user: Result<User>) -> Void)
}

protocol ImagesServiceProtocol {
    func getImages(completion: @escaping (Result<[WeatherImage]>) -> Void)
    func generateGIF(weather: String, completion: @escaping (Result<WeatherGIF>) -> Void)
    func uploadImage(image: WeatherImageUpload, completion: @escaping (Result<WeatherImage>) -> Void)
}
