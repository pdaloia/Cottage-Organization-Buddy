//
//  BedsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class BedsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?

    var roomCollectionView: RoomCollectionView?
    
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
        
        roomCollectionView = RoomCollectionView(frame: self.view.frame, collectionViewLayout: flowLayout, cellCount: cottageModel!.roomsList.count)
        roomCollectionView?.cottageModel = self.cottageModel
        
        roomCollectionView?.register(RoomCollectionViewCell.self, forCellWithReuseIdentifier: "BedCell")
        
        roomCollectionView?.dataSource = roomCollectionView.self
        roomCollectionView?.delegate = roomCollectionView.self
        
        roomCollectionView?.backgroundColor = .clear
        view.addSubview(roomCollectionView!)
        
        roomCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        roomCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        roomCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        roomCollectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }

}
