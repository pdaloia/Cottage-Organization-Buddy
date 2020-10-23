//
//  CarCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-23.
//

import UIKit

class CarCollectionViewCell: UICollectionViewCell {
    
    var carImage: UIImage?
    var title: String?
    var message: String?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1, height: 1)
        
    }
    
    func setup(carModel: Car) {
        
        //set the cell's properties according to the model
        self.title = "\(carModel.driver.name)'s car"
        self.carImage = UIImage(systemName: "car")
        
        //create and add the label for the text
        let cellLabel = UILabel(frame: CGRect.zero)
        cellLabel.frame.size = CGSize(width: self.frame.width, height: self.frame.height / 2)
        cellLabel.text = self.title
        cellLabel.textAlignment = .center
        cellLabel.textColor = .black
        cellLabel.backgroundColor = .gray
        contentView.addSubview(cellLabel)
        
        //create and add the image view for the image
        let carImageView = UIImageView(frame: CGRect(x: self.bounds.minX, y: self.bounds.midY, width: self.frame.width, height: self.frame.height/2))
        carImageView.frame.size = CGSize(width: self.frame.width, height: self.frame.height/2)
        carImageView.image = carImage
        contentView.addSubview(carImageView)
        
        contentView.backgroundColor = .black
        
    }
    
    override func prepareForReuse() {
        
        //removes all children views from the cell before reusing a cell
        for cell in self.contentView.subviews {
            cell.removeFromSuperview()
        }
        
    }
    
}
