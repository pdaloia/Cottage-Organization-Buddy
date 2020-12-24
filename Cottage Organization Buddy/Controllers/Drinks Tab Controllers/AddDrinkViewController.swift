//
//  AddDrinkViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-23.
//

import UIKit

class AddDrinkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeViewController()
    }
    
    func initializeViewController() {
        
        let addDrinkView = AddDrinkView()
        
        self.view.addSubview(addDrinkView)
        addDrinkView.translatesAutoresizingMaskIntoConstraints = false
        addDrinkView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        addDrinkView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addDrinkView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addDrinkView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}
