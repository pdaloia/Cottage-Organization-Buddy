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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        
        let landingPageVC = LandingPageViewController()
        landingPageVC.modalPresentationStyle = .fullScreen
        
        let firestoreService = FirestoreServices()
        firestoreService.getCottages(for: Auth.auth().currentUser!.uid) { cottageInfos in
            
            landingPageVC.userCottages = cottageInfos
            
            self.present(landingPageVC, animated: true, completion: nil)
            
        }
                
    }
    
    func pushCottageTabsController() {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "CottageTabs", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "CottageTabsView") as! CottageTabsController
        nextViewController.modalPresentationStyle = .fullScreen
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        
        let service = FirestoreServices()
        service.get(cottage: "test123456789") { model in
            
            nextViewController.cottageModel = model!
            self.present(nextViewController, animated:true, completion:nil)
            
        }
        
        
    }

}

extension HomeController: GIDSignInDelegate{

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        if let error = error {
            print("\(error.localizedDescription)")
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

        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
        
        // Authenticate with Firebase using the credential object
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("authentication error \(error.localizedDescription)")
            }
        }
        
        pushLandingPageController()
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        print("disconnecting")
    }
    
}

