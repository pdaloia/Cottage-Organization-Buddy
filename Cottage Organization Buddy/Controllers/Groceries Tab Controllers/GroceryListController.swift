//
//  GroceryListController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-01.
//

import UIKit

class GroceryListController: UIViewController {
    
    var groceryListToDisplay: [Grocery]?
    var groceryListTitle: String?
    var groceryListTableView: UITableView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        title = groceryListTitle
        
        if self.title == "All Items" {
            let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(self.test))
            self.navigationItem.rightBarButtonItem = addButton
        }
        
        groceryListTableView = UITableView()
        groceryListTableView?.dataSource = self
        groceryListTableView?.delegate = self
        setupGroceryListTableView()

    }
    
    @objc func test() {
        print("add button clicked")
        let addGroceryVC = AddGroceryViewController()
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