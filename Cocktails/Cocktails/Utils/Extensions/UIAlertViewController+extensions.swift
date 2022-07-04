//
//  UIAlertViewController+extensions.swift
//  Cocktails
//
//  Created by Pasquale on 30/06/22.
//

import UIKit

extension UIAlertController {
    static func showError(title: String? = "Error", message: String, completion: (()->())? = nil) {
        DispatchQueue.main.async(execute: {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelButton = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(cancelButton)
            
            if let topViewController = UIApplication.topViewController() {
                if !topViewController.isKind(of: UIAlertController.self) {
                    UIApplication.topViewController()?.present(alert, animated: true, completion: completion)
                }
            }
        })
    }
}
