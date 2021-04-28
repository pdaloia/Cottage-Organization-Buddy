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
        
        self.view.backgroundColor = .systemBackground
        
        initializeCollectionView()
    }
    
    func initializeCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        tripInformationCollectionView = TripInformationCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        tripInformationCollectionView?.cottageModel = cottageModel
        
        tripInformationCollectionView?.isScrollEnabled = false
        
        tripInformationCollectionView?.register(TripInformationCollectionViewCell.self, forCellWithReuseIdentifier: "TripInformationCell")
        
        tripInformationCollectionView?.delegate = tripInformationCollectionView
        tripInformationCollectionView?.dataSource = tripInformationCollectionView
        tripInformationCollectionView?.tripInformationDelegate = self
        
        tripInformationCollectionView?.backgroundColor = .clear
        view.addSubview(tripInformationCollectionView!)
        
        tripInformationCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        tripInformationCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        tripInformationCollectionView?.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tripInformationCollectionView?.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
    }
    
}

extension TripInformationController: TripInformationDelegate, AttendeesViewDataSource {
    
    func displayAttendeesView() {
        
        let attendeesViewController = AttendeesViewController()
        attendeesViewController.attendeesDataSource = self
        
        self.navigationController?.pushViewController(attendeesViewController, animated: true)
        
    }
    
    func setAttendees() -> [Attendee] {
        
        return self.cottageModel!.attendeesList
        
    }
    
}
