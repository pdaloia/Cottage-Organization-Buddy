//
//  BedCollectionView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-02-25.
//

import UIKit

class RoomCollectionView: UICollectionView {
    
    var cottageModel: CottageTrip?
    
    var isExpanded = [Bool]()

    init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout, cellCount: Int) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        isExpanded = Array(repeating: false, count: cellCount)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RoomCollectionView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return cottageModel!.roomsList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let bedCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BedCell", for: indexPath) as! RoomCollectionViewCell
        
        bedCell.expandCellDelegate = self
        bedCell.cellsRoomModel = cottageModel!.roomsList[indexPath.item]
        bedCell.cottageModel = cottageModel!
        bedCell.indexPath = indexPath
        bedCell.isExpanded = isExpanded[indexPath.row]
        bedCell.setupBedCell()
        
        return bedCell
        
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
        
        if isExpanded[indexPath.row] == true {
            return CGSize(width: width, height: height + ( (height / 4) * CGFloat(cottageModel!.roomsList[indexPath.row].bedDict.count) ) )
        }
        else {
            return CGSize(width: width, height: height)
        }
        
    }
    
}

extension RoomCollectionView: ExpandedBedCollectionViewCellDelegate {
    
    func expandButtonTouched(indexPath: IndexPath) {
        
        isExpanded[indexPath.row] = !isExpanded[indexPath.row]
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: UIView.AnimationOptions.curveEaseInOut, animations: {
              self.reloadItems(at: [indexPath])
            }, completion: { success in
                print("success")
        })
        
    }
        
}
