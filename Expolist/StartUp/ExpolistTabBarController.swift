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
                                   tag: 1)
        
        vc.tabBarItem = barItem
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    lazy private var groceryListVC: UINavigationController = {
        let vc: GroceryListsViewController = GroceryListsViewController.get()
        let barItem = UITabBarItem(title: "Grocery List",
                                   image: UIImage(systemName: "rectangle.and.pencil.and.ellipsis"),
                                   tag: 2)
        
        vc.tabBarItem = barItem
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    lazy private var circleMembers: UINavigationController = {
        let vc: CircleMembersViewController = CircleMembersViewController.get()
        let barItem = UITabBarItem(title: "Members",
                                   image: UIImage(systemName: "person.fill"),
                                   tag: 3)
        
        vc.tabBarItem = barItem
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.viewControllers = [expiredProductsVC,
                                locationsVC,
                                groceryListVC,
                                circleMembers]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view
    }
}
