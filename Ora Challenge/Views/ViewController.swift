//
//  ViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardResponder {
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // register for keyboard notifications if our subclass has opted in
        if requiresKeyboardSupport {
            NSNotificationCenter.defaultCenter().observeKeyboardNotifications(shouldObserve: true, forTarget: self)
        }
    }
    
    // MARK: - Keyboard
    
    private lazy var keyboardDismissalRecognizer: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.handleTapGestureRecognizer(_:)))
        gesture.cancelsTouchesInView = false
        gesture.delegate = self
        
        return gesture
    }()

    var requiresKeyboardSupport: Bool {
        return false
    }
    
    func handleTapGestureRecognizer(tapGesture: UITapGestureRecognizer) {
        if tapGesture.state == .Recognized {
            view.endEditing(true)
        }
    }
    
    // MARK: - KeyboardResponder
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if requiresKeyboardSupport {
            view.addGestureRecognizer(keyboardDismissalRecognizer)
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if requiresKeyboardSupport {
            view.removeGestureRecognizer(keyboardDismissalRecognizer)
        }
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension ViewController: UIGestureRecognizerDelegate {
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        guard let view = touch.view else {
            return true
        }
        
        // ignore dismissing keyboard when tapping controls
        return !(view.isKindOfClass(UITextField) || view.isKindOfClass(UIButton))
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}