//
//  NSNotificationCenter+Utility.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

@objc protocol KeyboardResponder {
    @objc func keyboardWillShow(notification: NSNotification)
    @objc func keyboardWillHide(notification: NSNotification)
}

extension NSNotificationCenter {
    
    func observeKeyboardNotifications<KR: KeyboardResponder>(shouldObserve observe: Bool, forTarget target: KR) {
        if observe {
            NSNotificationCenter.defaultCenter().addObserver(target, selector: #selector(KeyboardResponder.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(target, selector: #selector(KeyboardResponder.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
        } else {
            NSNotificationCenter.defaultCenter().removeObserver(target, name: UIKeyboardWillShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().removeObserver(target, name: UIKeyboardWillHideNotification, object: nil)
        }
    }
    
}