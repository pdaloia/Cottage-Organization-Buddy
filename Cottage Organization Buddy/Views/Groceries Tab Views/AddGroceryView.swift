//
//  AddGroceryView.swift
//  Cottage Organization Buddy
//
//  Created by Philip D'Aloia on 2020-12-16.
//

import UIKit

class AddGroceryView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.backgroundColor = .systemBackground
        
        initializeView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initializeView() {
        
        //create the text input fields
        let groceryNameInput = UITextField()
        let pricePerGroceryInput = UITextField()
        let quantityOfGroceryInput = UITextField()
        
        //configure input boxes
        groceryNameInput.placeholder = "Enter name of grocery"
        
        //add these text fields to the
        self.addSubview(groceryNameInput)
        groceryNameInput.translatesAutoresizingMaskIntoConstraints = false
        groceryNameInput.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        groceryNameInput.heightAnchor.constraint(equalToConstant: 50).isActive = true
        groceryNameInput.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        groceryNameInput.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        
        groceryNameInput.backgroundColor = .green
        groceryNameInput.borderStyle = .roundedRect
        
        
    }
    
}
