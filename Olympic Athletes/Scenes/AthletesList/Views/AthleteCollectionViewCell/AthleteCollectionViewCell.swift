//
//  AthleteCollectionViewCell.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import UIKit

class AthleteCollectionViewCell: UICollectionViewCell {
    
    // MARK: Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewsAppearance()
    }
    
    
    func setupViewsAppearance() {
        profileImageView.roundCorners(radius: 50, shouldClip: true)
        nameLabel.font = .systemFont(ofSize: 16, weight: .medium)
    }
    
}
