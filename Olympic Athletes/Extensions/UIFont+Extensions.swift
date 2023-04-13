//
//  UIFont+Extensions.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 12/04/2023.
//

import UIKit

extension UIFont {
    
    static func primaryRegular(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-Regular", size: size)
    }
    
    static func primaryBold(ofSize size: CGFloat) -> UIFont? {
        return UIFont(name: "AppleSDGothicNeo-Bold", size: size)
    }
}
