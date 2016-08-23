//
//  MainViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    /** Container with login view controller's view */
    @IBOutlet private weak var loginContainerView: UIView!
    /** Top container controller over main app content */
    private var loginViewController: LoginViewController!
    /** Container with tab bar controller's view */
    @IBOutlet private weak var tabContainerView: UIView!
    /** Main tab container with app content */
    private var tabController: UITabBarController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabController.tabBar.tintColor = UIColor.oraOrange()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let controller = segue.destinationViewController as? LoginViewController {
            loginViewController = controller
            loginViewController.delegate = self
            
            loginContainerView.alpha = 0.0
        }
        else if let controller = segue.destinationViewController as? UITabBarController {
            tabController = controller
        }
    }
}

// MARK: - LoginViewControllerDelegate
extension MainViewController: LoginViewControllerDelegate {

    func didCompleteLogin(user: User) {
        UIView.animateWithDuration(0.7) {
            self.loginContainerView.alpha = 0.0
        }
    }
    
}
