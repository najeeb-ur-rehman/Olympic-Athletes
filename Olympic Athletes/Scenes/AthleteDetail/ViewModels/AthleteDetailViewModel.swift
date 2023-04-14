//
//  AthleteDetailViewModel.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 13/04/2023.
//

import Foundation

protocol AthleteDetailViewModelType {
    var bio: String { get }
    var name: String { get }
    var weight: String { get }
    var height: String { get }
    var dob: String { get }
    var photoId: Int? { get }
    var goldMedals: Int { get }
    var silverMedals: Int { get }
    var bronzeMedals: Int { get }
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    var gameResultsPublisher: Published<[AthleteGameResult]>.Publisher { get }
    func fetchAthleteResults()
}

class AthleteDetailViewModel: AthleteDetailViewModelType {
    
    @Published var isLoading = false
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    var gameResultsPublisher: Published<[AthleteGameResult]>.Publisher { $gameResults }
    @Published var gameResults = [AthleteGameResult]()
    
    let athlete: Athlete
    let service: AthletesServiceType
    
    init(athlete: Athlete, athleteService: AthletesServiceType) {
        self.athlete = athlete
        self.service = athleteService
    }
    
    var photoId: Int? {
        athlete.photoId
    }
    
    var bio: String {
        athlete.bio ?? ""
    }
    
    var name: String {
        "\(athlete.name ?? "") \(athlete.surname ?? "")"
    }
    
    var dob: String {
        athlete.dateOfBirth ?? "-"
    }
    
    var weight: String {
        if let weigth = athlete.weight {
            return "\(weigth) kg"
        }
        return "-"
    }
    
    var height: String {
        if let height = athlete.height {
            return "\(height) cm"
        }
        return "-"
    }
    
    var goldMedals: Int {
        gameResults.reduce(0){ $0 + ($1.gold ?? 0) }
    }
    
    var silverMedals: Int {
        gameResults.reduce(0){ $0 + ($1.silver ?? 0) }
    }
    
    var bronzeMedals: Int {
        gameResults.reduce(0){ $0 + ($1.bronze ?? 0) }
    }

    func fetchAthleteResults() {
        isLoading = true
        service.getResultsForAthleteId(athlete.athleteId) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false
            if let gameResults = try? result.get() {
                self.gameResults = gameResults
            }
        }
    }
}
