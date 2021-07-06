//
//  Extensions.swift
//  Manga
//
//  Created by Igor on 30/05/2021.
//  Copyright © 2021 Orangesoft. All rights reserved.
//

import UIKit

// MARK: - Hide Keyboard
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func showAlertController(title: String?,
                             message: String?,
                             preferredStyle: UIAlertController.Style = .alert, buttonAction: [UIAlertAction] = []) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if buttonAction.isEmpty {
            let alertActionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(alertActionOk)
        } else {
            for value in buttonAction {
                alertController.addAction(value)
            }
        }
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Alert Sample
extension UIViewController {
    private func alert() {
        let alert = UIAlertController(
            title: "Wrong!",
            message: "No access",
            preferredStyle: .alert)
        let okAction = UIAlertAction(title: "ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
