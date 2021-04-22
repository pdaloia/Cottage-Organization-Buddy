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
        
        createNavBarButtons()
        
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
    
    func createNavBarButtons() {
        
        if UserService.checkIfOrganiser(model: self.cottageModel!) {
            let addRoomButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addRoomButtonPressed))
            self.navigationItem.rightBarButtonItems = [addRoomButton]
        }
        
    }
    
    @objc func addRoomButtonPressed() {
        
        let addRoomVC = AddRoomViewController()
        addRoomVC.addRoomDelegate = self
        self.navigationController?.pushViewController(addRoomVC, animated: true)
        
    }

}


extension BedsController: AddRoomDelegate {
    
    func addRoom(kings: Int, queens: Int, doubles: Int, singles: Int) {
        
        //create the dict of beds in the room
        var newRoomBedsDict = [String : Int]()
        newRoomBedsDict["Singles"] = singles
        newRoomBedsDict["Doubles"] = doubles
        newRoomBedsDict["Queens"] = queens
        newRoomBedsDict["Kings"] = kings
        
        //create the room and append it to the model, reload the collection view to refresh
        let roomToAdd = Room(bedDict: newRoomBedsDict)
        self.cottageModel!.roomsList.append(roomToAdd)
        self.roomCollectionView!.isExpanded.append(false)
        self.roomCollectionView!.reloadData()
        
        //firestore add
        let firestoreService = FirestoreServices()
        firestoreService.add(room: roomToAdd, to: self.cottageModel!.cottageID)
        
        //pop the add room view from the nav controller
        self.navigationController?.popViewController(animated: true)
        
    }
    
}
