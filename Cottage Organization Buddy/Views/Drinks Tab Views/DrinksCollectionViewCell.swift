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
    }
    
    func initializeDrinksCell(forSection index: Int) {
        
        //set up the cells label
        let cellTitleLabel = UILabel()
        cellTitleLabel.text = cellTitle!
        cellTitleLabel.textAlignment = .center
        
        self.contentView.addSubview(cellTitleLabel)
        cellTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        cellTitleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellTitleLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4).isActive = true
        cellTitleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellTitleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
        //set up the cells image
        let cellImage: UIImage
        
        switch(index) {
        case 0:
            cellImage = UIImage(systemName: "person.3")!
        case 1:
            cellImage = UIImage(systemName: "drop")!
        default:
            cellImage = UIImage(systemName: "drop")!
        }
        let cellImageView = UIImageView(image: cellImage.withRenderingMode(.alwaysOriginal))
        cellImageView.contentMode = .scaleAspectFit
        
        self.contentView.addSubview(cellImageView)
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        cellImageView.topAnchor.constraint(equalTo: cellTitleLabel.bottomAnchor).isActive = true
        cellImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        cellImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        cellImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }

}
