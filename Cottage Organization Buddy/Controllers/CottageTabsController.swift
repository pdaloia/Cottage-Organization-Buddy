//
//  CottageTabsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-16.
//

import UIKit

class CottageTabsController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        loadViewControllers()
    }
    
    func loadViewControllers() {
        //initialize the storyboards with their respective controllers
        let groceriesViewController = UIStoryboard(name: "Groceries", bundle:nil).instantiateViewController(identifier: "GroceriesView") as GroceriesController
        let carsViewController = UIStoryboard(name: "Cars", bundle:nil).instantiateViewController(identifier: "CarsView") as CarsController
        let bedsViewController = UIStoryboard(name: "Beds", bundle: nil).instantiateViewController(identifier: "BedsView") as BedsController
        let drinksViewContoller = UIStoryboard(name: "Drinks", bundle: nil).instantiateViewController(identifier: "DrinksView") as DrinksController
        
        //create the tab bar items for each view controller
        groceriesViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 0)
        carsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
        bedsViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 2)
        drinksViewContoller.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 3)
        
        //create a list of all the controllers that will be loaded into the tab bar
        let tabBarList = [groceriesViewController, carsViewController, bedsViewController, drinksViewContoller]
        
        //load the tab bar
        viewControllers = tabBarList
    }

}
