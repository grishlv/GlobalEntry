//
//  UserDefaultsManager.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 03.07.23.
//

import Foundation

class UserDefaultsManager {
    
    static let shared = UserDefaultsManager()
    private let welcomeScreenKey = "WelcomeScreenShown"
    private let passportSelectedKey = "PassportSelected"
    private init() {}
    
    var isWelcomeScreenShown: Bool {
        get {
            return UserDefaults.standard.bool(forKey: welcomeScreenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: welcomeScreenKey)
        }
    }
    
    var isPassportSelected: Bool {
        get {
            return UserDefaults.standard.bool(forKey: passportSelectedKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: passportSelectedKey)
        }
    }
}
