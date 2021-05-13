//
//  LandingPageView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-28.
//

import UIKit

class LandingPageView: UIView {
    
    var userCottages: [CottageInfo]?
    
    var cottageCollectionView: CottageCollectionView?
    var landingPageViewDelegate: LandingPageViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeCollectionView() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 3, bottom: 10, right: 3)
        flowLayout.itemSize = CGSize(width: 60, height: 60)
        
        cottageCollectionView = CottageCollectionView(frame: self.frame, collectionViewLayout: flowLayout)
        cottageCollectionView!.backgroundColor = .clear
        
        cottageCollectionView!.dataSource = cottageCollectionView.self
        cottageCollectionView!.delegate = cottageCollectionView.self
        cottageCollectionView!.cottageCollectionViewDelegate = self
        cottageCollectionView!.userCottages = self.userCottages
        
        self.addSubview(cottageCollectionView!)
        cottageCollectionView!.translatesAutoresizingMaskIntoConstraints = false
        cottageCollectionView!.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        cottageCollectionView!.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        cottageCollectionView!.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        cottageCollectionView!.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
    }
    
}

extension LandingPageView: CottageCollectionViewDelegate{
    
    func cottageCellPressed(for id: String) {
        if let delegate = self.landingPageViewDelegate {
            delegate.cottageCellPressed(for: id)
        }
    }
    
    func newCottageCellPressed() {
        if let delegate = self.landingPageViewDelegate {
            delegate.newCottageCellPressed()
        }
    }
    
}

protocol LandingPageViewDelegate {
    
    func cottageCellPressed(for cottageID: String)
    
    func newCottageCellPressed()
    
}
