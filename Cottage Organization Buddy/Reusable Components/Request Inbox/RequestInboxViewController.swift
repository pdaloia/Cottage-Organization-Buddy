//
//  RequestInboxViewController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-01-31.
//

import UIKit

class RequestInboxViewController: UIViewController {
    
    var requestCollectionView: RequestCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupRequestViewController()

        // Do any additional setup after loading the view.
    }
    
    func setupRequestViewController() {
        
        //create the flow layout for the request collection view
        let requestFlowLayout = UICollectionViewFlowLayout()
        requestFlowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        
        //create the request collection view for the inbox
        self.requestCollectionView = RequestCollectionView(frame: self.view.frame, collectionViewLayout: requestFlowLayout)
        
        //register the cells for the request collection view
        self.requestCollectionView?.register(RequestCell.self, forCellWithReuseIdentifier: "RequestCell")
        
        //set its flow layout delegate and data source as itself (implemented by it already)
        self.requestCollectionView?.dataSource = self.requestCollectionView
        self.requestCollectionView?.delegate = self.requestCollectionView
        
        //add the collection view to the controller's view
        self.requestCollectionView?.backgroundColor = .clear
        self.view.addSubview(self.requestCollectionView!)
        
        //set its auto layout constraints
        self.requestCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        self.requestCollectionView?.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.requestCollectionView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.requestCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.requestCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
    }
    
}
