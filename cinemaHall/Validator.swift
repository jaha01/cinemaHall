//
//  Validator.swift
//  cinemaHall
//
//  Created by Jahongir Anvarov on 10.03.2025.
//

import Foundation

class Validator {
    
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidName(for name: String) -> Bool {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nameRegEx = "^[A-Za-z\\s]+$" // Латинские буквы и пробелы
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    static func isValidNumber(for number: String) -> Bool {
        let number = number.trimmingCharacters(in: .whitespacesAndNewlines)
        let numberRegEx = "^[0-9]+$" // Только цифры
        let numberPred = NSPredicate(format: "SELF MATCHES %@", numberRegEx)
        return numberPred.evaluate(with: number)
    }
    
}
