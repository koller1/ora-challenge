//
//  LoginViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

protocol LoginViewControllerDelegate {
    /** Called when user completes a login or registration */
    func didCompleteLogin(user: User)
}

class LoginViewController: UIViewController {
    
    private enum LoginViewState {
        case Login
        case Register
        
        var leftBarButtonTitle: String {
            return self == .Login ? "Register" : "Login"
        }
        
        var rightBarButtonTitle: String {
            return self == .Login ? "Login" : "Register"
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
    private var currentState: LoginViewState = .Login {
        didSet {
            changeState(currentState)
        }
    }
    
    /** Delegate to receive login callbacks */
    var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // style navigation bar
        navigationBar.oraStylize()
        
        // setup initial state
        changeState(currentState)
    }
    
    // MARK: - Actions
    
    @IBAction func didTapLeftBarButtonItem(sender: AnyObject) {
        currentState = currentState == .Login ? .Register : .Login
    }
    
    @IBAction func didTapRightBarButtonItem(sender: AnyObject) {
        if currentState == .Login {
            login(emailField.value, password: passwordField.value)
        } else {
            register(nameField.value, email: emailField.value, password: passwordField.value, confirm: confirmField.value)
        }
    }
    
    //
    // Helpers
    //
    
    private func changeState(state: LoginViewState) {
        let duration = 0.6
        
        // swap bar button titles
        UIView.transitionWithView(formStackView, duration: duration, options: [.TransitionCrossDissolve], animations: {
            self.leftBarButtonItem.title  = state.leftBarButtonTitle
            self.rightBarButtonItem.title = state.rightBarButtonTitle
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
    
    private func login(email: String, password: String) {
        Services.sharedInstance.login(email, password: password) { (user, error) in
            guard let user = user else {
                return
            }
            
            self.delegate?.didCompleteLogin(user)
        }
    }
    
    private func register(name: String, email: String, password: String, confirm: String) {
        Services.sharedInstance.register(name, email: email, password: password, confirm: confirm) { (user, error) in
            guard let user = user else {
                return
            }
            
            self.delegate?.didCompleteLogin(user)
        }
    }
}

// MARK: - UINavigationBarDelegate
extension LoginViewController: UINavigationBarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
}