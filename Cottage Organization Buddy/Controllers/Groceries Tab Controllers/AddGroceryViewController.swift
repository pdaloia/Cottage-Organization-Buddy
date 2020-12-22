//
//  AddGroceryViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryViewController: UIViewController {
    
    weak var addGroceryToListDelegate: AddGroceryToListDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeViewController()
    }
    
    func initializeViewController() {
        
        let addGroceryView = AddGroceryView()
        addGroceryView.uploadGroceryDelegate = self
        
        self.view.addSubview(addGroceryView)
        
        addGroceryView.translatesAutoresizingMaskIntoConstraints = false
        addGroceryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        addGroceryView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addGroceryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addGroceryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}

extension AddGroceryViewController: AddGroceryDelegate {
    
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
    
}
