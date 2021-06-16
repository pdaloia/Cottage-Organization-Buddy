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
    var appleSignInDelegate: HomePageViewAppleSignInDelegate?
    
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
        
        if let delegate = self.appleSignInDelegate {
            delegate.performAppleSignIn()
        }
        
    }
    
    func startAnimatingActivitySpinner() {
        
        activitySpinner.startAnimating()
        
    }
    
    func stopAnimatingActivitySpinner() {
        
        
        activitySpinner.stopAnimating()
        
    }
    
}

protocol HomePageViewAppleSignInDelegate {
    
    func performAppleSignIn()
    
}
