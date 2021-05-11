//
//  InviteUsersView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-09.
//

import UIKit

class InviteUsersView: UIView {
    
    var inviteDelegate: InviteUsersViewDelegate?
    
    var emailInput: UITextField?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        //create the input field with constraints
        emailInput = UITextField()
        emailInput!.placeholder = "Email of user"
        emailInput!.autocorrectionType = .no
        emailInput!.autocapitalizationType = .none
        self.addSubview(emailInput!)
        emailInput!.translatesAutoresizingMaskIntoConstraints = false
        emailInput!.topAnchor.constraint(equalTo: self.topAnchor, constant: 50).isActive = true
        emailInput!.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        emailInput!.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        //create the send invite button
        let sendButton = UIButton()
        sendButton.setTitle("Send Invite", for: .normal)
        sendButton.setTitleColor(.systemBlue, for: .normal)
        sendButton.addTarget(self, action: #selector(sendInviteButtonPressed), for: .touchUpInside)
        
        //create the constraints on the button
        self.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: emailInput!.bottomAnchor, constant: 20).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func sendInviteButtonPressed() {
        
        if let delegate = self.inviteDelegate {
            
            let validated = delegate.validate(email: emailInput!.text!)
            if validated {
                delegate.emailSubmitted(email: emailInput!.text!)
            }
            
        }
        
    }

}

protocol InviteUsersViewDelegate {
    
    func emailSubmitted(email: String)
    
    func validate(email: String) -> Bool
        
}
