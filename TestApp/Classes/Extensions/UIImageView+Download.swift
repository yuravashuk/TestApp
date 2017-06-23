//
//  UIImageView+Download.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import Alamofire

extension UIImageView {
    
    func download(from url: String) {
        Alamofire.request(url).responseData(completionHandler: { [weak self] (response) in
            if let data = response.result.value {
                self?.image = UIImage(data: data)
            }
        })
    }
    
    func download(from url: String, completion: @escaping () -> Void) {
        Alamofire.request(url).responseData(completionHandler: { [weak self] (response) in
            if let data = response.result.value {
                self?.image = UIImage(data: data)
                completion()
            }
        })
    }
    
}
