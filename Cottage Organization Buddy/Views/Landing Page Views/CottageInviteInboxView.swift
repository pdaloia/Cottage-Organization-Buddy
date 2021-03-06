//
//  CottageInviteInboxView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-11.
//

import UIKit

class CottageInviteInboxView: UIView {
    
    var invitedCottages: [CottageInfo]?
    var invitedCottageCollectionView: InvitedCottagesCollectionView?
    
    var inboxDelegate: CottageInviteInboxViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        invitedCottageCollectionView = InvitedCottagesCollectionView(frame: self.frame, collectionViewLayout: layout)
        invitedCottageCollectionView!.invitedCottages = self.invitedCottages!
        invitedCottageCollectionView!.backgroundColor = .clear
        
        invitedCottageCollectionView!.dataSource = invitedCottageCollectionView.self
        invitedCottageCollectionView!.delegate = invitedCottageCollectionView.self
        invitedCottageCollectionView!.invitedCottageCVDelegate = self
        
        self.addSubview(invitedCottageCollectionView!)
        invitedCottageCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        invitedCottageCollectionView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        invitedCottageCollectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        invitedCottageCollectionView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        invitedCottageCollectionView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
}

extension CottageInviteInboxView: InvitedCottagesCollectionViewDelegate {
    
    func inviteSelected(invite: CottageInfo) {
        
        if let delegate = self.inboxDelegate {
            delegate.inviteSelected(invite: invite)
        }
        
    }
    
}

protocol CottageInviteInboxViewDelegate {
    
    func inviteSelected(invite: CottageInfo)
    
}
