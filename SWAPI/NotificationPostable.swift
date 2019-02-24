//
//  NotificationPostable.swift
//  SWAPI
//
//  Created by Joshua Borck on 2/17/19.
//  Copyright © 2019 Joshua Borck. All rights reserved.
//

import UIKit

// Protocol for presenting an alert from any ViewController
protocol NotificationPostable {}

extension NotificationPostable {
    func presentAlert(from viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: UserStrings.Error.okTitle, style: .default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}
