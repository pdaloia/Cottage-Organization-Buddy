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
            let multiplier: CGFloat = CGFloat(Float(1) / Float(4 + cellsRoomModel!.bedDict.count))
            roomLabel.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: multiplier).isActive = true
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
            let multiplier: CGFloat = CGFloat(Float(1) / Float(4 + cellsRoomModel!.bedDict.count)) * 2
            bedImageView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: multiplier).isActive = true
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
            let multiplier: CGFloat = CGFloat(Float(1) / Float(4 + cellsRoomModel!.bedDict.count))
            disclosureButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: multiplier).isActive = true
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
        
        //adding the bed labels into a stack view
        let bedLabelStackView = UIStackView()
        bedLabelStackView.axis = .vertical
        bedLabelStackView.distribution = .fillEqually
        bedLabelStackView.alignment = .trailing
        
        let singleBedLabel = UILabel()
        singleBedLabel.text = "Singles: "
        bedLabelStackView.addArrangedSubview(singleBedLabel)
        
        let doubleBedLabel = UILabel()
        doubleBedLabel.text = "Doubles: "
        bedLabelStackView.addArrangedSubview(doubleBedLabel)
        
        let queenBedLabel = UILabel()
        queenBedLabel.text = "Queens: "
        bedLabelStackView.addArrangedSubview(queenBedLabel)
        
        let kingBedLabel = UILabel()
        kingBedLabel.text = "Kings: "
        bedLabelStackView.addArrangedSubview(kingBedLabel)
        
        self.contentView.addSubview(bedLabelStackView)
        bedLabelStackView.translatesAutoresizingMaskIntoConstraints = false
        bedLabelStackView.topAnchor.constraint(equalTo: bedImageView.bottomAnchor).isActive = true
        bedLabelStackView.bottomAnchor.constraint(equalTo: disclosureButton.topAnchor).isActive = true
        bedLabelStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bedLabelStackView.trailingAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        //adding the bed count labels into a stack view
        let bedCountStackView = UIStackView()
        bedCountStackView.axis = .vertical
        bedCountStackView.distribution = .fillEqually
        bedCountStackView.alignment = .leading
        
        let singleCountLabel = UILabel()
        singleCountLabel.text = String(self.cellsRoomModel!.bedDict["Singles"] ?? 0)
        bedCountStackView.addArrangedSubview(singleCountLabel)
        
        let doubleCountLabel = UILabel()
        doubleCountLabel.text = String(self.cellsRoomModel!.bedDict["Doubles"] ?? 0)
        bedCountStackView.addArrangedSubview(doubleCountLabel)
        
        let queenCountLabel = UILabel()
        queenCountLabel.text = String(self.cellsRoomModel!.bedDict["Queens"] ?? 0)
        bedCountStackView.addArrangedSubview(queenCountLabel)
        
        let kingCountLabel = UILabel()
        kingCountLabel.text = String(self.cellsRoomModel!.bedDict["Kings"] ?? 0)
        bedCountStackView.addArrangedSubview(kingCountLabel)
        
        self.contentView.addSubview(bedCountStackView)
        bedCountStackView.translatesAutoresizingMaskIntoConstraints = false
        bedCountStackView.topAnchor.constraint(equalTo: bedImageView.bottomAnchor).isActive = true
        bedCountStackView.bottomAnchor.constraint(equalTo: disclosureButton.topAnchor).isActive = true
        bedCountStackView.leadingAnchor.constraint(equalTo: self.centerXAnchor, constant: 10).isActive = true
        bedCountStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
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
