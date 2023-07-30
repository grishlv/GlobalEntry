////
////  LoginPresenter.swift
////  GlobalEntry
////
////  Created by Grigoriy Shilyaev on 26.06.23.
////
//
//import Foundation
//import FirebaseAuth
//import FirebaseFirestore
//import GoogleSignIn
//
//protocol LoginInputProtocol {
//    func loginWithGoogle(with data: GIDSignInResult)
//    func loginWithUsername(user: Login)
//}
//
//protocol LoginOutput: AnyObject {
//    func didLoginEnd()
//    func didRecieveValidateErrorLogin(with text: String)
//}
//
//final class LoginPresenter {
//    weak var output: LoginOutput?
//    private let interactor: LoginInteractorProtoctol
//    private let db = Firestore.firestore()
//    
//    init(interactor: LoginInteractorProtoctol) {
//        self.interactor = interactor
//    }
//}
//
//// MARK: - LoginInputProtocol
//extension LoginPresenter: LoginInputProtocol {
//    
//    func loginWithUsername(user: Login) {
//        interactor.loginWithUsername(with: user) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success:
//                self.output?.didLoginEnd()
//            case .failure(let error):
//                self.output?.didRecieveValidateErrorLogin(with: error.localizedDescription)
//            }
//        }
//    }
//    
//    func loginWithGoogle(with data: GIDSignInResult) {
//        interactor.loginWithGoogle(with: data) { [weak self] result in
//            guard let self else { return }
//            switch result {
//            case .success:
//                self.output?.didLoginEnd()
//            case .failure(let error):
//                self.output?.didRecieveValidateErrorLogin(with: error.localizedDescription)
//            }
//        }
//    }
//}
