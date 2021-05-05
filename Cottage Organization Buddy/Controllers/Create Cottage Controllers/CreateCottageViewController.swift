//
//  CreateCottageViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-04.
//

import UIKit

class CreateCottageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Create Cottage"
        self.view.backgroundColor = .systemBackground
        
        initializeViewController()
    }
    
    func initializeViewController() {
        
        let createCottageView = CreateCottageView()
        self.view.addSubview(createCottageView)
        createCottageView.translatesAutoresizingMaskIntoConstraints = false
        createCottageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        createCottageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        createCottageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        createCottageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.view.addSubview(createCottageView)
        
    }

}
