//
//  SignInField.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class SignInField: View {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    var value: String {
        get {
            return textField.text ?? ""
        } set {
            textField.text = newValue
        }
    }
    
    var model: SignInFieldModel? {
        didSet {
            titleLabel.text           = model?.title
            textField.placeholder     = model?.placeholder
            textField.secureTextEntry = model?.isSecure ?? false
        }
    }
    
    // MARK: - Replacability
    
    override class var isReplacable: Bool {
        return true
    }
}