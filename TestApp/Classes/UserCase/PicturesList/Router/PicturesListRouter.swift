//
//  PicturesListPicturesListRouter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit

class PicturesListRouter: PicturesListRouterInput {
    
    weak var transitionHandler: UIViewController?
    
    func showGIF(from url: String) {
        let identifier = GIFPopupViewController.storyboardIdentifier
        if let vc = transitionHandler?.storyboard?.instantiateViewController(withIdentifier: identifier) as? GIFPopupViewController {
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            vc.imageUrl = url
            transitionHandler?.present(vc, animated: true, completion: nil)
        }
    }
    
    func addImage() {
        let identifier = UploadImageViewController.storyboardIdentifier
        if let vc = transitionHandler?.storyboard?.instantiateViewController(withIdentifier: identifier) {
            transitionHandler?.present(vc, animated: true, completion: nil)
        }
    }
    
}
