//
//  AddGroceryViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeViewController()
    }
    
    func initializeViewController() {
        
        let addGroceryView = AddGroceryView()
        
        self.view.addSubview(addGroceryView)
        
        addGroceryView.translatesAutoresizingMaskIntoConstraints = false
        addGroceryView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        addGroceryView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addGroceryView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addGroceryView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}
