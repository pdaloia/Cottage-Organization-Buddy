//
//  TripInformationCollectionViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-06.
//

import UIKit

class TripInformationCollectionViewCell: UICollectionViewCell {
        
    var cottageModel: CottageTrip?
    
    private let tripInformationItems = ["Trip Organiser", "Cottage Address", "Trip Dates", "Attendees"]
    
    var cellDataLabel: UILabel?
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(forCell index: Int) {
        
        // cell rounded section
        self.layer.cornerRadius = 15.0
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        
        //create the cell's custom content view and constrain it to entire cell
        let customContentView = UIView()
        self.contentView.addSubview(customContentView)
        customContentView.translatesAutoresizingMaskIntoConstraints = false
        customContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        customContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        customContentView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor).isActive = true
        customContentView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
                
        //get the cells contents by its index number
        let cellsContents = getCellContents(forCell: index)
        let image = cellsContents.0
        let titleLabel = cellsContents.1
        titleLabel.backgroundColor = .green
        let dataLabel = cellsContents.2
        
        //setup the image and image view
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysOriginal))
        imageView.backgroundColor = .clear
        
        //set the picture and data in another view to go below the title
        let bottomView = UIView()
        bottomView.addSubview(imageView)
        bottomView.addSubview(dataLabel)
        
        //add the title label and bottom custom view to the custom view of the cell
        titleLabel.textAlignment = .center
        customContentView.addSubview(titleLabel)
        customContentView.addSubview(bottomView)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: customContentView.topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: self.contentView.bounds.height/4).isActive = true
        bottomView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: customContentView.bottomAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: customContentView.trailingAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: customContentView.leadingAnchor).isActive = true
        
        //set the bottom view's constraints
        imageView.translatesAutoresizingMaskIntoConstraints = false
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor).isActive = true
        imageView.contentMode = .scaleAspectFit
        dataLabel.topAnchor.constraint(equalTo: bottomView.topAnchor).isActive = true
        dataLabel.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor).isActive = true
        dataLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10).isActive = true
        dataLabel.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor).isActive = true
        customContentView.layoutIfNeeded()
        imageView.widthAnchor.constraint(equalToConstant: imageView.bounds.height).isActive = true
        
    }
    
    func getCellContents(forCell index: Int) -> (UIImage, UILabel, UILabel) {
        
        let cellsImage: UIImage
        let cellsTitle = UILabel()
        let cellsData = UILabel()
        
        //get the cells image depending on the index
        switch(index){
        case 0:
            cellsImage = UIImage(systemName: "person")!
            cellsData.text = cottageModel?.tripOrganiser.name
        case 1:
            cellsImage = UIImage(systemName: "house")!
            cellsData.text = cottageModel?.address
        case 2:
            cellsImage = UIImage(systemName: "calendar")!
            cellsData.text = "\(cottageModel?.startDate.description ?? "Error") - \(cottageModel?.endDate.description ?? "Error")"
        case 3:
            cellsImage = UIImage(systemName: "person.3")!
            cellsData.text = "Number of Attendees: \(cottageModel?.attendeesList.count.description ?? "Error")"
        default:
            cellsImage = UIImage(systemName: "xmark.octagon")!
            cellsData.text = "Error"
        }
        
        //get the cells title and data based on the index
        cellsTitle.text = tripInformationItems[index]
        
        return (cellsImage, cellsTitle, cellsData)
        
    }
    
}
