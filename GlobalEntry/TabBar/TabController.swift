//
//  TabController.swift
//  GlobalEntry
//
//  Created by Grigoriy Shilyaev on 02.07.23.
//

import UIKit

class TabController: UITabBarController {

    let viewModel = ChoosePassportViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs() 
    }
    
    func setupTabs() {
        
        let search = self.createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: MainScreenViewController(viewModel: viewModel))
        let favourites = self.createNav(with: "Favourites", and: UIImage(systemName: "heart"), vc: FavouritesViewController())
        let map = self.createNav(with: "On the map", and: UIImage(systemName: "map"), vc: MapViewController())
        let profile = self.createNav(with: "Profile", and: UIImage(systemName: "person.circle"), vc: FavouritesViewController())

        self.setViewControllers([search, favourites, map, profile], animated: true)
        self.selectedIndex = 0
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: vc)
        
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        return nav
    }
}
