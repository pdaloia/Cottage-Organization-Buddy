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
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath)
        
        let carImageView = UIImageView(image: UIImage(systemName: "car"))
        carImageView.frame = cell.contentView.bounds
        carImageView.center = CGPoint(x: cell.bounds.width/2, y: cell.bounds.height/2)
        carImageView.contentMode = .scaleAspectFit
        cell.addSubview(carImageView)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let columns: CGFloat = 2
        
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (columns - 1)
        
        let adjustedWidth = collectionViewWidth - spaceBetweenCells
        
        let width: CGFloat = floor(adjustedWidth / columns)
        let height: CGFloat = width
        
        return CGSize(width: width, height: height)
        
    }
    
}
