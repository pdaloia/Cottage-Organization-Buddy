//
//  DrinksTableViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-29.
//

import UIKit

class DrinksCollectionViewCell: UICollectionViewCell {
    
    var cellTitle: String?

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        self.contentView.backgroundColor = .green
        
    }
    
    func initializeDrinksCell() {
        
        let textLabel = UILabel()
        
        textLabel.text = cellTitle!
        
        self.contentView.addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
    }

}
