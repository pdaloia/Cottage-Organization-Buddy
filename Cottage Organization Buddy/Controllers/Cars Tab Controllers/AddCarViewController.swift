//
//  AddCarViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-24.
//

import UIKit

class AddCarViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        initializeVC()
    }
    

    func initializeVC() {        
        
        //create the view
        let addDriverView = AddCarView()
        
        //add the view to the VC
        self.view.addSubview(addDriverView)
        
        //set the auto layout constraints
        addDriverView.translatesAutoresizingMaskIntoConstraints = false
        addDriverView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        addDriverView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        addDriverView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        addDriverView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 1/3).isActive = true
        
    }

}
