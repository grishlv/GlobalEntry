//
//  SignupPresenter .swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.04.23.

import Foundation
import FirebaseAuth
import FirebaseFirestore

protocol SignupSenderAuthProtocol {
    func setupRegister(with userRequest: Register, completion: @escaping (Bool, Error?) -> Void)
}

class SignupPresenter: SignupSenderAuthProtocol {

    let view: SignupSenderAuthProtocol
    var register: Register
    let db = Firestore.firestore()
    
    required init(view: SignupSenderAuthProtocol, register: Register) {
        self.view = view
        self.register = register
    }
    
    //MARK: - give info in firebase
    func setupRegister(with userRequest: Register, completion: @escaping (Bool, Error?) -> Void) {
        
        let name = userRequest.name
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { firebaseResult, error in
            if let error = error {
                completion(false, error)
                return
            }
            guard let resultUser = firebaseResult?.user else {
                completion(false, nil)
                return
            }
            self.db.collection("users")
                .document(resultUser.uid)
                .setData([
                    "email:": email,
                    "name": name
                ]) { error in
                    if let error = error {
                        completion(false, error)
                        return
                    }
                    completion(true, nil)
                }
        }
    }
}
