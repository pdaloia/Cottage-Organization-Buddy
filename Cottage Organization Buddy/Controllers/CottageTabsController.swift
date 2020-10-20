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
        
        loadTesterCottageData()

        loadViewControllers()
    }
    
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
        groceriesViewController.tabBarItem = UITabBarItem(title: "Groceries", image: UIImage(systemName: "applelogo"), tag: 0)
        carsViewController.tabBarItem = UITabBarItem(title: "Cars", image: UIImage(systemName: ""), tag: 1)
        bedsViewController.tabBarItem = UITabBarItem(title: "Beds", image: UIImage(systemName: ""), tag: 2)
        drinksViewController.tabBarItem = UITabBarItem(title: "Drinks", image: UIImage(systemName: ""), tag: 3)
        attendeesViewController.tabBarItem = UITabBarItem(title: "Attendees", image: UIImage(systemName: ""), tag: 4)
        
        //create a list of all the controllers that will be loaded into the tab bar
        let tabBarList = [groceriesViewController, carsViewController, bedsViewController, drinksViewController, attendeesViewController]
        
        //load the tab bar
        viewControllers = tabBarList
    }
    
    func loadTesterCottageData() {
        //load values
        cottageModel.tripName = "Vic's Cottage"
        cottageModel.tripOrganiser = Attendee(name: "Vic")
        
        //test cars
        let philsCar: Car = Car(driverName: "Phil", numberOfPassengers: 3, passengers: ["Laura", "Medei", "Son"])
        let julesCar: Car = Car(driverName: "Phil", numberOfPassengers: 2, passengers: ["Kim", "Lucas"])
        let andrewsCar: Car = Car(driverName: "Phil", numberOfPassengers: 2, passengers: ["Vic", "Michael"])
        cottageModel.carsList = [philsCar, julesCar, andrewsCar]
        
        //test groceries
        let bananas: Grocery = Grocery(productName: "Banana", price: 2.00, Quantity: 5)
        let apples: Grocery = Grocery(productName: "Apple", price: 1.50, Quantity: 10)
        let burgers: Grocery = Grocery(productName: "Burger", price: 5.00, Quantity: 10)
        let popsicles: Grocery = Grocery(productName: "Popsicle", price: 2.50, Quantity: 20)
        
        let allGroceries = [bananas, apples, burgers, popsicles]
        
        let philsGroceries: GroceryList = GroceryList(personsName: "Phil", groceries: [apples, bananas])
        let vicsGroceries: GroceryList = GroceryList(personsName: "Vic", groceries: [burgers])
        let laurasGroceries: GroceryList = GroceryList(personsName: "Laura", groceries: [popsicles])
        
        cottageModel.groceryList = GroceryLists(allItems: allGroceries, groceriesPerPerson: [philsGroceries, vicsGroceries, laurasGroceries])
        
        //test beds
        let firstBed: Bed = Bed(size: .double, capacity: "2", occupants: ["Phil", "Laura"])
        let secondBed: Bed = Bed(size: .queen, capacity: "2", occupants: ["Vic", "Andrew"])
        let thirdBed: Bed = Bed(size: .twin, capacity: "1", occupants: ["Jules"])
        
        cottageModel.bedsList = [firstBed, secondBed, thirdBed]
        
        //test drinks
        let philsList: PersonalDrinksList = PersonalDrinksList(person: "Phil", drinkNames: ["Tequila", "Vodka", "Cranberry Juice", "Cooler"])
        let laurasList: PersonalDrinksList = PersonalDrinksList(person: "Laura", drinkNames: ["Water", "More Water", "Water but H2O"])
        let medeisList: PersonalDrinksList = PersonalDrinksList(person: "Medei", drinkNames: ["Drink no one cares about", "Expensive drink no one cares about", "Drink that shows I work at LCBO", "Mike's hard"])
        
        cottageModel.drinksList = [philsList, laurasList, medeisList]
        
    }

}
