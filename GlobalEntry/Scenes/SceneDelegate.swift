//
//  SceneDelegate.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 22.03.23.
//

import UIKit
import RealmSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            let navController = UINavigationController()
            
            if !UserDefaultsManager.shared.isWelcomeScreenShown {
                // Show the welcome screen
                let firstVC = FirstOnboardingController()
                navController.viewControllers = [firstVC]
                
            } else if !UserDefaultsManager.shared.isPassportSelected {
                // Show the choose passport screen
                let choosePassportVC = ChoosePassportViewController(viewModel: ChoosePassportViewModel.init(), tabBar: TabController.init())
                navController.viewControllers = [choosePassportVC]
            } else {
                // Show the main screen
                let tabBarController = TabController()
                tabBarController.selectedIndex = 0
                navController.viewControllers = [tabBarController]
            }
            
            window.rootViewController = navController
            
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
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
}

