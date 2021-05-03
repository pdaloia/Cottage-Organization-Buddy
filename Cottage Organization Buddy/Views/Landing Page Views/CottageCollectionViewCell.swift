//
//  CottageCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-29.
//

import UIKit

class CottageCollectionViewCell: UICollectionViewCell {
    
    var cottageInfo: CottageInfo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeContent() {
        
        let label = UILabel()
        label.text = cottageInfo!.CottageName
        
        self.contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
}
