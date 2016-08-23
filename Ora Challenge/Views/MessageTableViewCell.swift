//
//  MessageTableViewCell.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class MessageTableViewCell: TableViewCell {

    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var fromLabel: UILabel!
    
    override func updateWithModel<T: Message>(model: T) {
        super.updateWithModel(model)
        
        
    }
}
