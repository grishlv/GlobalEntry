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
    private let signupFirebaseService: FirebaseServiceProtocol

    init(signupFirebaseService: FirebaseServiceProtocol) {
        self.signupFirebaseService = signupFirebaseService
    }
}

extension SignupInteractor: SingupInteractorProtoctol {
    func signUpWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void) {
        signupFirebaseService.authWithGoogle(with: data, completion: completion)
    }
    func signUpWithUsername(with user: Register, completion: @escaping (Result<Void, Error>) -> Void) {
        signupFirebaseService.authWithUsername(user: user, completion: completion)
    }
}
