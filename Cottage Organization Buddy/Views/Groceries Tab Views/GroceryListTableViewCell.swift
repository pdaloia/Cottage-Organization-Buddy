//
//  GroceryListTableViewCell.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2021-05-27.
//

import UIKit

class GroceryListTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var cellsGroceryModel: Grocery?
    
    //MARK: - Views
    
    let groceryLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .green
        return label
    }()
    
    let quantityLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let assignedUserLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let quantityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(systemName: "cart.fill.badge.plus")
        imageView.image = image
        return imageView
    }()
    
    let assignedToImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(systemName: "person.fill")
        imageView.image = image
        return imageView
    }()
    
    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Functions
    
    func setCellsContents() {
        
        //set the text of the labels
        self.groceryLabel.text = self.cellsGroceryModel!.productName
        self.quantityLabel.text = String(self.cellsGroceryModel!.quantity)
        
        if self.cellsGroceryModel?.assignedTo == "" {
            self.assignedUserLabel.text = "Unassigned"
        }
        else{
            self.assignedUserLabel.text = self.cellsGroceryModel!.assignedTo
        }
        
        //add all views to the content view
        self.contentView.addSubview(groceryLabel)
        self.contentView.addSubview(assignedToImageView)
        self.contentView.addSubview(assignedUserLabel)
        self.contentView.addSubview(quantityImageView)
        self.contentView.addSubview(quantityLabel)
        
        //set the constraints for the subviews
        groceryLabel.translatesAutoresizingMaskIntoConstraints = false
        groceryLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        groceryLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 20).isActive = true
        groceryLabel.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        
        assignedToImageView.translatesAutoresizingMaskIntoConstraints = false
        assignedToImageView.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        assignedToImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        assignedToImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 10).isActive = true
        assignedToImageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        
        assignedUserLabel.translatesAutoresizingMaskIntoConstraints = false
        assignedUserLabel.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        assignedUserLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        assignedUserLabel.leadingAnchor.constraint(equalTo: self.assignedToImageView.trailingAnchor, constant: 10).isActive = true
        assignedUserLabel.trailingAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        
        quantityImageView.translatesAutoresizingMaskIntoConstraints = false
        quantityImageView.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        quantityImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        quantityImageView.leadingAnchor.constraint(equalTo: self.contentView.centerXAnchor, constant: 10).isActive = true
        quantityImageView.widthAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.25).isActive = true
        
        quantityLabel.translatesAutoresizingMaskIntoConstraints = false
        quantityLabel.topAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
        quantityLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        quantityLabel.leadingAnchor.constraint(equalTo: self.quantityImageView.trailingAnchor, constant: 10).isActive = true
        quantityLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor).isActive = true
        
    }
    
}
