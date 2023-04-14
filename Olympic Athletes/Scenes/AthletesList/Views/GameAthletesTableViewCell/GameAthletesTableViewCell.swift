//
//  GameAthletesTableViewCell.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import UIKit

protocol GameAthletesTableViewCellActionDelegate {
    func showAthleteDetail(_ athlete: Athlete)
}

class GameAthletesTableViewCell: UITableViewCell {

    // MARK: Outlets
    @IBOutlet weak var athletesCollectionView: UICollectionView!
    @IBOutlet weak var gameNameLabel: UILabel!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var emptyDataView: UIView!
    @IBOutlet weak var emptyDataLabel: UILabel!
    @IBOutlet weak var tryAgainButton: UIButton!
    
    var athletes = [Athlete]()
    var errorMessage: String?
    var isLoading = true
    var delegate: GameAthletesTableViewCellActionDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupViewsAppearance()
        setupCollectionView()
    }
    
    func setupViewsAppearance() {
        gameNameLabel.font = .primaryBold(ofSize: 18)
        emptyDataLabel.font = .primaryRegular(ofSize: 14)
        tryAgainButton.titleLabel?.font = .primaryBold(ofSize: 14)
        tryAgainButton.setTitleColor(.systemGray, for: .normal)
        tryAgainButton.addBorder(color: .systemGray)
        tryAgainButton.roundCorners(radius: 12)
    }
    
    func setupCollectionView() {
        athletesCollectionView.register(AthleteCollectionViewCell.nib, forCellWithReuseIdentifier: AthleteCollectionViewCell.reuseIdentifier)
        athletesCollectionView.dataSource = self
        athletesCollectionView.delegate = self
    }
    
    func configureGameData(_ game: Game, athletesResult: Result<[Athlete], AthleteError>, isLoadingAthletes: Bool, delegate: GameAthletesTableViewCellActionDelegate) {
        self.delegate = delegate
        gameNameLabel.text = "\(game.city) \(game.year)"
        isLoading = isLoadingAthletes
        errorMessage = nil
        
        switch athletesResult {
        case .success(let athletes):
            self.athletes = athletes
        case .failure(let error):
            self.errorMessage = error.msg
        }
        updateViews()
    }
    
    private func updateViews() {
        if isLoading {
            emptyDataView.isHidden = true
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            if athletes.isEmpty {
                emptyDataView.isHidden = false
                emptyDataLabel.text = errorMessage ?? "No athlete found"
                tryAgainButton.isHidden = errorMessage == nil
            } else {
                emptyDataView.isHidden = true
            }
            athletesCollectionView.reloadData()
        }
    }

    @IBAction func tryAgainButtonAction(_ sender: Any) {
        
    }
}

extension GameAthletesTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return athletes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: AthleteCollectionViewCell.reuseIdentifier, for: indexPath) as? AthleteCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configureAthleteData(athletes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.showAthleteDetail(athletes[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 144)
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
