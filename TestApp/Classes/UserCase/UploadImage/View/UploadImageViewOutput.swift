//
//  UploadImageUploadImageViewOutput.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import CoreLocation

protocol UploadImageViewOutput {

    /**
        @author Yura Vash
        Notify presenter that view is ready
    */

    func viewIsReady()
    func retriveMetadata(from info: [String : Any]) -> CLLocation?
    func uploadImage(_ description: String?, hashtag: String?, metadata: CLLocation?, image: UIImage)
    func close()
    
}
