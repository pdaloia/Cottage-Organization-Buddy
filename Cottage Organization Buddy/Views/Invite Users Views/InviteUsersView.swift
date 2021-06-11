//
//  InviteUsersView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-09.
//

import UIKit

class InviteUsersView: UIView {
    
    //MARK: - Properties
    
    var inviteDelegate: InviteUsersViewDelegate?
    
    //MARK: - Views
    
    var emailInput: UITextField = {
        let emailInput = UITextField()
        emailInput.placeholder = "Email of user"
        emailInput.autocorrectionType = .no
        emailInput.autocapitalizationType = .none
        emailInput.addTarget(self, action: #selector(emailFieldEdited(sender:)), for: .editingChanged)
        return emailInput
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = label.font.withSize(14)
        label.textColor = UIColor(named: "Cottage Dark Green")
        label.isHidden = true
        return label
    }()
    
    let sendButton: UIButton = {
        let sendButton = UIButton()
        sendButton.setTitle("Send Invite", for: .normal)
        sendButton.setTitleColor(.systemBlue, for: .normal)
        sendButton.addTarget(self, action: #selector(sendInviteButtonPressed), for: .touchUpInside)
        return sendButton
    }()

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func setupView() {
        
        //add subview
        self.addSubview(emailLabel)
        self.addSubview(emailInput)
        
        //constraints
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        emailLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        
        emailInput.translatesAutoresizingMaskIntoConstraints = false
        emailInput.topAnchor.constraint(equalTo: self.emailLabel.bottomAnchor).isActive = true
        emailInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        emailInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 20).isActive = true
        
        self.addSubview(sendButton)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.topAnchor.constraint(equalTo: emailInput.bottomAnchor, constant: 20).isActive = true
        sendButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    @objc func sendInviteButtonPressed() {
        
        if let delegate = self.inviteDelegate {
            
            let validated = delegate.validate(email: emailInput.text!)
            if validated {
                delegate.emailSubmitted(email: emailInput.text!)
            }
            
        }
        
    }
    
    @objc func emailFieldEdited(sender: UITextField) {
        
        if sender.text!.count > 1 {
            return
        }
        
        if sender.text != "" {
            UIView.transition(with: emailLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.emailLabel.isHidden = false
                          })
        }
        else {
            UIView.transition(with: emailLabel, duration: 0.6,
                              options: .transitionCrossDissolve,
                              animations: {
                                self.emailLabel.isHidden = true
                          })
        }
        
    }

}

protocol InviteUsersViewDelegate {
    
    func emailSubmitted(email: String)
    
    func validate(email: String) -> Bool
        
}
