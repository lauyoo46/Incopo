//
//  ICPAlert.swift
//  Incopo
//
//  Created by Laurentiu Ile on 09.02.2021.
//

import UIKit

class ICPAlert {
    
    static func showAlert(on viewController: UIViewController, with title: String, message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
        DispatchQueue.main.async {
            viewController.present(alert, animated: true, completion: nil)
        }
    }
}
