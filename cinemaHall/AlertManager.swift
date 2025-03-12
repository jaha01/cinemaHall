//
//  AlertManager.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 12.03.2025.
//

import Foundation
import UIKit

struct AlertConfig {
    var title: String
    var message: String?
}

class AlertManager {
    
    public static func showAlert(config: AlertConfig, completion:  (() -> ())? = nil) {
        let topController = UIApplication.shared.getTopViewController()
        
        DispatchQueue.main.async {
            let alert = UIAlertController(title: config.title, message: config.message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                completion?()
            }))
            topController.present(alert, animated: true)
        }
    }
}
