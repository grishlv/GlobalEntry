//
//  SingnupInteractor.swift
//  GlobalEntry
//
//  Created by Aleksandr Vyatkin on 21.04.2023.
//

import Foundation
import GoogleSignIn


protocol SingupInteractorProtoctol {
    func signUpWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void)
    func signUpWithUsername(with user: Register, completion: @escaping (Result<Void, Error>) -> Void)
}

final class SignupInteractor {
    private let firebaseService: FirebaseServiceProtocol

    init(firebaseService: FirebaseServiceProtocol) {
        self.firebaseService = firebaseService
    }
}

extension SignupInteractor: SingupInteractorProtoctol {
    func signUpWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.authWithGoogle(with: data, completion: completion)
    }
    func signUpWithUsername(with user: Register, completion: @escaping (Result<Void, Error>) -> Void) {
        firebaseService.authWithUsername(user: user, completion: completion)
    }
}
