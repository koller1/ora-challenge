//
//  UITableView+Registration.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

extension UITableView {
    
    /**
     Registers a class for reuse by the receiver
     
     Quickly register `UITableViewCell` or `UITableViewHeaderFooterView`
     classes that conform to `ReusableView`. A prototype of the cell is
     assumed to be found in a nib of the same name.
     
     - parameter klass: The class to which to register for reuse
     */
    func registerNibForClass<T: ReusableView>(klass: T.Type) {
        let identifier = klass.reusableIdentifier()
        let nib        = UINib(nibName: String(klass), bundle: nil)
        
        switch klass {
        case is UITableViewCell.Type:
            registerNib(nib, forCellReuseIdentifier: identifier)
        case is UITableViewHeaderFooterView.Type:
            registerNib(nib, forHeaderFooterViewReuseIdentifier: identifier)
        default:
            preconditionFailure("TableView is unable to register a nib for class of type \(klass)")
        }
    }
    
}

extension UITableViewCell: ReusableView {
    
}

extension UITableViewHeaderFooterView: ReusableView {
    
}