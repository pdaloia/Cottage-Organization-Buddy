//
//  ViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-14.
//

import UIKit
import Firebase
import GoogleSignIn
import AuthenticationServices

class HomeController: UIViewController {
    
    //MARK: - Views
    
    let homePageView = HomePageView()
    
    //MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        homePageView.appleSignInDelegate = self
                       
        self.view.addSubview(homePageView)
        homePageView.translatesAutoresizingMaskIntoConstraints = false
        homePageView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        homePageView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        homePageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        homePageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
               
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
    
    //MARK: - Functions
    
    func pushLandingPageController() {
        
        let landingPageContainerVC = LandingPageContainerViewController()
        landingPageContainerVC.signOutProtocol = self
        
        //let navController = UINavigationController(rootViewController: landingPageContainerVC)
        landingPageContainerVC.modalPresentationStyle = .fullScreen
        
        let firestoreService = FirestoreServices()
        firestoreService.getCottages(for: Auth.auth().currentUser!.uid) { cottageInfos in
            
            landingPageContainerVC.configureLandingPageViewController(with: cottageInfos)
            
            self.homePageView.isUserInteractionEnabled = true
            self.homePageView.stopAnimatingActivitySpinner()
            
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
                        self.homePageView.isUserInteractionEnabled = true
                        self.homePageView.stopAnimatingActivitySpinner()
                        ToastMessageDisplayer.showToast(controller: self, message: "Error creating user document on initial login", seconds: 2)
                    }
                }
            }
        }
        
    }

}

extension HomeController: GIDSignInDelegate{

    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        
        self.homePageView.isUserInteractionEnabled = false
        self.homePageView.startAnimatingActivitySpinner()
        
        if let error = error {
            print("\(error.localizedDescription)")
            self.homePageView.isUserInteractionEnabled = true
            self.homePageView.stopAnimatingActivitySpinner()
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
            self.homePageView.isUserInteractionEnabled = true
            self.homePageView.stopAnimatingActivitySpinner()
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

extension HomeController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                fatalError("Invalid state: A login callback was received, but no login request was sent")
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                return
            }
            
            let credential = OAuthProvider.credential(withProviderID: "apple.com", idToken: idTokenString, rawNonce: nonce)
            
            Auth.auth().signIn(with: credential) { AuthDataResult, Error in
                if let user = AuthDataResult?.user {
                    print("Nice!. You're now signed in as \(user.uid), email: \(user.email ?? "unknown"), first name: \(appleIDCredential.fullName?.givenName ?? ""), last name: \(appleIDCredential.fullName?.familyName ?? "")")
                }
            }
            
        }
        
    }
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.view.window!
        
    }
    
}

extension HomeController: HomePageViewAppleSignInDelegate {
    
    func performAppleSignIn() {
        
        let request = createAppleIDRequest()
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        
        authorizationController.performRequests()
        
    }
    
    func createAppleIDRequest() -> ASAuthorizationAppleIDRequest {
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let nonce = randomNonceString()
        request.nonce = sha256(nonce)
        currentNonce = nonce
        return request
        
    }
    
}

extension HomeController: SignOutProtocol {
    
    func signOutCurrentUser() {
        
        do {
            try Auth.auth().signOut()
            GIDSignIn.sharedInstance().signOut()
        }
        catch {
            print("already logged out")
        }
        
        DismissAndPopAllViewControllers()
        
    }
    
    func DismissAndPopAllViewControllers() {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

// Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
private func randomNonceString(length: Int = 32) -> String {
  precondition(length > 0)
  let charset: Array<Character> =
      Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
  var result = ""
  var remainingLength = length

  while remainingLength > 0 {
    let randoms: [UInt8] = (0 ..< 16).map { _ in
      var random: UInt8 = 0
      let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
      if errorCode != errSecSuccess {
        fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
      }
      return random
    }

    randoms.forEach { random in
      if remainingLength == 0 {
        return
      }

      if random < charset.count {
        result.append(charset[Int(random)])
        remainingLength -= 1
      }
    }
  }

  return result
}

import CryptoKit

// Unhashed nonce.
fileprivate var currentNonce: String?
@available(iOS 13, *)
private func sha256(_ input: String) -> String {
  let inputData = Data(input.utf8)
  let hashedData = SHA256.hash(data: inputData)
  let hashString = hashedData.compactMap {
    return String(format: "%02x", $0)
  }.joined()

  return hashString
}
