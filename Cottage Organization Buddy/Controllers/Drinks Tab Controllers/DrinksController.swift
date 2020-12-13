//
//  DrinksController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class DrinksController: UIViewController, DrinksCollectionViewDelegate, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Drinks"
        
        self.view.backgroundColor = .systemBackground
        
        initializeDrinksCollectionView()
    }
    
    func initializeDrinksCollectionView() {
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        
        let drinksView = DrinksCollectionView(frame: self.view.frame, collectionViewLayout: layout)
        drinksView.dataSource = drinksView
        drinksView.delegate = drinksView
        drinksView.cottageModel = self.cottageModel
        drinksView.drinksListDelegate = self
        
        drinksView.register(DrinksCollectionViewCell.self, forCellWithReuseIdentifier: "DrinksCell")
        
        drinksView.backgroundColor = .clear
        
        self.view.addSubview(drinksView)
        drinksView.translatesAutoresizingMaskIntoConstraints = false
        drinksView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        drinksView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        drinksView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        drinksView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        
    }
    
    func displayGroceryList(controller: DrinkListController) {
        
        self.navigationController?.pushViewController(controller, animated: true)
        
    }

}
