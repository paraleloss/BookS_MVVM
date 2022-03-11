//
//  TabBarController.swift
//  BookS_MVVM
//
//  Created by Saúl Pérez on 10/03/22.
//

import UIKit
import CoreData

class TabBarController: UITabBarController {
    private(set) var managedObjectContext: NSManagedObjectContext
    
    init(context: NSManagedObjectContext) {
        managedObjectContext = context
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let homeController = UINavigationController(rootViewController: HomeViewController(context: managedObjectContext))
        homeController.tabBarItem = UITabBarItem(title: "Home",
                                                 image: UIImage(systemName: "house"),
                                                 tag: 0)
        
        let searchController = UINavigationController(rootViewController: SearchViewController(context: managedObjectContext))
        searchController.tabBarItem = UITabBarItem(title: "Search",
                                                  image: UIImage(systemName: "magnifyingglass"),
                                                  tag: 1)
        ;
        let profileController = ProfileViewController(context: managedObjectContext)
        profileController.delegate = self
        let profileNavigationController = UINavigationController(rootViewController: profileController)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile",
                                                  image: UIImage(systemName: "person"),
                                                  tag: 2)
        
        viewControllers = [homeController,
                           searchController,
                           profileNavigationController]
        modalPresentationStyle = .fullScreen
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension TabBarController: ProfileViewControllerDelegate {
    func logOutUser() {
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "password")
        dismiss(animated: true)
    }
}
