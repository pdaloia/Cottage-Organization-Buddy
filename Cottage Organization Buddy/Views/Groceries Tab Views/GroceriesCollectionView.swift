//
//  GroceriesCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-10.
//

import UIKit

class GroceriesCollectionView: UICollectionView {
    
    weak var controllerDelegate: GroceriesCollectionViewDelegate?
    
    var cottageModel: CottageTrip?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension GroceriesCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "Personal Groceries Lists"
        default:
            return nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return cottageModel!.groceryList.groceriesPerPerson.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroceriesCell", for: indexPath) as! GroceriesCollectionViewCell
        
        currentCell.backgroundColor = .green
        currentCell.layer.cornerRadius = 10
        
        switch indexPath.section {
        case 0:
            currentCell.cellTitle = "All Grocery Items"
        case 1:
            currentCell.cellTitle = cottageModel!.groceryList.groceriesPerPerson[indexPath.row].person.name + "'s grocery list"
        default:
            currentCell.cellTitle = "Error"
        }
        
        currentCell.setupGroceryCell(forSection: indexPath.section)
        
        return currentCell
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
        
        let groceryListController = GroceryListController()
        
        switch(indexPath.section) {
        case 0:
            groceryListController.groceryListToDisplay = self.cottageModel?.groceryList.allItems
            groceryListController.groceryListTitle = "All Items"
        case 1:
            groceryListController.groceryListToDisplay = self.cottageModel?.groceryList.groceriesPerPerson[indexPath.item].groceries
            groceryListController.groceryListTitle = "\(self.cottageModel?.groceryList.groceriesPerPerson[indexPath.item].person.name ?? "Error")'s List"
        default:
            groceryListController.groceryListToDisplay = []
        }
        
        if let del = self.controllerDelegate {
            del.displayGroceryList(controller: groceryListController)
        }
        
    }
    
}
