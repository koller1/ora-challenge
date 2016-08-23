//
//  MessageTableViewCell.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/22/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class MessageTableViewCell: TableViewCell {
    
    private enum ContainerAlignment {
        case Left
        case Right
    }
    
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var fromLabel: UILabel!
    @IBOutlet private weak var bubbleView: BubbleView!
    @IBOutlet private weak var containerLeadingSpace: RestorableConstraint!
    @IBOutlet private weak var containerTrailingSpace: RestorableConstraint!
    
    /** The side on which content is aligned in the cell */
    private var alignment: ContainerAlignment = .Left {
        didSet {
            bubbleView.corners = alignment == .Left ? [.TopLeft, .TopRight, .BottomRight] : [.TopLeft, .TopRight, .BottomLeft]
            
            fromLabel.textAlignment = alignment == .Left ? .Left : .Right
                
            // update alignment based constraints
            setNeedsUpdateConstraints()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bubbleView.backgroundColor = UIColor.oraGrey()
    }
    
    // MARK: - Constraints
    
    override func updateConstraints() {
        super.updateConstraints()
        
        updateMarginConstraint(containerLeadingSpace, shouldInset: alignment != .Left)
        updateMarginConstraint(containerTrailingSpace, shouldInset: alignment == .Left)
    }
    
    private func updateMarginConstraint(constraint: RestorableConstraint, shouldInset: Bool) {
        if shouldInset {
            constraint.setOffset(bounds.width * 0.25)
        } else {
            constraint.constant = RestorableConstraint.RestorableConstant
        }
    }
    
    // MARK: - Updatable
    
    override func updateWithModel<T: Message>(model: T) {
        super.updateWithModel(model)
     
        messageLabel.text = model.text
        fromLabel.text    = "Andre - 2 Hours Ago"
        
        alignment = model.userId == UserManager.sharedInstance.currentUser?.uid ? .Right : .Left
    }
    
}
