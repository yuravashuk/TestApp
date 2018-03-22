//
//  Validator.swift
//  TestApp
//
//  Created by VoidPtr on 2017-06-21.
//  Copyright © 2017 PettersonApps. All rights reserved.
//

import Foundation
import UIKit

fileprivate struct ValidationError {
    var error: Bool = false
    var message: String = ""
}

protocol Validable {
    var message: String { get set }
    func validate(_ input: String) -> Bool
}

struct EmptyStringValidator: Validable {
    var message: String = ""
    func validate(_ input: String) -> Bool {
        return !input.isEmpty
    }
}

struct EmailValidator: Validable {
    var message: String = ""
    func validate(_ input: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: input)
    }
}

protocol ValidatorDelegate: class {
    func onSuccess()
    func onFailed(_ message: String)
}

final class Validator {
    
    fileprivate struct ValidableObject {
        weak var textField: UITextField?
        var enabled = true
        var validators: [Validable] = []
    }

    fileprivate var validableObjects: [ValidableObject] = []
    fileprivate weak var delegate: ValidatorDelegate?

    init(delegate: ValidatorDelegate? = nil) {
        self.delegate = delegate
    }

    func set(delegate: ValidatorDelegate?) {
        self.delegate = delegate
    }

    func registerTextField(_ textField: UITextField, validators: [Validable]) {
        let object = ValidableObject(textField: textField, enabled: true, validators: validators)
        validableObjects.append(object)
    }
    
    func unregister(_ textField: UITextField) {
        if let validIndex = (validableObjects.index{$0.textField == textField }) {
            validableObjects.remove(at: validIndex)
        }
    }
    
    func reset() {
        validableObjects.removeAll()
    }
    
    func setEnabled(_ enabled: Bool, for textField: UITextField) {
        if let validIndex = (validableObjects.index{$0.textField == textField }) {
            validableObjects[validIndex].enabled = enabled
        }
    }
    
    func validate() {
        for object in validableObjects {
            for validator in object.validators {
                guard object.enabled else { continue }
                
                if !validator.validate(object.textField?.text ?? "") {
                    delegate?.onFailed(validator.message)
                    return
                }
            }
        }
        
        delegate?.onSuccess()
    }
    
}
