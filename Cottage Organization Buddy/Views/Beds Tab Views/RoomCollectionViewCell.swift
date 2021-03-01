//
//  BedCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-10-26.
//

import UIKit

class RoomCollectionViewCell: UICollectionViewCell {
    
    var cellsRoomModel: Room?
    
    //view objects to place in the cell
    var bedImageView = UIImageView()
    var roomLabel = UILabel()
    var disclosureButton = UIButton()
        
    var indexPath: IndexPath!
    var isExpanded: Bool = false
    
    var expandCellDelegate: ExpandedBedCollectionViewCellDelegate!
    
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
        roomLabel.text = "Room #" + String(indexPath.row + 1)
        roomLabel.textAlignment = .center
        roomLabel.backgroundColor = .green
        roomLabel.textColor = .black
        
        //set the cell's content constraints
        setLabelConstraints()
        setImageConstraints()
        setDisclosureButton()
        if isExpanded == true {
            setExpandableSection()
        }
        
    }
    
    func setLabelConstraints() {
        
        self.contentView.addSubview(roomLabel)
        
        //add the constraints to the label
        roomLabel.translatesAutoresizingMaskIntoConstraints = false
        roomLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        if isExpanded == true {
            roomLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25/1.5).isActive = true
        }
        else {
            roomLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        }
        roomLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
    }
    
    func setImageConstraints() {
        
        self.contentView.addSubview(bedImageView)
        //add constraints
        bedImageView.translatesAutoresizingMaskIntoConstraints = false
        bedImageView.topAnchor.constraint(equalTo: self.roomLabel.bottomAnchor).isActive = true
        if isExpanded == true {
            bedImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5/1.5).isActive = true
        }
        else {
            bedImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.5).isActive = true
        }
        bedImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        bedImageView.contentMode = .scaleAspectFit
        
    }
    
    func setDisclosureButton() {
        
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
            disclosureButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25/1.5).isActive = true
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
        
        let bedStackView = UIStackView()
        bedStackView.axis = .vertical
        bedStackView.distribution = .fillEqually
        bedStackView.alignment = .center
        
        for bed in self.cellsRoomModel!.bedList {
            let bedLabel = UILabel()
            bedLabel.text = String(describing: bed.size)
            bedStackView.addArrangedSubview(bedLabel)
        }
        
        self.contentView.addSubview(bedStackView)
        bedStackView.translatesAutoresizingMaskIntoConstraints = false
        bedStackView.topAnchor.constraint(equalTo: bedImageView.bottomAnchor).isActive = true
        bedStackView.bottomAnchor.constraint(equalTo: disclosureButton.topAnchor).isActive = true
        bedStackView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
    }
    
    @objc func requestBedButtonPressed() {
        
        print("test")
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        //removes all children views from the cell before reusing a cell
        for cell in self.contentView.subviews {
            cell.removeFromSuperview()
        }
        
    }
    
}

protocol ExpandedBedCollectionViewCellDelegate {
    
    func expandButtonTouched(indexPath: IndexPath)
    
}
