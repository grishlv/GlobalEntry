//
//  FirebaseService.swift
//  GlobalEntry
//
//  Created by Aleksandr Vyatkin on 21.04.2023.
//

import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn

enum SignUpCustomError: Error {
    case TechError
}

protocol FirebaseServiceProtocol {
    func authWithUsername(user: Register, completion: @escaping (Result<Void, Error>) -> Void)
    func authWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirebaseService: FirebaseServiceProtocol {
    
    func authWithUsername(user: Register, completion: @escaping (Result<Void, Error>) -> Void) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
            
            guard result != nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(SignUpCustomError.TechError))
                }
                return
            }
            
            let db = Firestore.firestore()
            guard let resultUser = result?.user else {
                print("error with result")
                return
            }
            
            let dataArr = [
                "email": user.email,
                "name": user.name
            ]
            
            db.collection("users")
                .document(resultUser.uid)
                .setData(dataArr) { error in
                    guard let error else {
                        completion(.success(()))
                        return
                    }
                    completion(.failure(error))
                }
        }
    }
    
    func authWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void) {
        
        guard let idToken = data.user.idToken?.tokenString else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                       accessToken: data.user.accessToken.tokenString)
        
        let email = data.user.profile?.email
        let name = data.user.profile?.name
        
        Auth.auth().signIn(with: credential) { result, error in
            guard result != nil else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(SignUpCustomError.TechError))
                }
                return
            }
            
            let db = Firestore.firestore()
            let dataArr = [
                "email": email,
                "name": name
            ]
            
            let provider = credential.provider
            db.collection("users").document(provider).setData(dataArr) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        }
    }
}
