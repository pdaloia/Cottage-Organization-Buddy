//
//  InviteUsersViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-09.
//

import UIKit
import Firebase

class InviteUsersViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        setupViewController()
    }
    
    func setupViewController() {
        
        //create the view and add it to the controllers view with constraints
        let inviteUsersView = InviteUsersView()
        self.view.addSubview(inviteUsersView)
        inviteUsersView.translatesAutoresizingMaskIntoConstraints = false
        inviteUsersView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        inviteUsersView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inviteUsersView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        inviteUsersView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }

}
