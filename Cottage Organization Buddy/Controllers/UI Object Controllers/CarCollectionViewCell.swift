//
//  CarCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-23.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell {
    
    var cellsCarModel: Car?
    
    var carImageView = UIImageView()
    var cellLabel = UILabel()
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    func setup() {
        
        contentView.backgroundColor = .clear
        
        setLabelConstraints()
        setImageViewConstraints()
        
    }
    
    func setLabelConstraints() {
        //set up cell label properties
        cellLabel.text = String(describing: cellsCarModel!.driver.name) + "'s car"
        cellLabel.textAlignment = .center
        cellLabel.textColor = .black
        cellLabel.backgroundColor = .gray
        
        //add the cell label to the cell
        contentView.addSubview(cellLabel)
        
        //add the constraints to the label
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        cellLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
    }
    
    func setImageViewConstraints() {
        //create the car image
        let carImage = UIImage(systemName: "car")
        //add to the cell
        carImageView.image = carImage
        contentView.addSubview(carImageView)
        
        //add constraints
        carImageView.translatesAutoresizingMaskIntoConstraints = false
        carImageView.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        carImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        carImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        carImageView.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //removes all children views from the cell before reusing a cell
        for cell in self.contentView.subviews {
            cell.removeFromSuperview()
        }
        
    }
    
}
