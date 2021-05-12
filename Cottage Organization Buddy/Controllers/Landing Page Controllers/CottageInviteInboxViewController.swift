//
//  CottageInviteInboxViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-11.
//

import UIKit

class CottageInviteInboxViewController: UIViewController {
    
    var invitedCottages: [CottageInfo]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cottage Invites"
        self.view.backgroundColor = .systemBackground

        setupViewController()
    }
    
    func setupViewController() {
        
        let inviteInboxView = CottageInviteInboxView()
        inviteInboxView.invitedCottages = self.invitedCottages!
        inviteInboxView.setupView()
        
        self.view.addSubview(inviteInboxView)
        inviteInboxView.translatesAutoresizingMaskIntoConstraints = false
        inviteInboxView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        inviteInboxView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        inviteInboxView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        inviteInboxView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}
