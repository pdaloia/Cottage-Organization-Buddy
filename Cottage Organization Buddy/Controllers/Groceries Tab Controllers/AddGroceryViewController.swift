//
//  AddGroceryViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryViewController: UIViewController {
    
    weak var addGroceryToListDelegate: AddGroceryToListDelegate?
    var cottageModel: CottageTrip?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeViewController()
    }
    
    func initializeViewController() {
        
        let addGroceryView = AddGroceryView()
        addGroceryView.uploadGroceryDelegate = self
        addGroceryView.attendeesToPick = cottageModel!.attendeesList
        
        self.view.addSubview(addGroceryView)
        
        addGroceryView.translatesAutoresizingMaskIntoConstraints = false
        addGroceryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        addGroceryView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addGroceryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addGroceryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}

extension AddGroceryViewController: AddGroceryDelegate {
    
    func validateInputs(name: String, price: Double, quantity: Int) -> Bool {
        
        if let del = self.addGroceryToListDelegate {
            if del.groceryAlreadyInList(grocery: name) {
                ToastMessageDisplayer.showToast(controller: self, message: "Grocery already in list, edit instead.", seconds: 1)
                return false
            }
        }
        if name.isEmpty {
            ToastMessageDisplayer.showToast(controller: self, message: "Enter a name", seconds: 1)
            return false
        }
        if price == 0 {
            ToastMessageDisplayer.showToast(controller: self, message: "Price can not be $0.00", seconds: 1)
            return false
        }
        if quantity == 0 {
            ToastMessageDisplayer.showToast(controller: self, message: "Quantity can not be 0", seconds: 1)
            return false
        }
        
        return true
        
    }
    
    func uploadToVC(Grocery groceryInformation: Grocery) {
        
        let groceryToAddToList: Grocery = groceryInformation
        
        if let del = self.addGroceryToListDelegate {
            del.addToAllItemsList(Grocery: groceryToAddToList)
        }
        
        self.navigationController?.popViewController(animated: true)
        
    }
    
}

protocol AddGroceryToListDelegate: class {
    
    func addToAllItemsList(Grocery groceryModel: Grocery)
    
    func groceryAlreadyInList(grocery: String) -> Bool
    
}
