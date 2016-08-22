//
//  SignInFieldModel.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import Foundation

class SignInFieldModel {
    
    enum FieldType: Int {
        case Name
        case Email
        case Password
        case Confirm
    }
    
    private (set) var title: String
    private (set) var placeholder: String?
    private (set) var isSecure: Bool
    
    init(title: String, placeholder: String? = nil, isSecure: Bool = false) {
        self.title       = title
        self.placeholder = placeholder
        self.isSecure    = isSecure
    }
    
    // MARK: - Generators
    
    class func registerFieldModels() -> [FieldType: SignInFieldModel] {
        return [
            .Name:     SignInFieldModel(title: "Name"),
            .Email:    SignInFieldModel(title: "Email"),
            .Password: SignInFieldModel(title: "Password", isSecure: true),
            .Confirm:  SignInFieldModel(title: "Confirm", isSecure: true)
        ]
    }
    
    class func loginFieldModels() -> [FieldType: SignInFieldModel] {
        return [
            .Email:    SignInFieldModel(title: "Email", placeholder: "Your Email"),
            .Password: SignInFieldModel(title: "Password", placeholder: "Your Password", isSecure: true)
        ]
    }
}