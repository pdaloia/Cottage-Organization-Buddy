//
//  InvitedCottagesCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-11.
//

import UIKit

class InvitedCottagesCollectionView: UICollectionView {
    
    var invitedCottages: [CottageInfo]?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension InvitedCottagesCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return invitedCottages!.count
        default:
            return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        collectionView.register(CottageCollectionViewCell.self, forCellWithReuseIdentifier: "CottageCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CottageCell", for: indexPath) as! CottageCollectionViewCell
        
        cell.layer.cornerRadius = 10
        cell.cottageInfo = self.invitedCottages![indexPath.item]
        cell.initializeContent()
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat
        let width: CGFloat
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let topAndBottomInsetHeight = layout.sectionInset.top + layout.sectionInset.bottom
        
        let numberOfRows: CGFloat = 8
        
        let spaceBetweenRows = (numberOfRows - 1) * layout.minimumLineSpacing
        let calculatedHeight = collectionView.bounds.height - topAndBottomInsetHeight - spaceBetweenRows
        
        width = collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left
        
        height = calculatedHeight / numberOfRows
        
        return CGSize(width: width, height: height)
        
    }
    
}
