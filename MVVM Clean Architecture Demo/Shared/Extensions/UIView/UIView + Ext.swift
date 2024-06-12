//
//  UIView + Ext.swift
//  MVVM Clean Architecture Demo
//
//  Created by Ahmed Abd Elaziz on 05/06/2024.
//

import UIKit

extension UIView {
    
    enum BorderSide {
        case top, bottom, left, right, all
    }
    
    func addBorder(to sides: [BorderSide], color: UIColor, thickness: CGFloat) {
        for side in sides {
            let border = CALayer()
            border.backgroundColor = color.cgColor
            border.masksToBounds = true
            switch side {
            case .top:
                border.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: thickness)
            case .bottom:
                border.frame = CGRect(x: 0, y: self.frame.height - thickness, width: self.frame.width, height: thickness)
            case .left:
                border.frame = CGRect(x: 0, y: 0, width: thickness, height: self.frame.height)
            case .right:
                border.frame = CGRect(x: self.frame.width - thickness, y: 0, width: thickness, height: self.frame.height)
            case .all:
                self.addBorder(to: [.top, .bottom, .left, .right], color: color, thickness: thickness)
                return
            }
            self.layer.addSublayer(border)
        }
    }
    
    struct Corner: OptionSet, Hashable {
        let rawValue: Int
        
        static let topLeft     = Corner(rawValue: 1 << 0)
        static let topRight    = Corner(rawValue: 1 << 1)
        static let bottomLeft  = Corner(rawValue: 1 << 2)
        static let bottomRight = Corner(rawValue: 1 << 3)
        
        static let allCorners: Corner = [.topLeft, .topRight, .bottomLeft, .bottomRight]
    }
    
    func roundCorners(_ corners: Corner, radius: CGFloat) {
        let cornerMasks: [Corner: CACornerMask] = [
            .topLeft: .layerMinXMinYCorner,
            .topRight: .layerMaxXMinYCorner,
            .bottomLeft: .layerMinXMaxYCorner,
            .bottomRight: .layerMaxXMaxYCorner
        ]
        
        var maskedCorners: CACornerMask = []
        
        for (corner, mask) in cornerMasks where corners.contains(corner) {
            maskedCorners.insert(mask)
        }
        
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = maskedCorners
        self.layer.masksToBounds = true
    }
}
