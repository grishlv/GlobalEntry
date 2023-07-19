//
//  TabController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.07.23.
//

import UIKit
import SnapKit

final class TabController: UITabBarController, UITabBarControllerDelegate {
    
    var viewModel = ChoosePassportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)
        setupTabs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureTabBarAppearance()
    }
    
    func setupTabs() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = createLine(color: UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1), size: CGSize(width: tabBar.frame.size.width, height: 1))

        // Customize the system icon and text colors
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)]

        tabBar.standardAppearance = appearance
        
        let search = createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: MainViewController(viewModel: MainViewModel.init()))
        let favourites = createNav(with: "Favourites", and: UIImage(systemName: "heart"), vc: FavouritesViewController(viewModel: FavouritesViewModel.init()))
        let map = createNav(with: "On the map", and: UIImage(systemName: "map"), vc: MapViewController())
        let profile = createNav(with: "Profile", and: UIImage(systemName: "person.circle"), vc: ProfileViewController())
        
        setViewControllers([search, favourites, map, profile], animated: true)
    }
    
    func configureTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        
        // Customize the appearance of the tab bar
        appearance.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1)
        appearance.shadowImage = createLine(color: UIColor(red: 229/255, green: 229/255, blue: 234/255, alpha: 1), size: CGSize(width: tabBar.frame.size.width, height: 1))
        
        // Customize the system icon and text colors
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)]
        
        tabBar.standardAppearance = appearance
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }
    
    private func createLine(color: UIColor, size: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: size)
        let image = renderer.image { context in
            context.cgContext.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
        return image
    }
}
