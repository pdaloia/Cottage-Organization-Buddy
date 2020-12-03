//
//  DrinksController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class DrinksController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Drinks"
    }

}

extension DrinksController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cottageModel!.drinksList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Shared Drinks List"
        case 1:
            return "Personal Drinks List"
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = DrinksTableViewCell()
        
        switch indexPath.section {
        case 0:
            currentCell.textLabel?.text = "Shared Drinks List"
        case 1:
            currentCell.textLabel?.text = cottageModel!.drinksList[indexPath.row].person.name + "'s list"
        default:
            currentCell.textLabel?.text = "Error"
        }
        
        return currentCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let drinkListController = DrinkListController()
        
        switch(indexPath.section) {
        case 0:
            drinkListController.drinksToDisplay = cottageModel?.returnSharedDrinksList()
            drinkListController.title = "Shared Drinks"
        case 1:
            drinkListController.drinksToDisplay = cottageModel?.drinksList[indexPath.item].drinkNames
            drinkListController.title = "\(cottageModel?.drinksList[indexPath.item].person.name ?? "Error")'s list"
        default:
            drinkListController.drinksToDisplay = []
        }
        
        self.navigationController?.pushViewController(drinkListController, animated: true)
        
    }
    
}
