//
//  HomePageView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-06-13.
//

import UIKit
import GoogleSignIn
import AuthenticationServices

class HomePageView: UIView {
    
    //MARK: - Views
    
    let googleSignInButton = GIDSignInButton()
    
    let appleSignInButton = ASAuthorizationAppleIDButton()
    
    let homeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cottage Buddy"
        label.font = UIFont(name: "AvenirNextCondensed-DemiBold", size: 50)
        label.textColor = UIColor(named: "Cottage Dark Green")
        label.textAlignment = .center
        return label
    }()
    
    let homeImageView: UIImageView = {
        let imageView = UIImageView()
        let cottageImage = UIImage(named: "Cartoon Cottage")
        imageView.image = cottageImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    var activitySpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        return spinner
    }()
    
    //MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupAppleSignInButton()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func setupView() {
        
        //add subviews
        self.addSubview(homeImageView)
        self.addSubview(homeTitleLabel)
        self.addSubview(googleSignInButton)
        self.addSubview(activitySpinner)
        self.addSubview(appleSignInButton)
        
        //add color pallets necessary
        googleSignInButton.backgroundColor = UIColor(named: "Cottage Green")
        googleSignInButton.tintColor = UIColor(named: "Cottage Green")
        
        //add constraints
        homeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTitleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        homeTitleLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1/4).isActive = true
        homeTitleLabel.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        homeImageView.translatesAutoresizingMaskIntoConstraints = false
        homeImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        homeImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        homeImageView.topAnchor.constraint(equalTo: homeTitleLabel.bottomAnchor).isActive = true
        homeImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
        
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.topAnchor.constraint(equalTo: self.homeImageView.bottomAnchor).isActive = true
        googleSignInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        googleSignInButton.trailingAnchor.constraint(equalTo: self.centerXAnchor, constant: -10).isActive = true
        
        appleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        appleSignInButton.topAnchor.constraint(equalTo: self.homeImageView.bottomAnchor).isActive = true
        appleSignInButton.leadingAnchor.constraint(equalTo: self.googleSignInButton.trailingAnchor, constant: 10).isActive = true
        appleSignInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        appleSignInButton.heightAnchor.constraint(equalTo: self.googleSignInButton.heightAnchor).isActive = true
        
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false
        activitySpinner.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor).isActive = true
        activitySpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    func setupAppleSignInButton() {
        
        appleSignInButton.addTarget(self, action: #selector(handleSignInWithAppleTapped), for: .touchUpInside)
        
    }
    
    @objc func handleSignInWithAppleTapped() {
        
        performAppleSignIn()
        
    }
    
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
    
    func startAnimatingActivitySpinner() {
        
        activitySpinner.startAnimating()
        
    }
    
    func stopAnimatingActivitySpinner() {
        
        
        activitySpinner.stopAnimating()
    }
    
}

extension HomePageView: ASAuthorizationControllerDelegate {
    
    
    
}

extension HomePageView: ASAuthorizationControllerPresentationContextProviding{
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        
        return self.window!
        
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
