//
//  CottageCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-04-29.
//

import UIKit

class CottageCollectionViewCell: UICollectionViewCell {
    
    var cottageInfo: CottageInfo?
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .green
        
        self.contentView.addSubview(label)
        label.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeContent() {
        
        label.text = cottageInfo!.CottageName
        
    }
    
}
