//
//  AppCoordinator.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 14/04/2023.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppCoordinator: Coordinator {
    
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let athletesVC = AthletesListViewController.createInstance(delegate: self)
        let navigationVC = UINavigationController(rootViewController: athletesVC)
        window.rootViewController = navigationVC
    }
}

extension AppCoordinator: AthletesListViewModelActionDelegate {
    
    func showAthleteDetail(_ athlete: Athlete) {
        let athleteDetailVC = AthleteDetailViewController.createInstance(athlete)
        if let nav = window.rootViewController as? UINavigationController {
            nav.pushViewController(athleteDetailVC, animated: true)
        } else {
            window.rootViewController?.present(athleteDetailVC, animated: true)
        }
    }
    
    
}
