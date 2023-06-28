//
//  Assembly.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 27.06.23.
//

import UIKit

final class LoginModuleAssembly {
    
    static func assemble() -> UIViewController {
        let fbService = FirebaseServiceLogin()
        let interactor = LoginInteractor(loginFirebaseService: fbService)
        let presenter = LoginPresenter(interactor: interactor)
        let vc = LogInViewController(presenterLogin: presenter)
        presenter.output = vc

        return vc
    }
}
