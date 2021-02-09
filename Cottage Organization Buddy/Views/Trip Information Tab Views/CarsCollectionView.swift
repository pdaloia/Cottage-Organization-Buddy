//
//  CarsCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-02-08.
//

import UIKit

class CarsCollectionView: UICollectionView {

    var cottageModel: CottageTrip?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
        
        return CGSize(width: width, height: height)
        
    }
    
    //handling the seleciton of a cell
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //retrieve the selected car cell
        let selectedCarCell = collectionView.cellForItem(at: indexPath) as! CarCollectionViewCell
        
    }
    
}
