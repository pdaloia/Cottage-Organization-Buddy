//
//  CottageInviteInboxViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-11.
//

import UIKit
import FirebaseAuth

class CottageInviteInboxViewController: UIViewController {
    
    var invitedCottages: [CottageInfo]?
    var inviteInboxView: CottageInviteInboxView?
    var cottageInviteInboxVCDelegate: CottageInviteInboxVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Cottage Invites"
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")

        setupViewController()
    }
    
    func setupViewController() {
        
        inviteInboxView = CottageInviteInboxView()
        inviteInboxView!.invitedCottages = self.invitedCottages!
        inviteInboxView!.inboxDelegate = self
        inviteInboxView!.setupView()
        
        self.view.addSubview(inviteInboxView!)
        inviteInboxView!.translatesAutoresizingMaskIntoConstraints = false
        inviteInboxView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        inviteInboxView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        inviteInboxView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        inviteInboxView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}

extension CottageInviteInboxViewController: CottageInviteInboxViewDelegate {
    
    func inviteSelected(invite: CottageInfo) {
        
        let firestoreSerive = FirestoreServices()
        
        let acceptAlertAction = UIAlertAction(title: "Accept", style: .default) { _ in
            firestoreSerive.acceptInvite(for: invite.CottageID, userID: Auth.auth().currentUser!.uid, name: Auth.auth().currentUser!.displayName!)
            self.invitedCottages!.removeAll(where: { $0.CottageID == invite.CottageID } )
            self.inviteInboxView!.invitedCottages = self.invitedCottages!
            self.inviteInboxView!.invitedCottageCollectionView!.invitedCottages = self.invitedCottages!
            self.inviteInboxView?.invitedCottageCollectionView!.reloadData()
            
            if let delegate = self.cottageInviteInboxVCDelegate {
                delegate.accepted(invite: invite)
            }
        }
        
        let declineAlertAction = UIAlertAction(title: "Decline", style: .destructive) { _ in
            firestoreSerive.declineInvite(for: invite.CottageID, userID: Auth.auth().currentUser!.uid)
            self.invitedCottages!.removeAll(where: { $0.CottageID == invite.CottageID } )
            self.inviteInboxView!.invitedCottages = self.invitedCottages!
            self.inviteInboxView!.invitedCottageCollectionView!.invitedCottages = self.invitedCottages!
            self.inviteInboxView?.invitedCottageCollectionView!.reloadData()
        }
        
        let inviteApprovalAlert = UIAlertController(title: "Cottage Invite", message: "Accept/Decline invite to \(invite.CottageName)", preferredStyle: .alert)
        inviteApprovalAlert.addAction(declineAlertAction)
        inviteApprovalAlert.addAction(acceptAlertAction)
        
        self.present(inviteApprovalAlert, animated: true, completion: nil)
        
    }
    
}

protocol CottageInviteInboxVCDelegate {
    
    func accepted(invite: CottageInfo)
    
}
