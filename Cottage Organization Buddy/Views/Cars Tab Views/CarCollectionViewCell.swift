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
    var disclosureButton = UIButton()
    
    var carInformationView: CarInformationView?
    var requestSpotButton: UIButton?
    
    var indexPath: IndexPath!
    var isExpanded: Bool = false
    
    var expandCellDelegate: ExpandedCarCollectionViewCellDelegate!
    
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
        setExpandButtonConstraints()
        if isExpanded == true {
            setExpandableSection()
        }
        
    }
    
    func setLabelConstraints() {
        //set up cell label properties
        cellLabel.text = String(describing: cellsCarModel!.driver.name) + "'s car"
        cellLabel.textAlignment = .center
        cellLabel.textColor = .black
        cellLabel.backgroundColor = .green
        
        //add the cell label to the cell
        contentView.addSubview(cellLabel)
        
        //add the constraints to the label
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        if isExpanded == true {
            cellLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.125).isActive = true
        }
        else {
            cellLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        }
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
        carImageView.topAnchor.constraint(equalTo: self.cellLabel.bottomAnchor).isActive = true
        if isExpanded == true {
            carImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        }
        else {
            carImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        }
        carImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        carImageView.contentMode = .scaleAspectFit
                
    }
    
    func setExpandButtonConstraints() {
        
        if isExpanded == true {
            disclosureButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
        }
        else {
            disclosureButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        }
        disclosureButton.addTarget(self, action: #selector(expandButtonPressed), for: .touchUpInside)
        
        contentView.addSubview(disclosureButton)
        
        disclosureButton.translatesAutoresizingMaskIntoConstraints = false
        disclosureButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        if isExpanded == true {
            disclosureButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.125).isActive = true
        }
        else {
            disclosureButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        }
        disclosureButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
    }
    
    @objc func expandButtonPressed() {
    
        if let delegate = self.expandCellDelegate{
            delegate.expandButtonTouched(indexPath: indexPath)
        }
    
    }
    
    func setExpandableSection() {
        
        //add the car information view and initialize it with constraints
        carInformationView = CarInformationView(carModel: cellsCarModel!)
        
        contentView.addSubview(carInformationView!)
        
        carInformationView!.translatesAutoresizingMaskIntoConstraints = false
        carInformationView!.topAnchor.constraint(equalTo: carImageView.bottomAnchor).isActive = true
        carInformationView!.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.4).isActive = true
        carInformationView!.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
        //create the request button
        requestSpotButton = UIButton()
        requestSpotButton?.setTitle("Request Spot", for: .normal)
        requestSpotButton?.setTitleColor(.systemBlue, for: .normal)
        requestSpotButton?.addTarget(self, action: #selector(requestCarSpotButtonPressed), for: .touchUpInside)
        
        self.contentView.addSubview(requestSpotButton!)
        requestSpotButton?.translatesAutoresizingMaskIntoConstraints = false
        requestSpotButton?.topAnchor.constraint(equalTo: carInformationView!.bottomAnchor).isActive = true
        requestSpotButton?.bottomAnchor.constraint(equalTo: disclosureButton.topAnchor).isActive = true
        requestSpotButton?.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
    }
    
    @objc func requestCarSpotButtonPressed() {
        
        if let delegate = self.expandCellDelegate {
            delegate.requestSpot(in: self.cellsCarModel!)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //removes all children views from the cell before reusing a cell
        for cell in self.contentView.subviews {
            cell.removeFromSuperview()
        }
        
    }
    
}

protocol ExpandedCarCollectionViewCellDelegate {
    
    func expandButtonTouched(indexPath: IndexPath)
    
    func requestSpot(in car: Car)
    
}
