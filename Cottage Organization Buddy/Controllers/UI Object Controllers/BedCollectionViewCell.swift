//
//  BedCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-26.
//

import UIKit

class BedCollectionViewCell: UICollectionViewCell {
    
    var cellsBedModel: Bed?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.backgroundColor = .black
        
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
}
