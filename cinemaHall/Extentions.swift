//
//  Extention.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 10.03.2025.
//

import UIKit

extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
}

extension DateFormatter {
    static let longDateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.locale = Locale(identifier: "ru_RU")
        return formatter
    }()
}

extension UITextField {
    func animateError() {
        textColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.textColor = .black
        }
    }
}

extension UIApplication {
    
    func getTopViewController() -> UIViewController {
        guard let base = UIApplication.shared.connectedScenes.compactMap({ ($0 as? UIWindowScene)?.keyWindow }).last?.rootViewController else {
            return UIViewController()
       }
       
        return getTopViewControllerRecursive(base: base)
    }
    
    private func getTopViewControllerRecursive(base: UIViewController) -> UIViewController {
        if let nav = base as? UINavigationController {
            return getTopViewControllerRecursive(base: nav.visibleViewController!)
            
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return getTopViewControllerRecursive(base: selected)
            
        } else if let presented = base.presentedViewController {
            return getTopViewControllerRecursive(base: presented)
        }
        return base
    }
}
