//
//  CarsController.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-18.
//

import UIKit

class CarsController: UIViewController, TabBarItemControllerProtocol {
    
    var cottageModel: CottageTrip?
    
    @IBOutlet weak var carsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        carsCollectionView.dataSource = self
        carsCollectionView.delegate = self
        
    }
    
}

extension CarsController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cottageModel!.carsList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath) as! CarCollectionViewCell
        
        //setup the cell with the information from the cottage model
        cell.setup(carModel: cottageModel!.carsList[indexPath.item])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //create the amount of desired rows
        let rows: CGFloat = 2
        
        //create and calculate the dimensions for the cell size
        let collectionViewHeight = collectionView.bounds.height
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (rows - 1)
        
        let adjustedHeight = collectionViewHeight - spaceBetweenCells
        
        let height: CGFloat = floor(adjustedHeight / rows)
        let width: CGFloat = height
        
        return CGSize(width: width, height: height)
        
    }
    
}
