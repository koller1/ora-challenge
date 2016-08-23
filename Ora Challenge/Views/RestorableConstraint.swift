//
//  RestorableConstraint.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class RestorableConstraint: NSLayoutConstraint {
    /** Constant to use when reseting the constraint value */
    static let RestorableConstant = CGFloat.max
    /** The value held by `restorableValue` prior to capturing the initial value */
    private static let UnsetRestorableValue = CGFloat.max - 1
    /** Backing storage for `restorableValue` */
    private var internalRestorableValue: CGFloat = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // NSLayoutConstraint doesn't call `init` which avoids setting default values
        internalRestorableValue = RestorableConstraint.UnsetRestorableValue
    }
    
    /**
     The constraint's initial value.
     
     It's generally safer to not rely on using this in calculations (use `RestorableConstant` to
     reset to this value, or `offsetConstant(_:)` instead).
     
     Use the setter when size class changes require multiple initial values not
     configurable via IB. The new initial value will be used for all further
     constant calculations.
     
     - returns: The initial value of the constraint
     */
    var restorableValue: CGFloat {
        get {
            if internalRestorableValue == RestorableConstraint.UnsetRestorableValue {
                internalRestorableValue = constant
            }
            
            return internalRestorableValue
        }
        set {
            // determine old offset
            let previousOffset = disabled ? 0 : constant - restorableValue
            
            internalRestorableValue = newValue
            
            // invalidate our constant with previous offset
            setOffset(previousOffset)
        }
    }
    
    /**
     Whether the constraint is enabled or not
     
     If `false`, the constraint's value is set to 0. If `true`, the constraint is restored to its
     restorable value.
     */
    var disabled: Bool = false {
        didSet {
            if disabled != oldValue {
                updateConstant(disabled ? 0 : constant, disabled: disabled)
            }
        }
    }
    
    /**
     Updates the constraint's constant value.
     
     Functions identically to the NSLayoutConstraint's `setConstant(_:) implementation, except that if the
     value passed is `RestorableConstant`, the contraints original value will be applied.
     
     - parameter constant: The constant value to set, or EHIRestorableConstant
     */
    override var constant: CGFloat {
        get {
            return super.constant
        }
        set {
            updateConstant(newValue, disabled: disabled)
        }
    }
    
    private func updateConstant(constant: CGFloat, disabled: Bool) {
        // capture the restorable value if we haven't already
        if disabled && restorableValue != 0 {
            // the restorable value gets captured implicitly by the accessor
        }
        
        var constant = constant
        
        // filter the constant value
        if disabled {
            constant = 0
        } else if constant == RestorableConstraint.RestorableConstant {
            constant = restorableValue
        }
        
        super.constant = constant
    }
    
    /**
     Updates the constant with a relative offset.
     
     Updates are made relative to the contraints **initial** value, not its current value.
     
     - parameter constant: The offset to adjust the initial value by
     */
    func setOffset(offset: CGFloat) {
        constant = restorableValue + offset
    }
    
}