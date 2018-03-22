//
//  LoginLoginViewController.swift
//  TestApp
//
//  Created by Yura Vash on 20/06/2017.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginViewController: UIViewController, LoginViewInput {

    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    fileprivate var avatarGesture: UILongPressGestureRecognizer!
    fileprivate var imageWasSelected = false
    
    static let storyboardIdentifier = String(describing: LoginViewController.self)

    var output: LoginViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unregisterKeyboardEvents()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.bounds.size.width / 2
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: LoginViewInput
    func setupInitialState() {
        configureTextFields()
        configureAvatarImage()
        registerKeyboardEvents()
    }

    func showError(_ message: String) {
        SVProgressHUD.showError(withStatus: message)
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }

    func showSpinner() {
        SVProgressHUD.show()
    }

    func showSuccess(_ message: String) {
        SVProgressHUD.showSuccess(withStatus: message)
    }

    func hideSpinner() {
        SVProgressHUD.dismiss()
    }
    
    // MARK: Configurations
    fileprivate func configureTextFields() {
        userNameText.setBottomBorder()
        emailText.setBottomBorder()
        passwordText.setBottomBorder()

        userNameText.delegate = self
        emailText.delegate = self
        passwordText.delegate = self

        output.registerEmail(textField: emailText)
        output.registerPassword(textField: passwordText)
    }

    func onSuccess() {
        let userName = userNameText.text
        let email = emailText.text
        let password = passwordText.text
        output.send(userName: userName, email: email, password: password, avatar: avatarImage.image)
    }
    
    fileprivate func configureAvatarImage() {
        avatarImage.layer.masksToBounds = true
        avatarImage.isUserInteractionEnabled = true
        avatarImage.superview?.isUserInteractionEnabled = true
        
        avatarGesture = UILongPressGestureRecognizer(target: self, action: #selector(handlePressGesture(_:)))
        avatarGesture.minimumPressDuration = 0.1
        avatarImage.addGestureRecognizer(avatarGesture)
    }
    
    fileprivate func registerKeyboardEvents() {
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    fileprivate func unregisterKeyboardEvents() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: self.view.window)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: self.view.window)
    }
    
    // MARK: Actions
    
    @IBAction func actionLogin(_ sender: Any) {
        output.set(isRegistration: false, imageWasSelected: imageWasSelected)
    }
    
    @IBAction func actionRegister(_ sender: Any) {
        output.set(isRegistration: true, imageWasSelected: imageWasSelected)
    }
    
    
    @objc func handlePressGesture(_ recognizer: UILongPressGestureRecognizer) {
        switch recognizer.state {
        case .began, .changed:
            avatarImage.layer.borderWidth = 2.0
            avatarImage.layer.borderColor = UIColor.gray.cgColor
            avatarImage.layer.opacity = 0.9
            break
        case .ended:
            avatarImage.layer.borderWidth = 0.0
            avatarImage.layer.opacity = 1.0
            addPhotoWithOptions()
            break
        default:
            break
        }
    }
    
    
    // MARK: Keyboard Handling
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
               self.view.frame.origin.y -= keyboardSize.height - 44
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
}

// MARK: UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case userNameText:
            emailText.becomeFirstResponder()
            break
        case emailText:
            passwordText.becomeFirstResponder()
            break
        default:
            textField.resignFirstResponder()
            break
        }
        
        return true
    }
    
}

// MARK: UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension LoginViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        self.avatarImage.image = image
        imageWasSelected = true
        picker.dismiss(animated: true, completion: nil)
    }
    
}


