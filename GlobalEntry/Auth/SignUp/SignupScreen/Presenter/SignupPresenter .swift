//
//  SignupPresenter .swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.04.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

protocol SignupInputProtocol {
    func signUpWithGoogle(with data: GIDSignInResult)
    func signUpWithUsername(user: Register)
}

protocol SignUpOutput: AnyObject {
    func didRegisterEnd()
    func didRecieveValidateError(with text: String)
}

protocol AlertActions: AnyObject {
    func alertErrorCreate()
    func alertErrorSafeData()
}

final class SignupPresenter {
    weak var output: SignUpOutput?
    private let interactor: SingupInteractorProtoctol
    private let db = Firestore.firestore()
    
    init(interactor: SingupInteractorProtoctol) {
        self.interactor = interactor
    }
}

// MARK: - SignupInputProtocol

extension SignupPresenter: SignupInputProtocol {
    func signUpWithGoogle(with data: GIDSignInResult) {
        interactor.signUpWithGoogle(with: data) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.output?.didRegisterEnd()
            case .failure(let error):
                self.output?.didRecieveValidateError(with: error.localizedDescription)
            }
        }
    }

    func signUpWithUsername(user: Register) {
        interactor.signUpWithUsername(with: user) { [weak self] result in
            guard let self else { return }
            switch result {
            case .success:
                self.output?.didRegisterEnd()
            case .failure(let error):
                self.output?.didRecieveValidateError(with: error.localizedDescription)
            }
        }
    }
}
