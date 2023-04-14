//
//  AthleteDetailViewController.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 13/04/2023.
//

import UIKit
import MarkdownView
import Combine

class AthleteDetailViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var athleteDetailView: AthleteDetailView!
    
    // MARK: Instance Properties
    var viewModel: AthleteDetailViewModelType!
    private var cancellables = [AnyCancellable]()
    
    // MARK: Builder Method
    static func createInstance(_ athlete: Athlete) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(
            withIdentifier: AthleteDetailViewController.storyboardId
        ) as! AthleteDetailViewController
        let service = AthletesService(baseUrl: Environment.current.baseUrl, client: NetworkClient())
        let viewModel = AthleteDetailViewModel(athlete: athlete, athleteService: service)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        viewModel.fetchAthleteResults()
        configureAthleteData()
    }

}

// MARK: Helper Methods
private extension AthleteDetailViewController {
    
    func setupBindings() {
        viewModel.gameResultsPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                updateMedalsData()
            }
            .store(in: &cancellables)
        
        viewModel.isLoadingPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] showLoader in
                if showLoader {
                    LoadingView.show(self.view)
                } else {
                    LoadingView.hide(self.view)
                }
            }
            .store(in: &cancellables)
    }
    
    func configureAthleteData() {
        configureMarkdownBioView()
        
        self.title = viewModel.title
        athleteDetailView.nameValueLabel.text = viewModel.name
        athleteDetailView.dobValueLabel.text = viewModel.dob
        athleteDetailView.weightValueLabel.text = viewModel.weight
        athleteDetailView.heightValueLabel.text = viewModel.height
        athleteDetailView.profileImageView.setAthletePhotoWithId(viewModel.photoId)
    }
    
    func updateMedalsData() {
        athleteDetailView.goldMedalsCountLabel.text = String(viewModel.goldMedals)
        athleteDetailView.silverMedalsCountLabel.text = String(viewModel.silverMedals)
        athleteDetailView.bronzeMedalsCountLabel.text = String(viewModel.bronzeMedals)
    }
    
    func configureMarkdownBioView() {
        let markdownView = MarkdownView()
        markdownView.load(markdown: viewModel.bio)
        markdownView.onRendered = { value in
            self.athleteDetailView.markdownViewContainerHeightConstraint.constant = value
        }
        markdownView.fixInView(athleteDetailView.markdownViewContainer)
    }
    
}
