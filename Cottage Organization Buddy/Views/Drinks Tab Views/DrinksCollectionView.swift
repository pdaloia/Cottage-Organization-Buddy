//
//  DrinksCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-12.
//

import UIKit

class DrinksCollectionView: UICollectionView {

    var cottageModel: CottageTrip?
    
    var drinksListDelegate: DrinksCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension DrinksCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cottageModel!.drinksList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinksCell", for: indexPath) as! DrinksCollectionViewCell
        
        currentCell.layer.cornerRadius = 10
        currentCell.backgroundColor = .green
            
        switch indexPath.section {
        case 0:
            currentCell.cellTitle = "Shared Drinks List"
        case 1:
            currentCell.cellTitle = cottageModel!.drinksList[indexPath.row].person.name + "'s list"
        default:
            currentCell.cellTitle = "Error"
        }
        
        currentCell.initializeDrinksCell()
        
        return currentCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat
        let width: CGFloat
        
        let numberOfRows: CGFloat = 4
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let topAndBottomInsetHeight = layout.sectionInset.top + layout.sectionInset.bottom
        let spaceBetweenRows = (numberOfRows - 1) * layout.minimumLineSpacing
        let calculatedHeight = collectionView.bounds.height - topAndBottomInsetHeight - spaceBetweenRows
        
        height = calculatedHeight / numberOfRows
        
        switch(indexPath.section) {
        case 0:
            width = collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left
        case 1:
            width = (collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left - layout.minimumInteritemSpacing) / 2
        default:
            width = collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left
        }
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let drinkListController = DrinkListController()
        
        switch(indexPath.section) {
        case 0:
            drinkListController.drinksToDisplay = cottageModel?.returnSharedDrinksList()
            drinkListController.title = "Shared Drinks"
        case 1:
            drinkListController.drinksToDisplay = cottageModel?.drinksList[indexPath.item].drinkNames
            drinkListController.title = "\(cottageModel?.drinksList[indexPath.item].person.name ?? "Error")'s list"
        default:
            drinkListController.drinksToDisplay = []
        }
        
        drinksListDelegate?.displayGroceryList(controller: drinkListController)
    }
            
}
