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
    
    // MARK: - Replacability
    
    override class var isReplacable: Bool {
        return true
    }
}