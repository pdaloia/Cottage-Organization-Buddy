//
//  ViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import UIKit
import Firebase
import GoogleSignIn

class HomeController: UIViewController {
    
    var googleSignInbutton = GIDSignInButton()
    var homeLabel: UILabel?
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .systemBackground
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
                       
        homeLabel = UILabel()
        homeLabel!.text = "Cottage Organization Buddy"
        homeLabel!.font = homeLabel!.font.withSize(23)
        
        self.view.addSubview(homeLabel!)
        homeLabel?.translatesAutoresizingMaskIntoConstraints = false
        homeLabel?.bottomAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        homeLabel?.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.addSubview(googleSignInbutton)
        googleSignInbutton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInbutton.topAnchor.constraint(equalTo: self.homeLabel!.bottomAnchor).isActive = true
        googleSignInbutton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
               
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(false)
        
        //check if user is already signed in here
        if GIDSignIn.sharedInstance().hasPreviousSignIn() {
            
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
            
        }
        else {
            print("not signed in")
        }
        
    }
    
    func pushLandingPageController() {
        
        let landingPageContainerVC = LandingPageContainerViewController()
        
        //let navController = UINavigationController(rootViewController: landingPageContainerVC)
        landingPageContainerVC.modalPresentationStyle = .fullScreen
        
        let firestoreService = FirestoreServices()
        firestoreService.getCottages(for: Auth.auth().currentUser!.uid) { cottageInfos in
            
            landingPageContainerVC.configureLandingPageViewController(with: cottageInfos)
            
            self.spinner.stopAnimating()
            
            self.present(landingPageContainerVC, animated: true, completion: nil)
            
        }
                
    }
    
    func checkForUserDocument(id: String, email: String, firstName: String, lastName: String, fullName: String) {
        
        let firestoreService = FirestoreServices()
        
        firestoreService.checkForUserDocument(id: id) { found in
            if found {
                self.pushLandingPageController()
            }
            else {
                firestoreService.createUserDocument(for: id, email: email, firstName: firstName, lastName: lastName, fullName: fullName) { successfullyCreated in
                    if successfullyCreated {
                        self.pushLandingPageController()
                    }
                    else {
                        self.spinner.stopAnimating()
                        ToastMessageDisplayer.showToast(controller: self, message: "Error creating user document on initial login", seconds: 2)
                    }
                }
            }
        }
        
    }

}

extension HomeController: GIDSignInDelegate{

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        self.view.addSubview(spinner)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.topAnchor.constraint(equalTo: googleSignInbutton.bottomAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        spinner.startAnimating()
        
        if let error = error {
            print("\(error.localizedDescription)")
            spinner.stopAnimating()
            return
        } else {
            let userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            
            print("User ID: ", userId!)
            print("ID Token: ", idToken!)
            print("Full Name: ", fullName!)
            print("Given Name: ", givenName!)
            print("Family Name: ", familyName!)
            print("Email: ", email!)
        }

        guard let authentication = user.authentication else {
            spinner.stopAnimating()
            return
        }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        // Authenticate with Firebase using the credential object
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("authentication error \(error.localizedDescription)")
            }
            else {
                self.checkForUserDocument(id: Auth.auth().currentUser!.uid, email: user.profile.email, firstName: user.profile.givenName, lastName: user.profile.familyName, fullName: user.profile.name)
            }
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("disconnecting")
    }
    
}

