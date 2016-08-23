//
//  ChatViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    /** The chat associated with this controller */
    private var chat: Chat!
    /** Messages for the chat */
    private var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        fetchMessages()
    }
    
    private func fetchMessages() {
        Services.sharedInstance.fetchMessages(chat.uid, page: 0) { (messages, error) in
            guard let messages = messages else {
                return
            }
            
            self.messages = messages
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Instantiation
    
    static func instanceWithChat(chat: Chat) -> Self {
        let controller = instance()
        
        controller.chat  = chat
        controller.title = chat.name
        
        return controller
    }
}

// MARK: - UITableViewDataSource
extension ChatViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(MessageTableViewCell.reusableIdentifier(), forIndexPath: indexPath) as! MessageTableViewCell
        
        
        
        return cell
    }
    
}

// MARK: - UITableViewDelegate
extension ChatViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
}