//
//  AthletesListViewModel.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 11/04/2023.
//

import Foundation

struct AthleteError: Error {
    let msg = "Failed to fetch Athletes"
}

protocol AthletesListViewModelActionDelegate {
    func showAthleteDetail(_ athlete: Athlete)
}

protocol AthletesListViewModelType {
    func fetchGames()
    func isAthletesLoadingForGameId(_ id: Int) -> Bool
    func showDetailForAthlete(_ athlete: Athlete)
    func fetchAthletesForGameId(_ id: Int)
    
    var isLoadingPublisher: Published<Bool>.Publisher { get }
    
    var games: [Game] { get }
    
    var dataUpdatedForGameIdPublisher:  Published<Int?>.Publisher { get }
    
    var gamesAthletesResult: [Int: Result<[Athlete], AthleteError>] { get }
    
    var error: Published<String?>.Publisher { get }
    
}

class AthletesListViewModel: AthletesListViewModelType {
    
    var games = [Game]()
    
    @Published var isLoading = false
    var isLoadingPublisher: Published<Bool>.Publisher { $isLoading }
    
    var gamesAthletesResult = [Int: Result<[Athlete], AthleteError>]()
    
    var dataUpdatedForGameIdPublisher:  Published<Int?>.Publisher {
        $dataUpdatedForGameId
    }
    
    @Published var errorMessage: String? = nil
    var error: Published<String?>.Publisher { $errorMessage }
    
    @Published private var dataUpdatedForGameId: Int? = nil
    
    private var gameAthletesLoading = Set<Int>()
    private let service: GamesServiceType
    private let delegate: AthletesListViewModelActionDelegate
    
    init(_ service: GamesServiceType, actionsDelegate: AthletesListViewModelActionDelegate) {
        self.service = service
        self.delegate = actionsDelegate
    }
    
    func fetchGames() {
        isLoading = true
        service.getGamesWithCompletion { result in
            self.isLoading = false
            switch result {
            case .success(let games):
                self.games = games
                self.dataUpdatedForGameId = nil
                for game in games {
                    self.fetchAthletesForGameId(game.gameId)
                }
            case .failure(_):
                self.errorMessage = "Something went wrong. \n Failed to load the data, try again later"
            }
        
        }
    }
    
    func fetchAthletesForGameId(_ id: Int) {
        gameAthletesLoading.insert(id)
        service.getAthletesForGameId(id) { result in
            switch result {
            case .success(let athletes):
                self.gamesAthletesResult[id] = .success(athletes)
            case .failure(_):
                self.gamesAthletesResult[id] = .failure(AthleteError())
            }
            self.gameAthletesLoading.remove(id)
            self.dataUpdatedForGameId = id
        }
    }
    
    func isAthletesLoadingForGameId(_ id: Int) -> Bool {
        return gameAthletesLoading.contains(id)
    }
    
    func showDetailForAthlete(_ athlete: Athlete) {
        delegate.showAthleteDetail(athlete)
    }
    
}
