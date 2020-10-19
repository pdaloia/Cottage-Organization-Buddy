//
//  GroceriesController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class GroceriesController: UIViewController {
    
    @IBOutlet weak var groceriesList: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let tabBar = tabBarController as! CottageTabsController
        
        groceriesList.text = String(describing:tabBar.cottageModel.groceryList)
    }

}
