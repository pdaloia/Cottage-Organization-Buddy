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
    
}
