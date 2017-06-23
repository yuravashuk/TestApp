//
//  UploadImageUploadImageRouter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class UploadImageRouter: UploadImageRouterInput {
    
    weak var transitionHandler: UIViewController?
    
    func dissmiss() {
        transitionHandler?.dismiss(animated: true, completion: nil)
    }
    
    func showLocationAlert() {
        let alertController = UIAlertController(
            title:  "Location Access Disabled",
            message: "Location settings",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        let openAction = UIAlertAction(title: "Open Settings", style: .default) { (action) in
            if let url = URL(string:UIApplicationOpenSettingsURLString) {
                UIApplication.shared.openURL(url)
            }
        }
        alertController.addAction(openAction)
        transitionHandler?.present(alertController, animated: true, completion: nil)
    }
    
}
