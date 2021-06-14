//
//  LandingPageView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-28.
//

import UIKit

class LandingPageView: UIView {
    
    //MARK: - Properties
    
    var userCottages: [CottageInfo]?
    
    var landingPageViewDelegate: LandingPageViewDelegate?
    
    //MARK: - Views
    
    var cottageCollectionView: CottageCollectionView?
    
    var activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        return spinner
    }()

    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func initializeView() {
        
        //initialize the collection view
        initializeCollectionView()
        
        //add the subviews
        self.addSubview(activityIndicator)
        self.addSubview(cottageCollectionView!)
        
        //set the constraints
        cottageCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        cottageCollectionView?.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cottageCollectionView?.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cottageCollectionView?.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cottageCollectionView?.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
    }
    
    private func initializeCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        flowLayout.itemSize = CGSize(width: 60, height: 60)
        
        cottageCollectionView = CottageCollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        cottageCollectionView?.backgroundColor = .clear
        
        cottageCollectionView?.dataSource = cottageCollectionView.self
        cottageCollectionView?.delegate = cottageCollectionView.self
        cottageCollectionView?.cottageCollectionViewDelegate = self
        cottageCollectionView?.userCottages = self.userCottages
        
    }
    
    func startAnimatingActivityIndicator() {
        
        self.isUserInteractionEnabled = false
        self.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
        
    }
    
    func stopAnimatingActivityIndicator() {
        
        self.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        
    }
    
}

extension LandingPageView: CottageCollectionViewDelegate{
    
    func cottageCellPressed(for id: String) {
        if let delegate = self.landingPageViewDelegate {
            delegate.cottageCellPressed(for: id)
        }
    }
    
    func newCottageCellPressed() {
        if let delegate = self.landingPageViewDelegate {
            delegate.newCottageCellPressed()
        }
    }
    
}

protocol LandingPageViewDelegate {
    
    func cottageCellPressed(for cottageID: String)
    
    func newCottageCellPressed()
    
}
