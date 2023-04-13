//
//  AthletesListViewController.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import UIKit
import Combine

class AthletesListViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var athletesListView: AthletesListView!
    
    // MARK: Instance Properties
    var viewModel: AthletesListViewModelType!
    private var cancellables = [AnyCancellable]()
    
    
    // MARK: Builder Method
    static func createInstance() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "AthletesListViewController") as! AthletesListViewController
        let gamesService = GamesService(baseUrl: Environment.current.baseUrl, client: NetworkClient())
        let viewModel = AthletesListViewModel(gamesService)
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBindings()
        setupTableView()
        viewModel.fetchGames()
    }
    
    func setupBindings() {
        viewModel.dataUpdatedForGameIdPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] gameId in
                self.reloadCellWithGameId(gameId)
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
    
    func reloadCellWithGameId(_ gameId: Int?) {
        guard let gameId = gameId, let indexPath = indexPathForGameId(gameId) else {
            athletesListView.tableView.reloadData()
            return
        }
        athletesListView.tableView.beginUpdates()
        athletesListView.tableView.reloadRows(at: [indexPath], with: .automatic)
        athletesListView.tableView.endUpdates()
    }
    
    func indexPathForGameId(_ gameId: Int) -> IndexPath? {
        guard let index = viewModel.games.firstIndex(where: { $0.gameId == gameId }) else {
            return nil
        }
        let row = Int(index)
        return IndexPath(row: row, section: 0)
    }

}

// MARK: - Helper Methods
private extension AthletesListViewController {
    
    func setupTableView() {
        athletesListView.tableView.register(GameAthletesTableViewCell.nib, forCellReuseIdentifier: GameAthletesTableViewCell.reuseIdentifier)
        athletesListView.tableView.dataSource = self
        athletesListView.tableView.rowHeight = UITableView.automaticDimension
    }
    
}

// MARK: - UITableView DataSource Methods
extension AthletesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.games.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GameAthletesTableViewCell.reuseIdentifier) as? GameAthletesTableViewCell else {
            return UITableViewCell()
        }
        let game = viewModel.games[indexPath.row]
        let athletesResult = viewModel.gamesAthletesResult[game.gameId] ?? .success([])
        cell.configureGameData(game, athletesResult: athletesResult, isLoadingAthletes: viewModel.isAthletesLoadingForGameId(game.gameId))
        return cell
    }
}

