//
//  LoginLoginRouter.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import SVProgressHUD

class LoginRouter: LoginRouterInput {
    
    weak var transitionHandler: UIViewController?

    func showPicturesList() {
        let identifier = PicturesListViewController.storyboardIdentifier
        if let vc = transitionHandler?.storyboard?.instantiateViewController(withIdentifier: identifier) {
            transitionHandler?.navigationController?.setViewControllers([vc], animated: true)
        }
    }
    
}
