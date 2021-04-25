//
//  DrinkListController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-02.
//

import UIKit
import FirebaseAuth

class DrinkListController: UIViewController {
    
    var cottageModel: CottageTrip?
    
    var drinkTableView: UITableView?
    var attendee: Attendee?
    var drinksToDisplay: [Drink]?
    var titleOfDrinkList: String?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        drinkTableView = UITableView()
        
        drinkTableView?.dataSource = self
        drinkTableView?.delegate = self
        
        self.view.addSubview(drinkTableView!)
        setupDrinkTableView()
        
    }

}

extension DrinkListController: UITableViewDelegate, UITableViewDataSource {
    
    func setupDrinkTableView() {
        
        drinkTableView?.translatesAutoresizingMaskIntoConstraints = false
        drinkTableView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        drinkTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        drinkTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        drinkTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return drinksToDisplay!.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentDrinkCell = UITableViewCell()
        
        currentDrinkCell.textLabel?.text = drinksToDisplay?[indexPath.item].name
        
        return currentDrinkCell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if self.attendee == nil || self.attendee?.firebaseUserID != Auth.auth().currentUser!.uid {
            return nil
        }
        
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete") {action, view, success in
            
            //get the drink to delete
            let drinkToDelete = self.drinksToDisplay![indexPath.row]
            
            //remove it from the drink list and reload the table view
            self.drinksToDisplay?.removeAll(where: { $0.name == drinkToDelete.name })
            self.drinkTableView?.reloadData()
            
            //delete the itam from the cottage model
            self.cottageModel!.drinksList[self.attendee!]?.removeAll(where: { $0.name == drinkToDelete.name })
            
            //delete the item from the firestore
            let firestoreService = FirestoreServices()
            firestoreService.delete(drink: drinkToDelete, for: Auth.auth().currentUser!.uid, in: self.cottageModel!.cottageID)
            
        }
        deleteItem.backgroundColor = .red
        
        let swipeItems = UISwipeActionsConfiguration(actions: [deleteItem])
        swipeItems.performsFirstActionWithFullSwipe = true
        
        return swipeItems
        
    }
    
}
