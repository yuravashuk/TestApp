//
//  PicturesListPicturesListInteractorOutput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation

protocol PicturesListInteractorOutput: class {
    func responseImages(_ images: [WeatherImage])
    func failedLoadImages()
    func responseGIF(_ url: String)
    func failedLoadGIF(_ message: String)
    func successLogout()
}
