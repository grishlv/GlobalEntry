//
//  Validator.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 21.04.23.
//

import Foundation

final class Validator {
    
    static func isValidUsername(for name: String) -> Bool {
        let name = name.trimmingCharacters(in: .whitespacesAndNewlines)
        let nameRegEx = "\\w{1,40}"
        let namePred = NSPredicate(format: "SELF MATCHES %@", nameRegEx)
        return namePred.evaluate(with: name)
    }
    
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isPasswordValid(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[0-9]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
