//
//  UploadImageUploadImageInteractorInput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import CoreLocation

protocol UploadImageInteractorInput {
    func uploadImage(_ image: WeatherImageUpload)
    func retriveMetadata(from info: [String : Any]) -> CLLocation?
}
