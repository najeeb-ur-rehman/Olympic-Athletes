//
//  AthletesListViewController.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 10/04/2023.
//

import UIKit

class AthletesListViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet var athletesListView: AthletesListView!
    
    // MARK: ViewController Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
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
        return 2
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: GameAthletesTableViewCell.reuseIdentifier) as? GameAthletesTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}

