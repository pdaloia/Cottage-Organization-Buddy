//
//  BedCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-26.
//

import UIKit

class BedCollectionViewCell: UICollectionViewCell {
    
    var cellsBedModel: Bed?
    
    //view objects to place in the cell
    var bedImageView = UIImageView()
    var bedSizeLabel = UILabel()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        layer.cornerRadius = 20
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    func setupBedCell() {
        
        //create the cell's bed image and place it in the image view
        let bedImage = UIImage(systemName: "bed.double")
        bedImageView.image = bedImage
        bedImageView.contentMode = .scaleAspectFit
        
        contentView.backgroundColor = .clear
        
        //set the label's contents
        bedSizeLabel.text = String(describing: cellsBedModel!.size)
        bedSizeLabel.textAlignment = .center
        bedSizeLabel.backgroundColor = .green
        if cellsBedModel!.checkIfBedAtRecommendedCapacity(bed: cellsBedModel!) {
            bedSizeLabel.textColor = .red
        }
        else {
            bedSizeLabel.textColor = .black
        }
        
        //set the cell's content constraints
        setImageConstraints()
        setLabelConstraints()
        
    }
    
    func setImageConstraints() {
        self.contentView.addSubview(bedImageView)
        bedImageView.translatesAutoresizingMaskIntoConstraints = false
        bedImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        bedImageView.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        bedImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }
    
    func setLabelConstraints() {
        self.contentView.addSubview(bedSizeLabel)
        bedSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        bedSizeLabel.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        bedSizeLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        bedSizeLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //removes all children views from the cell before reusing a cell
        for cell in self.contentView.subviews {
            cell.removeFromSuperview()
        }
        
    }
    
}
