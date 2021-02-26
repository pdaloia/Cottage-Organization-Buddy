//
//  BedsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class BedsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?

    var bedsCollectionView: BedCollectionView?
    var bedInformationView = BedInformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Beds"
        
        self.view.backgroundColor = .systemBackground
        
        setupBedCollectionView()
        
    }
    
    func setupBedCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        flowLayout.itemSize = CGSize(width: 60, height: 60)
        
        bedsCollectionView = BedCollectionView(frame: self.view.frame, collectionViewLayout: flowLayout)
        bedsCollectionView?.cottageModel = self.cottageModel
        
        bedsCollectionView?.register(BedCollectionViewCell.self, forCellWithReuseIdentifier: "BedCell")
        
        bedsCollectionView?.dataSource = bedsCollectionView.self
        bedsCollectionView?.delegate = bedsCollectionView.self
        
        bedsCollectionView?.backgroundColor = .clear
        view.addSubview(bedsCollectionView!)
        
        bedsCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        bedsCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        bedsCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bedsCollectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }

}
