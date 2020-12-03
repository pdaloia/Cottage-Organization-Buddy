//
//  DrinkListController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-02.
//

import UIKit

class DrinkListController: UIViewController {
    
    var drinkTableView: UITableView?
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
    
}
