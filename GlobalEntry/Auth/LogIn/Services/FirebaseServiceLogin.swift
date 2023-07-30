////
////  FirebaseService.swift
////  GlobalEntry
////
////  Created by Grigoriy Shilyaev on 26.06.23.
////
//
//import Firebase
//import FirebaseCore
//import FirebaseAuth
//import FirebaseFirestore
//import GoogleSignIn
//
////enum LoginCustomError: Error {
////    case TechError
////}
//
//protocol FirebaseServiceProtocolLogin {
//    func loginWithUsername(user: Login, completion: @escaping (Result<Void, Error>) -> Void)
//    func loginWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void)
//}
//
//final class FirebaseServiceLogin: FirebaseServiceProtocolLogin {
//    
//    func loginWithUsername(user: Login, completion: @escaping (Result<Void, Error>) -> Void) {
//        
//        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
//            
//            if let error = error {
//                completion(.failure(error))
//                return
//            }
//            
//            guard let resultUser = result?.user else {
//                completion(.failure(SignUpCustomError.TechError))
//                return
//            }
//            
//            let db = Firestore.firestore()
//            let documentRef = db.collection("users").document(resultUser.uid)
//            
//            documentRef.getDocument { snapshot, error in
//                if let error = error {
//                    completion(.failure(error))
//                    return
//                }
//                completion(.success(()))
//            }
//        }
//    }
//    
//    func loginWithGoogle(with data: GIDSignInResult, completion: @escaping (Result<Void, Error>) -> Void) {
//        
//        guard let idToken = data.user.idToken?.tokenString else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: idToken,
//                                                       accessToken: data.user.accessToken.tokenString)
//        let email = data.user.profile?.email
//        let _ = data.user.profile?.name
//        
//        Auth.auth().signIn(with: credential) { result, error in
//            
//            guard result != nil else {
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.failure(SignUpCustomError.TechError))
//                }
//                return
//            }
//            
//            let db = Firestore.firestore()
//            let _ = [
//                "email": email
//            ]
//            
//            let provider = credential.provider
//            db.collection("users").document(provider).getDocument(completion: { dataArr, error in
//                if let error = error {
//                    completion(.failure(error))
//                } else {
//                    completion(.success(()))
//                }
//            })
//        }
//    }
//}
//
