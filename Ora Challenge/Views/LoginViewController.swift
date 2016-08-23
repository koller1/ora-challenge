//
//  LoginViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit
import ObjectMapper

protocol LoginViewControllerDelegate {
    /** Called when user completes a login or registration */
    func didCompleteLogin(user: User)
}

class LoginViewController: ViewController {
    
    enum LoginViewState {
        case Login
        case Register
        case Account
        
        var leftBarButtonTitle: String? {
            switch self {
            case .Login:
                return "Register"
            case .Register:
                return "Login"
            case .Account:
                return nil
            }
        }
        
        var rightBarButtonTitle: String? {
            switch self {
            case .Login:
                return "Login"
            case .Register:
                return "Register"
            case .Account:
                return "Save"
            }
        }
        
        var hidesNameField: Bool {
            return self == .Login
        }
        
        var hidesConfirmField: Bool {
            return self == .Login
        }
        
        var fieldModels: [SignInFieldModel.FieldType: SignInFieldModel] {
            if self == .Login {
                return SignInFieldModel.loginFieldModels()
            } else {
                return SignInFieldModel.registerFieldModels()
            }
        }
    }
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var formStackView: UIStackView!
    @IBOutlet private weak var nameField: SignInField!
    @IBOutlet private weak var emailField: SignInField!
    @IBOutlet private weak var passwordField: SignInField!
    @IBOutlet private weak var confirmField: SignInField!
    @IBOutlet private var fields: [SignInField]!
    
    /** Current UI state of view */
    var currentState: LoginViewState? {
        didSet {
            guard let currentState = currentState where isViewLoaded() else {
                return
            }
            
            // only animate changes from other states
            changeState(currentState, animated: oldValue != nil)
        }
    }
    
    /** Delegate to receive login callbacks */
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style navigation bar
        navigationBar.oraStylize()
        
        // update ui with state on load
        if let currentState = currentState {
            changeState(currentState, animated: false)
        }
    }
    
    // MARK: - Actions
    
    @IBAction func didTapLeftBarButtonItem(sender: AnyObject) {
        // left bar button is hidden when .Account
        currentState = currentState == .Login ? .Register : .Login
    }
    
    @IBAction func didTapRightBarButtonItem(sender: AnyObject) {
        guard let state = currentState else {
            return
        }
        
        switch state {
        case .Login:
            login(email: emailField.value, password: passwordField.value)
        case .Register:
            register(name: nameField.value, email: emailField.value, password: passwordField.value, confirm: confirmField.value)
        case .Account:
            update(name: nameField.value, email: emailField.value, password: passwordField.value, confirm: confirmField.value)
        }
    }
    
    //
    // Helpers
    //
    
    private func changeState(state: LoginViewState, animated: Bool) {
        let duration = animated ? 0.6 : 0
        
        // swap bar button titles
        UIView.transitionWithView(formStackView, duration: duration, options: [.TransitionCrossDissolve], animations: {
            self.leftBarButtonItem.title  = state.leftBarButtonTitle
            self.rightBarButtonItem.title = state.rightBarButtonTitle
            
            // display user info if needed
            if let user = UserManager.sharedInstance.currentUser where state == .Account {
                self.nameField.value  = user.name ?? ""
                self.emailField.value = user.email ?? ""
            }
        }, completion: nil)
        
        // toggle visibility of fields
        UIView.animateWithDuration(duration) {
            self.nameField.hidden    = state.hidesNameField
            self.confirmField.hidden = state.hidesConfirmField
        }
        
        // update field models
        for (type, model) in state.fieldModels {
            fields[type.rawValue].model = model
        }
    }
    
    private func login(email email: String, password: String) {
        UserManager.sharedInstance.authenticateWithEmail(email, password: password) { (user, error) in
            guard let user = user else {
                return
            }
            
            self.delegate?.didCompleteLogin(user)
        }
    }
    
    private func register(name name: String, email: String, password: String, confirm: String) {
        UserManager.sharedInstance.registerWithName(name: name, email: email, password: password, confirm: confirm) { (user, error) in
            guard let user = user else {
                return
            }
            
            self.delegate?.didCompleteLogin(user)
        }
    }
    
    private func update(name name: String, email: String, password: String, confirm: String) {
        
        
//        UserManager.sharedInstance.updateUser(<#T##user: User##User#>) { (user, error) in
            // saved!
//        }
    }
    
    // MARK: - ViewController
    
    override var requiresKeyboardSupport: Bool {
        return true
    }
}

// MARK: - UINavigationBarDelegate
extension LoginViewController: UINavigationBarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
}