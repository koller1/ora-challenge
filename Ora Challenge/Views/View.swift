//
//  View.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/21/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class View: UIView {
    
    override func awakeAfterUsingCoder(aDecoder: NSCoder) -> AnyObject? {
        // ignore if set not to replace or we're not a template
        if !self.dynamicType.isReplacable || !subviews.isEmpty {
            return self;
        }
        
        let replacement = self.dynamicType.instanceFromNib()
        
        // synchronize necessary properties
        replacement.tag   = tag;
        replacement.frame = frame;
        replacement.translatesAutoresizingMaskIntoConstraints = translatesAutoresizingMaskIntoConstraints;
        
        // move all our constraints from the placeholder to this view
        replacement.addConstraints(migrateConstraints(replacement))
        
        return replacement;
    }
    
    // MARK: - Replacability
    
    class var isReplacable: Bool {
        return false
    }
    
}
