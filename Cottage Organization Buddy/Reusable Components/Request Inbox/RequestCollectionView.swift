//
//  RequestCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-01-31.
//

import UIKit

class RequestCollectionView: UICollectionView {
    
    //requests to be displayed in the inbox
    var requestList: [RequestProtocol]?
    
    //delegates
    var requestCollectionDelegate: RequestCollectionViewDelegate?

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RequestCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let itemCount = self.requestList?.count {
            return itemCount
        }
        return 0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RequestCell", for: indexPath) as! RequestCell
        currentCell.request = requestList?[indexPath.item]
        currentCell.setupRequestLabel()
        currentCell.buttonsDelegate = self
        
        return currentCell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat
        var width: CGFloat
        
        let numberOfRowsOnScreen: CGFloat = 8
        
        let collectionViewHeight = collectionView.bounds.height
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let verticalSpacing = layout.minimumLineSpacing * (numberOfRowsOnScreen - 1)
        let topAndBottomInset = layout.sectionInset.top + layout.sectionInset.bottom
        
        width = collectionView.bounds.width - layout.sectionInset.right - layout.sectionInset.left
        height = (collectionViewHeight - verticalSpacing - topAndBottomInset) / numberOfRowsOnScreen
        
        return CGSize(width: width, height: height)
        
    }
    
}

extension RequestCollectionView: RequestCellButtonsDelegate {
    
    func acceptButtonClicked(request: RequestProtocol) {
        
        requestCollectionDelegate?.accept(request: request)
        
    }
    
    func declineButtonClicked(request: RequestProtocol) {
        
        requestCollectionDelegate?.decline(request: request)
        
    }
    
}

protocol RequestCollectionViewDelegate {
    
    func accept(request: RequestProtocol)
    
    func decline(request: RequestProtocol)
    
}
