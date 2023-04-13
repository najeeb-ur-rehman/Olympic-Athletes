//
//  UIView+Extensions.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import UIKit

extension UIView {
    
    func roundCorners(radius: CGFloat, shouldClip: Bool = false) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = shouldClip
    }
    
    func addBorder(color: UIColor = .black, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
}

