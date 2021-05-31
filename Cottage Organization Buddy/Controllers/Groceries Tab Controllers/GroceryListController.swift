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
    
    //table view data
    let reuseIdentifier = "cell"

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = groceryListTitle
        
        if self.title == "All Items" && UserService.checkIfOrganiser(model: cottageModel!) {
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.addBarButtonPressed))
            self.navigationItem.rightBarButtonItem = addButton
        }
        
        self.groceryListToDisplay?.sort(by: { grocery1, grocery2 in
            grocery1.productName.lowercased() < grocery2.productName.lowercased()
        })
        
        groceryListTableView = UITableView()
        groceryListTableView?.dataSource = self
        groceryListTableView?.delegate = self
        groceryListTableView?.register(GroceryListTableViewCell.self, forCellReuseIdentifier: self.reuseIdentifier)
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
        
        let currentCell: GroceryListTableViewCell = self.groceryListTableView!.dequeueReusableCell(withIdentifier: self.reuseIdentifier) as! GroceryListTableViewCell
        
        currentCell.cellsGroceryModel = groceryListToDisplay?[indexPath.item]
        currentCell.setCellsContents()
        
        return currentCell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if !UserService.checkIfOrganiser(model: cottageModel!) || groceryListTitle != "All Items" {
            return nil
        }
        
        let deleteItem = UIContextualAction(style: .destructive, title: "Delete", handler: {action, view, success in
            print("deleting \(self.groceryListToDisplay![indexPath.row].productName)")
            
            let groceryToDelete: Grocery = self.groceryListToDisplay![indexPath.row]
            
            //get the firestore service and delete the document for the selected grocery to delete
            let firestoreServices = FirestoreServices()
            firestoreServices.delete(grocery: self.groceryListToDisplay![indexPath.row], in: self.cottageModel!.cottageID)
            
            //remove the grocery from this lists table view data source and reload it to remove it
            self.groceryListToDisplay!.remove(at: indexPath.row)
            self.groceryListTableView?.reloadData()
            
            //get the assigned user for this grocery and remove from this persons list
            if let assignedUser = self.cottageModel!.attendeesList.first(where: { $0.firebaseUserID == groceryToDelete.assignedTo } ) {
                self.cottageModel!.groceryList.groceryLists[assignedUser]?.removeAll(where: { $0.productName == groceryToDelete.productName } )
            }
            
            //delete it from the model
            self.cottageModel!.groceryList.allItems.removeAll(where: { $0.productName == groceryToDelete.productName } )
            
        })
        deleteItem.backgroundColor = .red
        
        let editItem = UIContextualAction(style: .normal, title: "Edit", handler: {action, view, success in
            print("editing")
        })
        editItem.backgroundColor = .yellow
        
        let swipeActions = UISwipeActionsConfiguration(actions: [deleteItem, editItem])
        swipeActions.performsFirstActionWithFullSwipe = false
        
        return swipeActions
        
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
            if cottageModel!.groceryList.groceryLists[assignedAttendee] == nil {
                cottageModel!.groceryList.groceryLists[assignedAttendee] = []
            }
            cottageModel!.groceryList.groceryLists[assignedAttendee]?.append(groceryModel)
            
        }
        
        //add to currently loaded model
        self.cottageModel?.groceryList.allItems.append(groceryModel)
        self.groceryListToDisplay = self.cottageModel?.groceryList.allItems
        groceryListTableView?.reloadData()
        
    }
    
}
