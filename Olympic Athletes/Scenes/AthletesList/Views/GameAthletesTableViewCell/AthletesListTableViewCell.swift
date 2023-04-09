//
//  GameAthletesTableViewCell.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import UIKit

class GameAthletesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

}


extension UIView {
    
    static var nib: UINib {
        UINib(nibName: String(describing: self), bundle: nil)
    }
}

extension UITableViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}

extension UICollectionViewCell {
    
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
