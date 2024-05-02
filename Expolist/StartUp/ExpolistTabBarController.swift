//
//  ExpolistTabBarController.swift
//  Expolist
//
//  Created by Donald Largen on 4/27/24.
//

import UIKit

class ExpolistTabBarController: UITabBarController {

    lazy private var expiredProductsVC: UINavigationController = {
        let vc: ExpiredProductsViewController = ExpiredProductsViewController.get()
        let barItem = UITabBarItem(title: "Expired",
                                   image: UIImage(systemName: "exclamationmark.square"),
                                   tag: 0)
        
        vc.tabBarItem = barItem
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    lazy private var locationsVC: UINavigationController = {
        let vc: LocationsViewController = LocationsViewController.get()
        let barItem = UITabBarItem(title: "Stores",
                                   image: UIImage(systemName: "location.square"),
                                   tag: 0)
        
        vc.tabBarItem = barItem
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [expiredProductsVC, locationsVC]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
}
