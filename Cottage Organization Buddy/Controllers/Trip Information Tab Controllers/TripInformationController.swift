//
//  AttendeesController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import UIKit

class TripInformationController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    var tripInformationCollectionView: TripInformationCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Trip Info"
        
        initializeCollectionView()
    }
    
    func initializeCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        tripInformationCollectionView = TripInformationCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        tripInformationCollectionView?.isScrollEnabled = false
        
        tripInformationCollectionView?.register(TripInformationCollectionViewCell.self, forCellWithReuseIdentifier: "TripInformationCell")
        tripInformationCollectionView?.backgroundColor = .yellow
        
        tripInformationCollectionView?.delegate = tripInformationCollectionView
        tripInformationCollectionView?.dataSource = tripInformationCollectionView
        
        view.addSubview(tripInformationCollectionView!)
        
        tripInformationCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        tripInformationCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tripInformationCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tripInformationCollectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
    
}
