//
//  CameraHelper.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import UIKit

class CameraHelper {
    
    var delegate: (UINavigationControllerDelegate & UIImagePickerControllerDelegate)?
    
    func presentPhotoLibrary(target: UIViewController, canEdit: Bool) -> Bool {
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) && !UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            return false
        }
        
        let type = UIImagePickerControllerOriginalImage
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            imagePicker.sourceType = .photoLibrary
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary) {
                
                if (availableTypes as Array).contains(type) {
                    imagePicker.mediaTypes = [type]
                }
                
            }
            
        } else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            
            imagePicker.sourceType = .savedPhotosAlbum
            if let availableTypes = UIImagePickerController.availableMediaTypes(for: .savedPhotosAlbum) {
                
                if (availableTypes as Array).contains(type) {
                    imagePicker.mediaTypes = [type]
                }
                
            }
            
        } else {
            return false
        }
        
        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = self.delegate
        target.present(imagePicker, animated: true, completion: nil)
        
        return true
    }
    
    func presentCamera(target: UIViewController, canEdit: Bool, cameraType: UIImagePickerControllerCameraDevice) -> Bool {
        
        if !UIImagePickerController.isSourceTypeAvailable(.camera) || !UIImagePickerController.isCameraDeviceAvailable(cameraType) {
            return false
        }
        
        let imagePicker = UIImagePickerController()
        
        imagePicker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
        imagePicker.sourceType = UIImagePickerControllerSourceType.camera
        imagePicker.cameraCaptureMode = .photo
        imagePicker.allowsEditing = canEdit
        imagePicker.delegate = self.delegate
        target.present(imagePicker, animated: true, completion: nil)
        
        return true
    }
    
}
