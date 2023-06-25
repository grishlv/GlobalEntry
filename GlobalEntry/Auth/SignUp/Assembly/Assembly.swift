//
//  Assembly.swift
//  GlobalEntry
//
//  Created by Aleksandr Vyatkin on 21.04.2023.
//

import UIKit

final class SingupModuleAssembly {
    
    static func assemble() -> UIViewController {
        let fbService = FirebaseService()
        let interactor = SignupInteractor(firebaseService: fbService)
        let presenter = SignupPresenter(interactor: interactor)
        let vc = SignupViewController(presenter: presenter)
        presenter.output = vc

        return vc
    }
}
