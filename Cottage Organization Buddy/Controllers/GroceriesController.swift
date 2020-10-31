//
//  GroceriesController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class GroceriesController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    var groceriesTableView: UITableView?
    var navBar: UINavigationBar?
    
    @IBOutlet weak var groceriesList: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up navigation bar
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44))
        setUpNavBar()
        
        //set up groceries table view
        groceriesTableView = UITableView()
        groceriesTableView?.dataSource = self
        groceriesTableView?.delegate = self
        setGroceriesTableViewConstraints()
    }

}

extension GroceriesController: UITableViewDataSource, UITableViewDelegate {
    
    func setUpNavBar() {
        //add navigation bar to view and set its constraints
        self.view.addSubview(navBar!)
        navBar?.translatesAutoresizingMaskIntoConstraints = false
        navBar?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        navBar?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        navBar?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        //set its title item
        let navBarTitle = UINavigationItem(title: "Groceries")
        
        //add the navigation bar's items
        navBar!.setItems([navBarTitle], animated: false)
    }
    
    func setGroceriesTableViewConstraints() {
        //add table to the view and set its constraints
        self.view.addSubview(groceriesTableView!)
        groceriesTableView?.translatesAutoresizingMaskIntoConstraints = false
        groceriesTableView?.topAnchor.constraint(equalTo: self.navBar!.bottomAnchor).isActive = true
        groceriesTableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        groceriesTableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        groceriesTableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Personal Groceries Lists"
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cottageModel!.groceryList.groceriesPerPerson.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentCell = GroceriesTableViewCell()
        
        switch indexPath.section {
        case 0:
            currentCell.textLabel?.text = "All Grocery Items"
        case 1:
            currentCell.textLabel?.text = cottageModel!.groceryList.groceriesPerPerson[indexPath.row].person.name + "'s grocery list"
        default:
            currentCell.textLabel?.text = "Error"
        }
        
        return currentCell
    }
    
}
