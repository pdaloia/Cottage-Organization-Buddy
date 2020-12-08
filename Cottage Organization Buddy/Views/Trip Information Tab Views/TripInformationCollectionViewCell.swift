//
//  TripInformationCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-06.
//

import UIKit

class TripInformationCollectionViewCell: UICollectionViewCell {
        
    var cottageModel: CottageTrip?
    var rowNumber: Int?
    var cellInformationTitle: String?
    
    let cellTitle = UILabel()
    let informationData = UILabel()
    var infoImageView: UIImageView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupInformationCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupInformationCell() {
        
        //stack view to place in the cell. bottom stack view is for picture and data, while the horizontal stack view is to add all components for the cell
        let horizontalStackView = UIStackView()
        let bottomStackView = UIStackView()
        
        setImage()
        
        //labels for the title and data of cell
        cellTitle.textAlignment = .center
        
        //setup the bottom stack view which we will place in the horizontal stack view
        bottomStackView.axis = .horizontal
        bottomStackView.addArrangedSubview(infoImageView!)
        bottomStackView.addArrangedSubview(informationData)
        bottomStackView.distribution = .fillProportionally
        
        //configure the horizontal stack view
        horizontalStackView.axis = .vertical
        horizontalStackView.addArrangedSubview(cellTitle)
        cellTitle.translatesAutoresizingMaskIntoConstraints = false
        cellTitle.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/4).isActive = true
        horizontalStackView.addArrangedSubview(bottomStackView)
        horizontalStackView.distribution = .fill
        
        //horizontal stack view constraints
        self.contentView.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        horizontalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        
    }
    
    func setImage() {
        
        var image: UIImage
        
        //image view for the cell's image
        switch(rowNumber) {
        case 0:
            image = UIImage(systemName: "house")!
        case 1:
            image = UIImage(systemName: "person")!
        case 2:
            image = UIImage(systemName: "calendar")!
        case 3:
            image = UIImage(systemName: "person.3")!
        default:
            image = UIImage(systemName: "xmark.octagon")!
        }
       
        infoImageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        infoImageView!.contentMode = .scaleAspectFit
        infoImageView!.backgroundColor = .clear
        
    }
    
    func setCellValues() {
        
        cellTitle.text = cellInformationTitle
        
        switch(rowNumber) {
        case 0:
            informationData.text = cottageModel?.tripName
        case 1:
            informationData.text = cottageModel?.tripOrganiser.name
        case 2:
            informationData.text = "\(cottageModel?.startDate.description ?? "Error") - \(cottageModel?.endDate.description ?? "Error")"
        case 3:
            informationData.text = "Number of Attendees: \(cottageModel?.attendeesList.count.description ?? "Error")"
        default:
            informationData.text = "Error"
        }
        
    }
    
}

extension TripInformationCollectionViewCell {
    
    
    
}
