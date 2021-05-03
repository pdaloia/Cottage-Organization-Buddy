//
//  CottageCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-28.
//

import UIKit

class CottageCollectionView: UICollectionView {

    var userCottages: [CottageInfo]?
    
    var cottageCollectionViewDelegate: CottageCollectionViewDelegate?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CottageCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
            case 0:
                return 1
            case 1:
                return self.userCottages!.count
            default:
                return 0
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            collectionView.register(NewCottageCollectionViewCell.self, forCellWithReuseIdentifier: "NewCottageCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCottageCell", for: indexPath) as! NewCottageCollectionViewCell
            cell.layer.cornerRadius = 10
            return cell
        case 1:
            collectionView.register(CottageCollectionViewCell.self, forCellWithReuseIdentifier: "CottageCell")
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CottageCell", for: indexPath) as! CottageCollectionViewCell
            cell.layer.cornerRadius = 10
            cell.cottageInfo = userCottages![indexPath.row]
            cell.initializeContent()
            return cell
        default:
            let cell = UICollectionViewCell()
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat
        let width: CGFloat
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        
        let topAndBottomInsetHeight = layout.sectionInset.top + layout.sectionInset.bottom
        
        var numberOfRows: CGFloat = 0
        
        switch(indexPath.section) {
        case 0:
            numberOfRows = 4
        case 1:
            numberOfRows = 8
        default:
            numberOfRows = 0
        }
        
        let spaceBetweenRows = (numberOfRows - 1) * layout.minimumLineSpacing
        let calculatedHeight = collectionView.bounds.height - topAndBottomInsetHeight - spaceBetweenRows
        
        width = collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left
        
        height = calculatedHeight / numberOfRows
        
        return CGSize(width: width, height: height)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if let delegate = cottageCollectionViewDelegate {
                delegate.newCottageCellPressed()
            }
        case 1:
            if let delegate = cottageCollectionViewDelegate {
                delegate.cottageCellPressed(for: self.userCottages![indexPath.row].CottageID)
            }
        default:
            return
        }
        
    }
    
}

protocol CottageCollectionViewDelegate {
    
    func cottageCellPressed(for id: String)
    
    func newCottageCellPressed()
    
}
