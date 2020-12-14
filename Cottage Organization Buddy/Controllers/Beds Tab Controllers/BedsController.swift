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
    var bedInformationView = BedInformationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Beds"
        
        bedsCollectionView.dataSource = self
        bedsCollectionView.delegate = self
        
        setupBedInformationView()
        
    }
    
    func setupBedInformationView() {
        
        self.view.addSubview(bedInformationView)
        
        bedInformationView.translatesAutoresizingMaskIntoConstraints = false
        bedInformationView.topAnchor.constraint(equalTo: bedsCollectionView.bottomAnchor).isActive = true
        bedInformationView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bedInformationView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bedInformationView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        bedInformationView.intializeView()
        
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
        
        //create the amount of desired rows
        let rows: CGFloat
        let columns: CGFloat
        switch(collectionView.numberOfItems(inSection: indexPath.section)) {
        case 0..<3:
            rows = 1
            columns = 1
        default:
            rows = 2
            columns = 2
            
        }
        
        //create and calculate the dimensions for the cell size
        let collectionViewHeight = collectionView.bounds.height
        let collectionViewWidth = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let spaceBetweenRows = (flowLayout.minimumLineSpacing * (rows - 1)) + flowLayout.sectionInset.top + flowLayout.sectionInset.bottom
        let spaceBetweenCellsInRow = (flowLayout.minimumInteritemSpacing * (columns - 1)) + flowLayout.sectionInset.right + flowLayout.sectionInset.left
        
        let adjustedHeight = collectionViewHeight - spaceBetweenRows
        let adjustedWidth = collectionViewWidth - spaceBetweenCellsInRow
        
        let height: CGFloat = floor(adjustedHeight / rows)
        let width: CGFloat = floor(adjustedWidth / rows)
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let selectedBedModel = cottageModel?.bedsList[indexPath.item]
        
        bedInformationView.bedModelToDisplay = selectedBedModel
        
        bedInformationView.updateBedInformationToDisplay()
        
    }
    
}
