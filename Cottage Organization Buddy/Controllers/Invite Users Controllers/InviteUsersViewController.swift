//
//  InviteUsersViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-09.
//

import UIKit
import Firebase

class InviteUsersViewController: UIViewController {
    
    var cottageID: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground

        setupViewController()
    }
    
    func setupViewController() {
        
        //create the view and add it to the controllers view with constraints
        let inviteUsersView = InviteUsersView()
        inviteUsersView.inviteDelegate = self
        self.view.addSubview(inviteUsersView)
        inviteUsersView.translatesAutoresizingMaskIntoConstraints = false
        inviteUsersView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        inviteUsersView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        inviteUsersView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        inviteUsersView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }

}

extension InviteUsersViewController: InviteUsersViewDelegate {
    
    func emailSubmitted(email: String) {
        
        let firestoreService = FirestoreServices()
        firestoreService.sendInvite(to: email, for: self.cottageID!) { errorMessage in
            
            //if there is an error message returned from the firestore service function
            if let error = errorMessage {
                switch error {
                
                case "Not Registered":
                    let inviteAlertAction = UIAlertAction(title: "Invite", style: .default) {_ in
                        firestoreService.createPendingInvites(for: email, in: self.cottageID!)
                        self.dismiss(animated: true, completion: nil)
                    }
                    let cancelAlertAction = UIAlertAction(title: "Cancel", style: .cancel) {_ in
                        //do nothing
                    }
                    let alert = UIAlertController(title: "Invite User", message: "This email address has not signed up for cottage buddy, send an invite to register?", preferredStyle: .alert)
                    alert.addAction(inviteAlertAction)
                    alert.addAction(cancelAlertAction)
                    self.present(alert, animated: true, completion: nil)
                    break
                    
                case "Already In Cottage":
                    ToastMessageDisplayer.showToast(controller: self, message: "This email address is already in this cottage", seconds: 2)
                    break
                    
                case "More Than One User Document":
                    ToastMessageDisplayer.showToast(controller: self, message: "There is more than one document for this user. Please contact support to invite.", seconds: 2)
                    break
                    
                case "Firestore Error":
                    ToastMessageDisplayer.showToast(controller: self, message: "There was an error with the database, please contact support if the issue persists.", seconds: 2)
                    break
                    
                default:
                    break
                }
            }
            
            //if there is not returned error message
            else {
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        
    }
    
    func validate(email: String) -> Bool {
        
        let emailToValidate = email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        if emailToValidate == "" {
            return false
        }
        
        if !emailToValidate.hasSuffix("@gmail.com") {
            return false
        }
        
        if emailToValidate.components(separatedBy: "@").count != 2 {
            return false
        }
        
        if Array(emailToValidate)[0] == "@" {
            return false
        }
        
        return true
        
    }
    
}
