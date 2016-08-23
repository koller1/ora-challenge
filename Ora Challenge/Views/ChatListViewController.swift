//
//  ChatListViewController.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class ChatListViewController: UIViewController {
    
    struct ChatSection {
        let section: Int
        let chats: [Chat]
        
        var date: NSDate {
            return chats[0].created
        }
    }
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView!
    
    /** */
    private var chatSections: [ChatSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "OraChat"
        
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        
        fetchChats("")
    }
    
    // MARK: - Fetching
    
    private func fetchChats(query: String) {
        Services.sharedInstance.fetchChats(query) { (chats, error) in
            guard let chats = chats else {
                return
            }
            
            self.parseChats(chats)
        }
    }
    
    private func parseChats(chats: [Chat]) {
        var chats = chats
        
        // ensure the chats are sorted
        chats = chats.sort { (chat1, chat2) -> Bool in
            return chat1.created.compare(chat2.created) == .OrderedDescending
        }
        
        // clear out old chats
        chatSections.removeAll()
        
        // walk down chats and group by day
        var section = 0
        var dayChats: [Chat] = []
        var lastDate: NSDate?
        
        for chat in chats {
            // start a new section when we're not same as last date
            if let lastDate = lastDate where !chat.created.isSameDay(lastDate) {
                chatSections.append(ChatSection(section: section, chats: dayChats))
                
                section += 1
                dayChats.removeAll()
            }
            
            // add to working chats
            dayChats.append(chat)
            
            lastDate = chat.created
        }
        
        // wrap up final section
        chatSections.append(ChatSection(section: section, chats: dayChats))
        
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension ChatListViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return chatSections.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatSections[section].chats.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(ChatTableViewCell.reusableIdentifier(), forIndexPath: indexPath) as! ChatTableViewCell
        let chat = chatForIndexPath(indexPath)
        
        cell.updateWithModel(chat)
        
        return cell
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = chatSections[section].date
        
        return date.isToday() ? "Today" : date.chatDateString()
    }
    
    //
    // Helpers
    //
    
    func chatForIndexPath(indexPath: NSIndexPath) -> Chat {
        return chatSections[indexPath.section].chats[indexPath.row]
    }
    
}

// MARK: - UITableViewDelegate
extension ChatListViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let chat = chatForIndexPath(indexPath)
        let controller = ChatViewController.instanceWithChat(chat)
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}