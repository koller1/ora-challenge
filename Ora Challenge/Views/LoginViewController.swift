//
//  LoginViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

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
    }
    
    @IBOutlet private weak var navigationBar: UINavigationBar!
    @IBOutlet private weak var leftBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var rightBarButtonItem: UIBarButtonItem!
    @IBOutlet private weak var formStackView: UIStackView!
    @IBOutlet private weak var nameField: SignInField!
    @IBOutlet private weak var emailField: SignInField!
    @IBOutlet private weak var passwordField: SignInField!
    @IBOutlet private weak var confirmField: SignInField!
    
    /** Current UI state of view */
    private var currentState: LoginViewState = .Login {
        didSet {
            changeState(currentState)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func didTapLeftBarButtonItem(sender: AnyObject) {
        currentState = currentState == .Login ? .Register : .Login
    }
    
    @IBAction func didTapRightBarButtonItem(sender: AnyObject) {
        if currentState == .Login {
            // process login
        } else {
            // process registration
        }
    }
    
    //
    // Helpers
    //
    
    private func changeState(state: LoginViewState) {
        // swap bar button titles
        UIView.transitionWithView(formStackView, duration: 0.7, options: [.TransitionCrossDissolve], animations: {
            self.leftBarButtonItem.title  = state.leftBarButtonTitle
            self.rightBarButtonItem.title = state.rightBarButtonTitle
        }, completion: nil)
        
        // toggle visibility of fields
        UIView.animateWithDuration(0.7) {
            self.nameField.hidden    = state.hidesNameField
            self.confirmField.hidden = state.hidesConfirmField
        }
    }
}

// MARK: - UINavigationBarDelegate
extension LoginViewController: UINavigationBarDelegate {
    
    func positionForBar(bar: UIBarPositioning) -> UIBarPosition {
        return .TopAttached
    }
    
}