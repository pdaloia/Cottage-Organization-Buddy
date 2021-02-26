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

        loadViewControllersIntoTabBarController()
    }
    
    
    //a function which is used to initiate the storyboards with their controller for each tab, dependency inject the model into each controllers, and add these tabs to the tab bar controller.
    func loadViewControllersIntoTabBarController() {
        
        //initialize the storyboards with their respective controllers
        let groceriesViewController = GroceriesController()
        let carsViewController = CarsController()
        let bedsViewController = BedsController()
        let drinksViewController = DrinksController()
        let tripInformationViewController = TripInformationController()
        
        //Inject the model dependency into the view controllers
        groceriesViewController.cottageModel = self.cottageModel
        carsViewController.cottageModel = self.cottageModel
        bedsViewController.cottageModel = self.cottageModel
        drinksViewController.cottageModel = self.cottageModel
        tripInformationViewController.cottageModel = self.cottageModel
        
        //create the tab bar items for each view controller
        groceriesViewController.tabBarItem = UITabBarItem(title: "Groceries", image: UIImage(systemName: "bag"), tag: 0)
        carsViewController.tabBarItem = UITabBarItem(title: "Cars", image: UIImage(systemName: "car.2"), tag: 1)
        bedsViewController.tabBarItem = UITabBarItem(title: "Beds", image: UIImage(systemName: "bed.double"), tag: 2)
        drinksViewController.tabBarItem = UITabBarItem(title: "Drinks", image: UIImage(systemName: "drop"), tag: 3)
        tripInformationViewController.tabBarItem = UITabBarItem(title: "Trip Info", image: UIImage(systemName: "info.circle"), tag: 4)
        
        //create a list of all the controllers that will be loaded into the tab bar
        let tabBarList = [groceriesViewController, carsViewController, bedsViewController, drinksViewController, tripInformationViewController]
        
        //Create a navigation controller for each tab and assign the respective tab as it's root view controller
        self.viewControllers = tabBarList.map {
            UINavigationController(rootViewController: $0)
        }
        
    }

}
