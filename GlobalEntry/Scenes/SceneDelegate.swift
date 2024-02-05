import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)

            if !UserDefaultsManager.shared.isWelcomeScreenShown {
                // Show the welcome screen
                let firstVC = OnboardingViewController(presenter: OnboardingPresenter())
                let navController = UINavigationController(rootViewController: firstVC)
                window.rootViewController = navController

            } else if !UserDefaultsManager.shared.isPassportSelected {
                // Show the choose passport screen
                let choosePassportVC = ChoosePassportViewController(viewModel: ChoosePassportViewModel(), tabBar: TabController())
                let navController = UINavigationController(rootViewController: choosePassportVC)
                window.rootViewController = navController

            } else {
                // Show the main screen
                let tabBarController = TabController()
                tabBarController.selectedIndex = 0
                window.rootViewController = tabBarController
            }
            self.window = window
            window.makeKeyAndVisible()
        }

        // Realm configuration
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if oldSchemaVersion < 1 {
                    migration.enumerateObjects(ofType: Feature.className()) { oldObject, newObject in
                        newObject?["isFavorite"] = false
                    }
                }
            }
        )
        Realm.Configuration.defaultConfiguration = config
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {

    }
}

