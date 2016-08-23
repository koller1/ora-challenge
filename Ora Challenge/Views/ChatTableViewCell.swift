//
//  ChatTableViewCell.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    typealias Object = Chat
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var activityLabel: UILabel!
    @IBOutlet private weak var previewLabel: UILabel!

    func updateWithModel(model: Chat) {
        titleLabel.text    = model.name
        activityLabel.text = constructRecentActivityTitle(model)
        previewLabel.text  = model.lastMessage?.text
    }
    
    //
    // Helpers
    //
    
    private func constructRecentActivityTitle(chat: Chat) -> String {
        return "Dan - 15 Days Ago"
    }
}

protocol Updatable {
    associatedtype Object
    
    func updateWithModel(model: Object)
}

extension UITableViewCell: Updatable {
    typealias Object = Model
    
    func updateWithModel(model: Object) {
        
    }
}