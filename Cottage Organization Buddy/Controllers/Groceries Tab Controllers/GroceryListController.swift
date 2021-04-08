//
//  GroceryListController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-01.
//

import UIKit

class GroceryListController: UIViewController {
    
    //the cottage model which will use dependency injection. We have it here as a reference for adding groceries when needed.
    var cottageModel: CottageTrip?
    
    //information for the table view to use to display
    var groceryListToDisplay: [Grocery]?
    var groceryListTitle: String?
    var groceryListTableView: UITableView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = groceryListTitle
        
        if self.title == "All Items" && UserService.checkIfOrganiser(model: cottageModel!) {
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addBarButtonPressed))
            self.navigationItem.rightBarButtonItem = addButton
        }
        
        groceryListTableView = UITableView()
        groceryListTableView?.dataSource = self
        groceryListTableView?.delegate = self
        setupGroceryListTableView()

    }
    
    @objc func addBarButtonPressed() {
        let addGroceryVC = AddGroceryViewController()
        addGroceryVC.cottageModel = cottageModel
        addGroceryVC.addGroceryToListDelegate = self
        self.navigationController?.pushViewController(addGroceryVC, animated: true)
    }

}

extension GroceryListController: UITableViewDelegate, UITableViewDataSource {
    
    func setupGroceryListTableView() {
        
        self.view.addSubview(groceryListTableView!)
        
        groceryListTableView?.translatesAutoresizingMaskIntoConstraints = false
        groceryListTableView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        groceryListTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        groceryListTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        groceryListTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
            case 0:
                return groceryListToDisplay!.count
            default:
                return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let currentCell = UITableViewCell()
        
        currentCell.textLabel?.text = groceryListToDisplay?[indexPath.item].productName
        
        return currentCell
        
    }
    
}

extension GroceryListController: AddGroceryToListDelegate {
    
    func groceryAlreadyInList(grocery: String) -> Bool {
        
        if cottageModel!.groceryList.allItems.contains(where: { $0.productName.lowercased() == grocery.lowercased() } ) {
            return true
        }
        else {
            return false
        }
        
    }
    
    func addToAllItemsList(Grocery groceryModel: Grocery, for user: String) {
        
        //add to firebase
        let firestoreService = FirestoreServices()
        firestoreService.upload(grocery: groceryModel, for: user, to: cottageModel!.cottageID)
        
        //add to grocery list of user if assigned
        if user != "" {
            
            let assignedAttendee: Attendee = cottageModel!.attendeesList.first(where: { $0.firebaseUserID == user } )!
            cottageModel?.groceryList.groceryLists[assignedAttendee]?.append(groceryModel)
            
        }
        
        //add to currently loaded model
        self.cottageModel?.groceryList.allItems.append(groceryModel)
        self.groceryListToDisplay = self.cottageModel?.groceryList.allItems
        groceryListTableView?.reloadData()
        
    }
    
}
