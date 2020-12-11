//
//  GroceriesController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class GroceriesController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    var groceriesCollectionView: GroceriesCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Groceries"
        
        self.view.backgroundColor = .systemBackground
        
        initializeCollectionView()
    }
    
    func initializeCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        groceriesCollectionView = GroceriesCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        groceriesCollectionView?.cottageModel = cottageModel
        
        groceriesCollectionView?.register(GroceriesCollectionViewCell.self, forCellWithReuseIdentifier: "GroceriesCell")
        
        groceriesCollectionView?.delegate = groceriesCollectionView
        groceriesCollectionView?.dataSource = groceriesCollectionView
        
        groceriesCollectionView?.backgroundColor = .clear
        view.addSubview(groceriesCollectionView!)
        
        groceriesCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        groceriesCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        groceriesCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        groceriesCollectionView?.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        groceriesCollectionView?.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }

}
