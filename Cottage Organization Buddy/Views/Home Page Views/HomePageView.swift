//
//  HomePageView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-06-13.
//

import UIKit
import GoogleSignIn

class HomePageView: UIView {
    
    //MARK: - Views
    
    let googleSignInButton = GIDSignInButton()
    
    let homeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Cottage Buddy"
        label.font = label.font.withSize(23)
        return label
    }()
    
    let homeImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var activitySpinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        return spinner
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
        
        self.addSubview(homeTitleLabel)
        homeTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        homeTitleLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        homeTitleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(googleSignInButton)
        googleSignInButton.translatesAutoresizingMaskIntoConstraints = false
        googleSignInButton.topAnchor.constraint(equalTo: self.homeTitleLabel.bottomAnchor).isActive = true
        googleSignInButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.addSubview(activitySpinner)
        activitySpinner.translatesAutoresizingMaskIntoConstraints = false
        activitySpinner.topAnchor.constraint(equalTo: googleSignInButton.bottomAnchor).isActive = true
        activitySpinner.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
    }
    
    func startAnimatingActivitySpinner() {
        
        activitySpinner.startAnimating()
        
    }
    
    func stopAnimatingActivitySpinner() {
        
        
        activitySpinner.stopAnimating()
    }
    
}
