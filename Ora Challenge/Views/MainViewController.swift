//
//  MainViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/20/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class MainViewController: ViewController {
    private enum ControllerTab: Int {
        /** Nav controller with chat UI */
        case Chats
        /** Account view controller */
        case Account
    }
    
    /** Container with login view controller's view */
    @IBOutlet private weak var loginContainerView: UIView!
    /** Top container controller over main app content */
    private var loginViewController: LoginViewController!
    /** Container with tab bar controller's view */
    @IBOutlet private weak var tabContainerView: UIView!
    /** Main tab container with app content */
    private var tabController: UITabBarController!
    /** Chats navigation controller */
    private var chatsNavigationController: UINavigationController? {
        return tabController.viewControllers?[ControllerTab.Chats.rawValue] as? UINavigationController
    }
    /** Account viewer in second tab of tab controller */
    private var accountViewController: LoginViewController? {
        return tabController.viewControllers?[ControllerTab.Account.rawValue] as? LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabController.tabBar.tintColor = UIColor.oraOrange()
        
        chatsNavigationController?.navigationBar.oraStylize()
        
        // setup login controller initial states
        loginViewController.currentState    = .Login
        accountViewController?.currentState = .Account
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        
        if let controller = segue.destinationViewController as? LoginViewController {
            loginViewController = controller
            loginViewController.delegate = self
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
