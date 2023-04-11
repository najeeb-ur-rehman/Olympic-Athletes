//
//  GameAthletesTableViewCell.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import UIKit

class GameAthletesTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var athletesCollectionView: UICollectionView!
    @IBOutlet weak var gameNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        athletesCollectionView.register(AthleteCollectionViewCell.nib, forCellWithReuseIdentifier: AthleteCollectionViewCell.reuseIdentifier)
        athletesCollectionView.dataSource = self
        athletesCollectionView.delegate = self
    }

}

extension GameAthletesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AthleteCollectionViewCell.reuseIdentifier, for: indexPath) as? AthleteCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 152)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .zero
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
