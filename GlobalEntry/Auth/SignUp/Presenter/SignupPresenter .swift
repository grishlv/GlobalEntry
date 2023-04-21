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

protocol SignUpOutput: AnyObject {
    func didRegisterEnd()
}

protocol AlertActions: AnyObject {
    func alertErrorCreate()
    func alertErrorSafeData()
}

class SignupPresenter: SignupSenderAuthProtocol {
    
    weak var output: SignUpOutput?
    weak var alert: AlertActions?
    let view: SignupSenderAuthProtocol
    var register: Register
    let db = Firestore.firestore()
    
    init(view: SignupSenderAuthProtocol, register: Register, output: SignUpOutput, alert: AlertActions) {
        self.view = view
        self.register = register
        self.output = output
        self.alert = alert
    }
    
    //MARK: - give info in firebase
    func setupRegister(with userRequest: Register, completion: @escaping (Bool, Error?) -> Void) {
        
        let name = userRequest.name
        let email = userRequest.email
        let password = userRequest.password
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
            
            if err != nil {
                self.alert?.alertErrorCreate()
            } else {
                let db = Firestore.firestore()
                guard let resultUser = result?.user else {
                    print("error with result")
                    return }
                
                db.collection("users")
                    .document(resultUser.uid)
                    .setData([
                        "email": email,
                        "name": name]) { error in
                            
                            if error != nil {
                                self.alert?.alertErrorSafeData()
                            }
                        }
            }
            self.output?.didRegisterEnd()
        }
    }
}
