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
