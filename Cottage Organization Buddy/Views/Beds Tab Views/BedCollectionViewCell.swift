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
    var disclosureButton = UIButton()
    
    var bedInformationView: BedInformationView?
    var requestSpotButton: UIButton?
    
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
        setLabelConstraints()
        setImageConstraints()
        setDisclosureButton()
        if isExpanded == true {
            setExpandableSection()
        }
        
    }
    
    func setLabelConstraints() {
        
        self.contentView.addSubview(bedSizeLabel)
        
        //add the constraints to the label
        bedSizeLabel.translatesAutoresizingMaskIntoConstraints = false
        bedSizeLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        if isExpanded == true {
            bedSizeLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25/1.5).isActive = true
        }
        else {
            bedSizeLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        }
        bedSizeLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
    }
    
    func setImageConstraints() {
        
        self.contentView.addSubview(bedImageView)
        //add constraints
        bedImageView.translatesAutoresizingMaskIntoConstraints = false
        bedImageView.topAnchor.constraint(equalTo: self.bedSizeLabel.bottomAnchor).isActive = true
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
        
        //add the car information view and initialize it with constraints
        bedInformationView = BedInformationView(bedModel: cellsBedModel!)
        
        contentView.addSubview(bedInformationView!)
        
        bedInformationView!.translatesAutoresizingMaskIntoConstraints = false
        bedInformationView!.topAnchor.constraint(equalTo: bedImageView.bottomAnchor).isActive = true
        bedInformationView!.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.2).isActive = true
        bedInformationView!.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
        
        //create the request button
        requestSpotButton = UIButton()
        requestSpotButton?.setTitle("Request Bed", for: .normal)
        requestSpotButton?.setTitleColor(.systemBlue, for: .normal)
        requestSpotButton?.addTarget(self, action: #selector(requestBedButtonPressed), for: .touchUpInside)
        
        self.contentView.addSubview(requestSpotButton!)
        requestSpotButton?.translatesAutoresizingMaskIntoConstraints = false
        requestSpotButton?.topAnchor.constraint(equalTo: bedInformationView!.bottomAnchor).isActive = true
        requestSpotButton?.bottomAnchor.constraint(equalTo: disclosureButton.topAnchor).isActive = true
        requestSpotButton?.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
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
