//
//  UINavigationBar+Utility.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

extension UINavigationBar {
    
    func oraStylize() {
        titleTextAttributes = [
            NSFontAttributeName: UIFont.systemFontOfSize(17),
            NSForegroundColorAttributeName: UIColor.oraBlack()
        ]
        
        tintColor = UIColor.oraOrange()
    }
    
}