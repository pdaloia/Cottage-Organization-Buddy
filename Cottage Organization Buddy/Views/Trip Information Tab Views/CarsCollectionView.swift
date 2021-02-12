//
//  CarsCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-02-08.
//

import UIKit

class CarsCollectionView: UICollectionView {

    var cottageModel: CottageTrip?
    
    var isExpanded = [Bool]()
    
    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, cellCount: Int) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        isExpanded = Array(repeating: false, count: cellCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CarsCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //number of items in section
    //since theres only one section, we return the count of cars
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cottageModel!.carsList.count
        
    }
    
    //cell for item at
    //we use our custom car collection view cell and dependency inject a car model into it
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCollectionViewCell
        
        //setup the cell with the information from the cottage model
        cell.cellsCarModel = cottageModel!.carsList[indexPath.item]
        cell.indexPath = indexPath
        cell.expandCellDelegate = self
        cell.isExpanded = isExpanded[indexPath.row]
        cell.carInformationView.currentlySelectedCarModel = cottageModel?.carsList[indexPath.row]
        cell.setup()
        
        return cell
        
    }
    
    //sizing function for the collection view cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                
        var height: CGFloat
        var width: CGFloat
        
        let numberOfRowsOnScreen: CGFloat = 4
        
        let collectionViewHeight = collectionView.bounds.height
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let verticalSpacing = layout.minimumLineSpacing * (numberOfRowsOnScreen - 1)
        let topAndBottomInset = layout.sectionInset.top + layout.sectionInset.bottom
        
        width = collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left
        height = (collectionViewHeight - verticalSpacing - topAndBottomInset) / numberOfRowsOnScreen
        
        if isExpanded[indexPath.row] == true {
            return CGSize(width: width, height: height * 2)
        }
        else {
            return CGSize(width: width, height: height)
        }
        
    }
    
}

extension CarsCollectionView: ExpandedCarCollectionViewCellDelegate {
    
    func expandButtonTouched(indexPath: IndexPath) {
        
        isExpanded[indexPath.row] = !isExpanded[indexPath.row]
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
              self.reloadItems(at: [indexPath])
            }, completion: { success in
                print("success")
        })
        
        
    }
        
}
