//
//  AttendeesController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-19.
//

import UIKit
import FirebaseAuth

class TripInformationController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    var tripInformationCollectionView: TripInformationCollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Trip Info"
        
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
        initializeCollectionView()
        setupNavBarButtons()
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
    
    func setupNavBarButtons() {
        
        if self.cottageModel!.tripOrganiser.firebaseUserID == Auth.auth().currentUser!.uid {
            let inviteUsersButton = UIBarButtonItem(title: "Invite", style: .plain, target: self, action: #selector(inviteUsersButtonsPressed))
            self.navigationItem.rightBarButtonItem = inviteUsersButton
        }
        
    }
    
    @objc func inviteUsersButtonsPressed() {
        
        let inviteUsersVC = InviteUsersViewController()
        inviteUsersVC.cottageID = self.cottageModel!.cottageID
        
        self.present(inviteUsersVC, animated: true, completion: nil)
        
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
