//
//  TripInformationView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-06.
//

import UIKit

class TripInformationCollectionView: UICollectionView {
    
    var cottageModel: CottageTrip?
    
    let tripInformationItems = ["Trip Name", "Trip Organiser", "Trip Dates", "Attendees"]

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension TripInformationCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return tripInformationItems.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "TripInformationCell", for: indexPath)
        
        currentCell.backgroundColor = .green
        currentCell.layer.cornerRadius = 20
        
        return currentCell
        
    }
    
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
    
}
