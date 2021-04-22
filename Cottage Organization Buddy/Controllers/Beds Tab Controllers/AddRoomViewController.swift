//
//  AddRoomViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-21.
//

import UIKit

class AddRoomViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Add Room"
        self.view.backgroundColor = .systemBackground
        
        initializeView()
        
    }
    
    func initializeView() {
        
        let addRoomView = AddRoomView()
        self.view.addSubview(addRoomView)
        addRoomView.translatesAutoresizingMaskIntoConstraints = false
        addRoomView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        addRoomView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addRoomView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        addRoomView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
}
