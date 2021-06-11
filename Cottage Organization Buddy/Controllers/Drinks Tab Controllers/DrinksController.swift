//
//  DrinksController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit
import FirebaseAuth

class DrinksController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    var drinksView: DrinksCollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Drinks"
        
        self.view.backgroundColor = UIColor(named: "Cottage Green Tertiary")
        
        initializeDrinksCollectionView()
        createNavBarButtons()
    }
    
    func initializeDrinksCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        
        drinksView = DrinksCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        drinksView!.dataSource = drinksView
        drinksView!.delegate = drinksView
        drinksView!.cottageModel = self.cottageModel
        drinksView!.drinksListDelegate = self
        
        drinksView!.register(DrinksCollectionViewCell.self, forCellWithReuseIdentifier: "DrinksCell")
        
        drinksView!.backgroundColor = .clear
        
        self.view.addSubview(drinksView!)
        drinksView!.translatesAutoresizingMaskIntoConstraints = false
        drinksView!.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        drinksView!.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        drinksView!.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        drinksView!.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    func createNavBarButtons() {
        
        let addButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonPressed))
        self.navigationItem.rightBarButtonItem = addButton
        
    }
    
    @objc func addButtonPressed() {
        
        let addDrinkVC = AddDrinkViewController()
        addDrinkVC.drinkUploadDelegate = self
        
        self.navigationController?.pushViewController(addDrinkVC, animated: true)
        
    }
    
}

extension DrinksController: DrinksCollectionViewDelegate, AddDrinkToModelDelegate {
    
    func upload(drink: Drink) {
        
        //add the drink to the model
        let currentUser: Attendee = self.cottageModel!.attendeesList.first(where: { $0.firebaseUserID == Auth.auth().currentUser!.uid })!
        if self.cottageModel!.drinksList[currentUser] == nil {
            self.cottageModel!.drinksList[currentUser] = []
        }
        self.cottageModel!.drinksList[currentUser]!.append(drink)
        
        //add the drink to the users list in firestore
        let firestoreService = FirestoreServices()
        firestoreService.add(drink: drink, for: Auth.auth().currentUser!.uid, in: self.cottageModel!.cottageID)
        
    }
    
    func displayGroceryList(controller: DrinkListController) {
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

}
