//
//  UIView+Extensions.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import UIKit

extension UIView {
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
    
    static var identifier: String {
        String(describing: self)
    }
    
    func roundCorners(radius: CGFloat, shouldClip: Bool = false) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = shouldClip
    }
    
    func addBorder(color: UIColor = .black, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func fixInView(_ container: UIView) {
        frame = container.bounds
        container.addSubview(self)
        addEqualConstraintsWith(container)
    }
    
    func addEqualConstraintsWith(_ view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        [NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1.0, constant: 0),
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1.0, constant: 0),
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0),
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0)].forEach { $0.isActive = true }
    }
    
}

