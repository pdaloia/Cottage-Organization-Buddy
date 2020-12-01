//
//  BedsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class BedsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?

    @IBOutlet weak var bedsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Beds"
        
        bedsCollectionView.dataSource = self
        bedsCollectionView.delegate = self
    }

}

extension BedsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cottageModel!.bedsList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BedCell", for: indexPath) as! BedCollectionViewCell
        
        bedCell.cellsBedModel = cottageModel!.bedsList[indexPath.item]
        bedCell.setupBedCell()
        
        return bedCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        
        var width: CGFloat
        var height: CGFloat
        
        let widthOfCollection = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        
        let adjustedWidth = widthOfCollection - spaceBetweenCells
        
        width = floor(adjustedWidth / columns)
        height = width
        
        return CGSize(width: width, height: height)
        
    }
    
}
