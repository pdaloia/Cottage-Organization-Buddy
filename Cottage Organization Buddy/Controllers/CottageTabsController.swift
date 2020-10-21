//
//  CottageTabsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-16.
//

import UIKit

class CottageTabsController: UITabBarController {
    
    var cottageModel: CottageTrip = CottageTrip()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        TestHelper.loadTestModel(into: cottageModel)

        loadViewControllers()
    }
    
    
    //a function which is used to initiate the storyboards with their controller for each tab, dependency inject the model into each controllers, and add these tabs to the tab bar controller.
    func loadViewControllers() {
        
        //initialize the storyboards with their respective controllers
        let groceriesViewController = UIStoryboard(name: "Groceries", bundle:nil).instantiateViewController(identifier: "GroceriesView") as! GroceriesController
        let carsViewController = UIStoryboard(name: "Cars", bundle:nil).instantiateViewController(identifier: "CarsView") as! CarsController
        let bedsViewController = UIStoryboard(name: "Beds", bundle: nil).instantiateViewController(identifier: "BedsView") as! BedsController
        let drinksViewController = UIStoryboard(name: "Drinks", bundle: nil).instantiateViewController(identifier: "DrinksView") as! DrinksController
        let attendeesViewController = UIStoryboard(name: "Attendees", bundle: nil).instantiateViewController(identifier: "AttendeesView") as! AttendeesController
        
        //Inject the model dependency into the view controllers
        groceriesViewController.cottageModel = self.cottageModel
        carsViewController.cottageModel = self.cottageModel
        bedsViewController.cottageModel = self.cottageModel
        drinksViewController.cottageModel = self.cottageModel
        attendeesViewController.cottageModel = self.cottageModel
        
        //create the tab bar items for each view controller
        groceriesViewController.tabBarItem = UITabBarItem(title: "Groceries", image: UIImage(systemName: "bag"), tag: 0)
        carsViewController.tabBarItem = UITabBarItem(title: "Cars", image: UIImage(systemName: "car.2"), tag: 1)
        bedsViewController.tabBarItem = UITabBarItem(title: "Beds", image: UIImage(systemName: "bed.double"), tag: 2)
        drinksViewController.tabBarItem = UITabBarItem(title: "Drinks", image: UIImage(systemName: "drop"), tag: 3)
        attendeesViewController.tabBarItem = UITabBarItem(title: "Attendees", image: UIImage(systemName: "person"), tag: 4)
        
        //create a list of all the controllers that will be loaded into the tab bar
        let tabBarList = [groceriesViewController, carsViewController, bedsViewController, drinksViewController, attendeesViewController]
        
        //load the tab bar
        viewControllers = tabBarList
        
    }

}
