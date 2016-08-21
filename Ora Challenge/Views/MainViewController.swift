//
//  MainViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    /** Top container controller over main app content */
    private var loginViewController: LoginViewController!
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let controller = segue.destinationViewController as? LoginViewController {
            loginViewController = controller
        }
    }
}

