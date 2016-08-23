//
//  BubbleView.swift
//  Ora Challenge
//
//  Created by Alex Koller on 8/23/16.
//  Copyright © 2016 Alex Koller. All rights reserved.
//

import UIKit

class BubbleView: View {
    
    struct Corner: OptionSetType {
        let rawValue: Int
        
        static let TopLeft     = Corner(rawValue: 1 << 0)
        static let TopRight    = Corner(rawValue: 1 << 1)
        static let BottomLeft  = Corner(rawValue: 1 << 2)
        static let BottomRight = Corner(rawValue: 1 << 3)
    }
    
    /** The corners which should be roounded */
    var corners: Corner = [] {
        didSet {
            setNeedsLayout()
        }
    }
    /** Passthrough to layer fill */
    override var backgroundColor: UIColor? {
        get {
            return shapeLayer.fillColor != nil ? UIColor(CGColor: shapeLayer.fillColor!) : nil
        } set {
            shapeLayer.fillColor = newValue?.CGColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        initialize()
    }
    
    private func initialize() {
        shapeLayer.fillColor = UIColor.redColor().CGColor
    }
    
    // MARK: - Layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        invalidateMask()
    }
    
    private func invalidateMask() {
        // drawing variables
        let path          = CGPathCreateMutable()
        let width         = bounds.width
        let height        = bounds.height
        let cornerRadius  = height / 2
        let circleCenters = bounds.insetBy(dx: cornerRadius, dy: cornerRadius)
        
        // start at bottom right
        CGPathMoveToPoint(path, nil, width - cornerRadius, height)
        
        if corners.contains(.BottomRight) {
            CGPathAddArc(path, nil, circleCenters.bottomRight.x, circleCenters.bottomRight.y, cornerRadius, CGFloat(M_PI_2), CGFloat(0), true)
        } else {
            CGPathAddLineToPoint(path, nil, width, height)
            CGPathAddLineToPoint(path, nil, width, height - cornerRadius)
        }
        
        CGPathAddLineToPoint(path, nil, width, cornerRadius)
        
        if corners.contains(.TopRight) {
            CGPathAddArc(path, nil, circleCenters.topRight.x, circleCenters.topRight.y, cornerRadius, CGFloat(0), CGFloat(M_3_PI_2), true)
        } else {
            CGPathAddLineToPoint(path, nil, width, 0)
            CGPathAddLineToPoint(path, nil, width - cornerRadius, 0)
        }
        
        CGPathAddLineToPoint(path, nil, cornerRadius, 0)
        
        if corners.contains(.TopLeft) {
            CGPathAddArc(path, nil, circleCenters.topLeft.x, circleCenters.topLeft.y, cornerRadius, CGFloat(M_PI_2), CGFloat(M_PI), true)
        } else {
            CGPathAddLineToPoint(path, nil, 0, 0)
            CGPathAddLineToPoint(path, nil, 0, cornerRadius)
        }
        
        CGPathAddLineToPoint(path, nil, 0, height - cornerRadius)
        
        if corners.contains(.BottomLeft) {
            CGPathAddArc(path, nil, circleCenters.bottomLeft.x, circleCenters.bottomLeft.y, cornerRadius, CGFloat(M_PI), CGFloat(M_PI_2), true)
        } else {
            CGPathAddLineToPoint(path, nil, 0, height)
            CGPathAddLineToPoint(path, nil, cornerRadius, height)
        }
        
        shapeLayer.path = path
    }
    
    // MARK: - Layer
    
    override class func layerClass() -> AnyClass {
        return CAShapeLayer.self
    }
    
    private var shapeLayer: CAShapeLayer {
        return layer as! CAShapeLayer
    }
    
}