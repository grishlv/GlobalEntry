//
//  LoginInteractor.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 26.06.23.
//

import Foundation
import GoogleSignIn

protocol LoginInteractorProtoctol {
    func loginWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void)
    func loginWithUsername(with user: Login, completion: @escaping (Result<Void, Error>) -> Void)
}

final class LoginInteractor {
    private let loginFirebaseService: FirebaseServiceProtocolLogin
    
    init(loginFirebaseService: FirebaseServiceProtocolLogin) {
        self.loginFirebaseService = loginFirebaseService
    }
}

extension LoginInteractor: LoginInteractorProtoctol {
    
    func loginWithUsername(with user: Login, completion: @escaping (Result<Void, Error>) -> Void) {
        loginFirebaseService.loginWithUsername(user: user, completion: completion)
    }
    
    func loginWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void) {
        loginFirebaseService.loginWithGoogle(with: data, completion: completion)
    }
}
