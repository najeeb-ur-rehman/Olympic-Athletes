//
//  Utils.swift
//  Olympic Athletes
//
//  Created by Mian Najeeb on 14/04/2023.
//

import UIKit

func showOkAlert(title: String = "", message: String, viewController: UIViewController) {
    let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    showActionAlert(title: title, message: message, viewController: viewController, alertActions: [okAction])
}

func showActionAlert(title: String, message: String, viewController: UIViewController, alertActions: [UIAlertAction]) {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    for alertAction in alertActions {
        alertController.addAction(alertAction)
    }
    viewController.present(alertController, animated: true, completion: nil)
}
