//
//  AthleteDetailView.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 13/04/2023.
//

import UIKit
import MarkdownView

class AthleteDetailView: UIView {

    // MARK: Views Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameValueLabel: UILabel!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dobValueLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var weightValueLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var medalsLabel: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
    @IBOutlet weak var goldMedalsCountLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var silverMedalsCountLabel: UILabel!
    @IBOutlet weak var bronzeLabel: UILabel!
    @IBOutlet weak var bronzeMedalsCountLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var markdownViewContainer: UIView!
    
    // MARK: Constraints Outlets
    @IBOutlet weak var markdownViewContainerHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewsAppearance()
    }
    
    func setupViewsAppearance() {
    
        [nameLabel, dobLabel, weightLabel, heightLabel].forEach {
            $0?.font = .primaryBold(ofSize: 12)
        }
        
        [nameValueLabel, dobValueLabel, weightValueLabel, heightValueLabel].forEach {
            $0?.font = .primaryRegular(ofSize: 14)
        }
        
        [bioLabel, medalsLabel].forEach {
            $0?.font = .primaryBold(ofSize: 18)
        }
        
        [goldLabel, silverLabel, bronzeLabel].forEach {
            $0?.font = .primaryRegular(ofSize: 14)
        }
        
        [goldMedalsCountLabel, silverMedalsCountLabel, bronzeMedalsCountLabel].forEach {
            $0?.font = .primaryBold(ofSize: 16)
        }
        
        profileImageView.roundCorners(radius: 50, shouldClip: true)
    }

}
