//
//  UploadImageUploadImageViewController.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import Photos
import CoreLocation
import SVProgressHUD

class UploadImageViewController: UIViewController, UploadImageViewInput {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var hashtagText: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!

    var output: UploadImageViewOutput!
    static let storyboardIdentifier = String(describing: UploadImageViewController.self)
    
    fileprivate var imageGesture: UILongPressGestureRecognizer!
    fileprivate var metadataLocation: CLLocation? = nil
    fileprivate var imageWasSelected = false
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardEvents()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    

    // MARK: UploadImageViewInput
    
    func setupInitialState() {
        registerKeyboardEvents()
        configureTextFields()
        configureImageView()
    }

    func set(title: String) {
        titleLabel.text = title
    }

    func showError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }

    func showSuccess(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }

    func showSpinner() {
        SVProgressHUD.show()
    }

    func hideSpinner() {
        SVProgressHUD.dismiss()
    }
    
    // MARK: Configurations
    
    private func configureTextFields() {
        descriptionText.setBottomBorder()
        hashtagText.setBottomBorder()
        
        descriptionText.delegate = self
        hashtagText.delegate = self
    }
    
    private func configureImageView() {
        imageGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePressGesture(_:)))
        imageGesture.minimumPressDuration = 0.1
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageGesture)
    }
    
    private func registerKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(UploadImageViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(UploadImageViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    private func unregisterKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    // MARK: Actions
    
    @IBAction func actionDone(_ sender: Any) {
        guard imageWasSelected else {
            showError("Please, select image.")
            return
        }
        
        guard let image = imageView.image else {
            return
        }
        
        let description = descriptionText.text
        let hashtag = hashtagText.text

        output.uploadImage(description, hashtag: hashtag, metadata: metadataLocation, image: image)
    }
    
    @IBAction func actionClose(_ sender: Any) {
        output.close()
    }
    
    @objc func handlePressGesture(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began, .changed:
            imageView.layer.borderWidth = 2.0
            imageView.layer.borderColor = UIColor.gray.cgColor
            imageView.layer.opacity = 0.9
            break
        case .ended:
            imageView.layer.borderWidth = 0.0
            imageView.layer.opacity = 1.0
            addPhotoWithOptions()
            break
        default:
            break
        }
    }
    
    
    // MARK: Keyboard Handling
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                let value = view.bounds.size.height - (hashtagText.frame.origin.y + hashtagText.bounds.size.height)
                if value <= keyboardSize.height {
                    view.frame.origin.y -= keyboardSize.height - (value + 8)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
    
}

// MARK: UITextFieldDelegate
extension UploadImageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case descriptionText:
            hashtagText.becomeFirstResponder()
            break
        case hashtagText:
            textField.resignFirstResponder()
            actionDone(self)
            break
        default:
            textField.resignFirstResponder()
            break
        }
        
        return true
    }
    
}

// MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension UploadImageViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func addPhotoWithOptions() {
        let camera = CameraHelper()
        camera.delegate = self
        
        let alertOptions = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertOptions.popoverPresentationController?.sourceView = self.view
        
        // photo library
        let photoLibraryOption = UIAlertAction(title: "Photo Library", style: .default) { (alert) in
            if !camera.presentPhotoLibrary(target: self, canEdit: false) {
                // some impl
            }
        }
        
        let cameraOption = UIAlertAction(title: "Camera", style: .default) { (alert) in
            if !camera.presentCamera(target: self, canEdit: false, cameraType: .rear) {
                // some impl
            }
        }
        
        let cancelOption = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertOptions.addAction(photoLibraryOption)
        alertOptions.addAction(cameraOption)
        alertOptions.addAction(cancelOption)
        
        self.present(alertOptions, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imageView.image = image
        imageWasSelected = true
        metadataLocation = output.retriveMetadata(from: info)
        picker.dismiss(animated: true, completion: nil)
    }
    
}
