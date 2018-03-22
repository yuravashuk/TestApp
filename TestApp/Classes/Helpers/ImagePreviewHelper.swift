//
//  ImagePreviewHelper.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-22.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import SVProgressHUD

final class ImagePreviewHelper {
    
    private let imagePreview: UIImageView = UIImageView()
    private var closePreviewGesture: UITapGestureRecognizer!
    weak var view: UIView?
    
    required init(viewController: UIViewController) {
        self.view = viewController.view
        configurePreviewImageView()
    }
    
    func configurePreviewImageView() {
        self.imagePreview.isHidden = true
        self.imagePreview.backgroundColor = UIColor.black
        self.imagePreview.contentMode = .scaleAspectFit
        self.imagePreview.isUserInteractionEnabled = true
        self.closePreviewGesture = UITapGestureRecognizer.init(target: self, action: #selector(actionCloseImagePreview(_:)))
        self.imagePreview.addGestureRecognizer(self.closePreviewGesture!)
        self.view?.addSubview(self.imagePreview)
    }
    
    @objc func actionCloseImagePreview(_ sender: UITapGestureRecognizer) {
        guard let view = view else {
            return
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.imagePreview.frame = CGRect.init(origin: view.center, size: CGSize.init(width: 20, height: 20))
        }) { (value) in
            self.imagePreview.isHidden = true
            SVProgressHUD.dismiss()
        }
    }
    
    func showImage(from url: String) {
        guard let view = self.view else {
            return
        }
        
        imagePreview.image = nil
        imagePreview.frame = CGRect.init(origin: view.center, size: CGSize.init(width: 20, height: 20))

        imagePreview.isHidden = false
        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.imagePreview.frame = view.bounds
            SVProgressHUD.show()
            self?.imagePreview.download(from: url, completion: {
                SVProgressHUD.dismiss()
            })
        }
    }
    
}
